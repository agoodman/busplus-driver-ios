//
//  SeatCell.h
//  BusPlusDriver
//
//  Created by Aubrey Goodman on 11/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeatCell : UITableViewCell

@property (strong) IBOutlet UILabel* seatLabel;
@property (strong) IBOutlet UIStepper* stepper;

-(IBAction)stepperChanged:(id)sender;

@end
