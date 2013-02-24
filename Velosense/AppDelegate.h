//
//  AppDelegate.h
//  BTHandlebars
//
//  Created by Richard McClellan on 2/23/13.
//  Copyright (c) 2013 Richard McClellan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UIViewController *rootViewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UIViewController *rootViewController;
@end
