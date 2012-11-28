//
//  SettingsViewController.m
//  BusPlusDriver
//
//  Created by Aubrey Goodman on 11/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import "SettingsViewController.h"
#import "SwitchCell.h"
#import "SeatCell.h"


@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (IBAction)doneButtonPressed:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:@"SettingsChanged" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Vehicle settings can only be edited when not on duty.";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.row==0 ) {
        static NSString *sSwitchCellIdentifier = @"SwitchCell";
        SwitchCell* cell = (SwitchCell*)[tableView dequeueReusableCellWithIdentifier:sSwitchCellIdentifier forIndexPath:indexPath];
    
        BOOL tOnDuty = [[NSUserDefaults standardUserDefaults] boolForKey:@"OnDuty"];
        cell.onDuty.on = tOnDuty;
        
        return cell;
    }else{
        static NSString *sSeatCellIdentifier = @"SeatCell";
        SeatCell* cell = (SeatCell*)[tableView dequeueReusableCellWithIdentifier:sSeatCellIdentifier forIndexPath:indexPath];
        
        int tSeats = [[NSUserDefaults standardUserDefaults] integerForKey:@"Seats"];
        cell.seatLabel.text = [NSString stringWithFormat:@"%d",tSeats];
        cell.stepper.value = tSeats;
        cell.stepper.enabled = ![[NSUserDefaults standardUserDefaults] boolForKey:@"OnDuty"];
        
        return cell;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
