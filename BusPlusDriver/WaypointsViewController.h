//
//  WaypointsViewController.h
//  BusPlusDriver
//
//  Created by Aubrey Goodman on 11/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface WaypointsViewController : UIViewController <MKMapViewDelegate>

@property (strong) IBOutlet MKMapView* mapView;
@property (strong) IBOutlet UIBarButtonItem* onDutyLabel;

@end
