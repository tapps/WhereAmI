//
//  TPAnnotation.m
//  WhereAmI
//
//  Created by René Retz on 17/02/10.
//  Copyright 2010 Tapps. All rights reserved.
//

#import "TPAnnotation.h"

@implementation TPAnnotation 

@synthesize coordinate=_coordinate, title=_title, subtitle=_subTitle;

-(id)initWithTitle:(NSString*)theTitle subTitle:(NSString*)theSubTitle andCoordinate:(CLLocationCoordinate2D) theCoordinate{
	if(self = [super init]){ 
		_title = [theTitle copy]; 
		_subTitle = [theSubTitle copy]; 
		_coordinate = theCoordinate;
	} 
	return self;
} 

-(void)dealloc{
	[_title release]; 
	[_subTitle release];
	[super dealloc];
}
@end