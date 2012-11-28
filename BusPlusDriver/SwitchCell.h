//
//  SwitchCell.h
//  BusPlusDriver
//
//  Created by Aubrey Goodman on 11/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchCell : UITableViewCell

@property (strong) IBOutlet UISwitch* onDuty;

-(IBAction)switchChanged:(id)sender;

@end
