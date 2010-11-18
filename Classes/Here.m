//
//  Here.m
//  WhereAmI
//
//  Created by Rene Retz on 17/11/10.
//  Copyright 2010 Tapps. All rights reserved.
//

#import "Here.h"
#import <AddressBookUI/ABAddressFormatting.h>

@implementation Here

@synthesize locManager = _locManager;
@synthesize geocoder = _geocoder;
@synthesize annotation = _annotation;

- (void)dealloc {
	[_locManager release];
	[_geocoder release];
	[_annotation release];
    [super dealloc];
}

#pragma mark -

- (void)updatePlacemarkDisplays:(MKPlacemark *)placemark {
	UILabel *place = (UILabel *)[self.view viewWithTag:50];
	
	NSString *here = ABCreateStringWithAddressDictionary(placemark.addressDictionary, YES);
	place.text = here;
	
	MKMapView *mapView = (MKMapView *)[self.view viewWithTag:60];
	if (_annotation)
		[mapView removeAnnotation:_annotation];
	_annotation = [[TPAnnotation alloc] initWithTitle:here subTitle:nil andCoordinate:placemark.coordinate];
	[mapView  addAnnotation:_annotation];
	
	MKCoordinateRegion region;
	region.center = placemark.coordinate;
	region.span.longitudeDelta = 0.01f;
	region.span.latitudeDelta = 0.01f;
	[mapView setRegion:region];	
}

- (void)updatePositionsDisplays:(CLLocation *)newLocation  {
	// If it's a relatively recent event, turn off updates to save power 
	NSDate *eventDate = newLocation.timestamp; 
	NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
	
	if (abs(howRecent) < 15.0) {
		UILabel *lat = (UILabel *)[self.view viewWithTag:30];
		lat.text = [NSString stringWithFormat:@"%+.6f", newLocation.coordinate.latitude];
		
		UILabel *lng = (UILabel *)[self.view viewWithTag:40];
		lng.text = [NSString stringWithFormat:@"%+.6f", newLocation.coordinate.longitude];
	}
	
	if (!self.geocoder) {
		_geocoder = [[MKReverseGeocoder alloc] initWithCoordinate:newLocation.coordinate];
		_geocoder.delegate = self;
		[_geocoder start];
	}
}

- (void)updateHeadingDisplays:(CLLocationDirection)currentHeading {
	UILabel *angle = (UILabel *)[self.view viewWithTag:10];
	angle.text = [NSString stringWithFormat:@"%.0f", currentHeading];
	
	UIImageView *imageView = (UIImageView *)[self.view viewWithTag:20];
	imageView.transform = CGAffineTransformMakeRotation(currentHeading*2*M_PI/360);
}

#pragma mark -

- (void)startEvents { 
	if (!self.locManager) {
		_locManager = [[CLLocationManager alloc] init];
		_locManager.delegate = self;
	}
	
	if (!_locManager.locationServicesEnabled) {
		NSLog(@"Location Services Disabled!");
		return;
	}
	
	_locManager.distanceFilter = kCLDistanceFilterNone; 
	_locManager.desiredAccuracy = kCLLocationAccuracyBest; 
	[_locManager startUpdatingLocation];
	
	// Start heading updates. 
	if ([_locManager headingAvailable]) {
		_locManager.headingFilter = 1; 
		[_locManager startUpdatingHeading];
	}
}

- (void)stopEvents {
	if (self.locManager) {
		[_locManager stopUpdatingLocation];
		[_locManager stopUpdatingHeading];
		self.locManager = nil;
	}
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	[self updatePositionsDisplays: newLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
	if (newHeading.headingAccuracy < 0) return;
	
	// Use the true heading if it is valid. 
	CLLocationDirection theHeading = ((newHeading.trueHeading > 0) ? newHeading.trueHeading : newHeading.magneticHeading);
	[self updateHeadingDisplays:theHeading];
}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager {
	return YES;
}

#pragma mark -
#pragma mark MKReverseGeocoderDelegate

- (void)reverseGeocoder:(MKReverseGeocoder*)geocoder didFindPlacemark:(MKPlacemark*)place {
	
	[self updatePlacemarkDisplays:place];
}

- (void)reverseGeocoder:(MKReverseGeocoder*)geocoder didFailWithError:(NSError*)error {
    NSLog(@"Could not retrieve the specified place information.\n");
}

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
	[self startEvents];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	[self stopEvents];		
}

@end
