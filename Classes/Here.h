//
//  Here.h
//  WhereAmI
//
//  Created by Rene Retz on 17/11/10.
//  Copyright 2010 Tapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "TPAnnotation.h"


@interface Here : UIViewController <CLLocationManagerDelegate, MKReverseGeocoderDelegate> {
	CLLocationManager *_locManager;
	MKReverseGeocoder *_geocoder;
	TPAnnotation *_annotation;
}

@property (nonatomic, retain) CLLocationManager *locManager;
@property (nonatomic, retain) MKReverseGeocoder *geocoder;
@property (nonatomic, retain) TPAnnotation *annotation;

@end
