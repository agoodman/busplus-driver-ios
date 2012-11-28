//
//  SessionStartViewController.h
//  BusPlusDriver
//
//  Created by Aubrey Goodman on 11/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SessionStartViewController : UIViewController <UITextFieldDelegate>

@property (strong) IBOutlet UILabel* label;
@property (strong) IBOutlet UITextField* textField;
@property (strong) IBOutlet UIBarButtonItem* nextButton;

-(IBAction)nextButtonPressed:(id)sender;

@end
