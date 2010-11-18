//
//  WhereAmIAppDelegate.h
//  WhereAmI
//
//  Created by Rene Retz on 17/11/10.
//  Copyright 2010 Tapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhereAmIAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UIViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIViewController *viewController;

@end
