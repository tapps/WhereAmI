//
//  TPAnnotation.h
//  WhereAmI
//
//  Created by René Retz on 17/02/10.
//  Copyright 2010 Tapps. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface TPAnnotation : NSObject <MKAnnotation>{ 
	NSString *_title, *_subTitle; 
	CLLocationCoordinate2D _coordinate;
} 
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate; 
@property (nonatomic, readonly) NSString *title; 
@property (nonatomic, readonly) NSString *subtitle; 
-(id)initWithTitle:(NSString*)theTitle subTitle:(NSString*)theSubTitle andCoordinate:(CLLocationCoordinate2D) theCoordinate;
@end