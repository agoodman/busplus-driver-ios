//
//  SessionAuthViewController.h
//  BusPlusDriver
//
//  Created by Aubrey Goodman on 11/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SessionAuthViewController : UIViewController <UITextFieldDelegate,RKObjectLoaderDelegate>

@property (strong) NSString* email;
@property (strong) IBOutlet UILabel* label;
@property (strong) IBOutlet UITextField* textField;
@property (strong) IBOutlet UIBarButtonItem* doneButton;

-(IBAction)doneButtonPressed:(id)sender;

@end
