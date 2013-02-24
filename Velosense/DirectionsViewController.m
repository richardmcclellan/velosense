//
//  DirectionsViewController.m
//  BTHandlebars
//
//  Created by Richard McClellan on 2/23/13.
//  Copyright (c) 2013 Richard McClellan. All rights reserved.
//

#import "DirectionsViewController.h"

@implementation DirectionsViewController

@synthesize searchController;

- (id) initWithDevice:(GenericDevice *)aDevice {
    if((self = [super initWithNibName:nil bundle:nil])) {
        device = aDevice;
        self.title = @"VeloSense";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [device connect:[nBlue shared_nBlue:self]];    //Connect the device and set nBlueDelegate to this controller

    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	[searchBar setDelegate:self];
	[self.view addSubview:searchBar];
    
	self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
	[self.searchController setDelegate:self];
    self.searchController.searchBar.showsCancelButton = NO;
    [self.searchController setSearchResultsDelegate:self];
	[self.searchController setSearchResultsDataSource:self];
    [self.searchController.searchBar setPlaceholder:@"Enter a destination"];
    [self.searchController.searchBar setClipsToBounds:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    nb = [nBlue shared_nBlue:self];  //Set the nBlueDelegate to this controller everytime this view appears
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [device disconnect];  //Disconnect device if view is disappearing
	[super viewWillDisappear:animated];
}

#pragma mark -
#pragma mark UISearchDisplayDelegate
- (void) searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView {

}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView {

}

- (void)searchDisplayController:(UISearchDisplayController *)controller willUnloadSearchResultsTableView:(UITableView *)tableView {
//	[self.operationQueue cancelAllOperations];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
	return NO;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    directionLeg = nil;
	[self.searchController.searchResultsTableView reloadData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    if(![searchBar.text isEqualToString:@""]) {
        [self fetchResultsForDestination:searchBar.text];
    }
}

- (void) fetchResultsForDestination:(NSString *)destination {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[[VeloManager sharedManager] currentLocationString] forKey:@"origin"];
    [params setObject:destination forKey:@"destination"];
    [params setObject:@"true" forKey:@"sensor"];
    [params setObject:@"bicycling" forKey:@"mode"];
    [[GMapsHttpClient sharedClient] getPath:@"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([responseObject[@"status"] isEqualToString:@"OK"]) {
            NSLog(@"Response: %@", responseObject[@"routes"][0][@"legs"]);
            directionLeg =[[DirectionLeg alloc] initWithDictionary:responseObject[@"routes"][0][@"legs"][0]];
            [self.searchController.searchResultsTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        }
    } failure:^(AFHTTPRequestOperation *operation , NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


#pragma mark -
#pragma mark UITableViewDelegate and UITableViewDataSource

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return directionLeg.steps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"LegCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    DirectionStep  *step = directionLeg.steps[indexPath.row];
    cell.textLabel.text = step.textInstructions;
    cell.textLabel.numberOfLines = 0;
    cell.detailTextLabel.text = step.distanceText;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    DirectionStep *step = directionLeg.steps[indexPath.row];
    if ([step isLeft]) {
        NSLog(@"left");
        [device LED8control:YES];
        [self performSelector:@selector(turnOffLED8) withObject:nil afterDelay:1.0];
    } else if([step isRight]) {
        NSLog(@"right");
        [device LED7control:YES];
        [self performSelector:@selector(turnOffLED7) withObject:nil afterDelay:1.0];
    } else {
        NSLog(@"no direction");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void) turnOffLED8 {
    [device LED8control:NO];
}

- (void) turnOffLED7 {
    [device LED7control:NO];
}

@end
