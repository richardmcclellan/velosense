//
//  DirectionsViewController.h
//  BTHandlebars
//
//  Created by Richard McClellan on 2/23/13.
//  Copyright (c) 2013 Richard McClellan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VeloManager.h"
#import "GMapsHttpClient.h"
#import "DirectionLeg.h"
#import "GenericDevice.h"
#import "nBlue.h"

@interface DirectionsViewController : UIViewController <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate, nBlueDelegate> {
    UISearchDisplayController *searchController;
    DirectionLeg *directionLeg;
    GenericDevice *device;
    BOOL left_sig;
    BOOL right_sig;
    nBlue *nb;
}

@property (nonatomic, strong) UISearchDisplayController *searchController;

- (id) initWithDevice:(GenericDevice *)aDevice;

@end
