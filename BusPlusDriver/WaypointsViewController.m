//
//  WaypointsViewController.m
//  BusPlusDriver
//
//  Created by Aubrey Goodman on 11/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import "WaypointsViewController.h"


@interface WaypointsViewController ()

@end

@implementation WaypointsViewController

@synthesize mapView = _mapView, onDutyLabel = _onDutyLabel;

- (void)updateUI
{
    self.onDutyLabel.title = [[NSUserDefaults standardUserDefaults] boolForKey:@"OnDuty"] ? @"YES" : @"NO";    
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI) name:@"SettingsChanged" object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    Driver* tDriver = [Driver findFirst];
    if( !tDriver ) {
        [self performSegueWithIdentifier:@"CreateSession" sender:self];
    }
    
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
}

@end
