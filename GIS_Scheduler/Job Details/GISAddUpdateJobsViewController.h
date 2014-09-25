//
//  GISAddUpdateJobsViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 09/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISAppDelegate.h"
#import "GISPopOverTableViewController.h"
#import "GISAddUpdateObject.h"

@interface GISAddUpdateJobsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPopoverControllerDelegate,PopOverSelected_Protocol>
{
    GISAppDelegate *appDelegate;
    IBOutlet UITableView *addUpdateJobs_tableView;
    
    UIPopoverController *popover;
    int btnTag;
    
    GISAddUpdateObject *addUpdateObj;
    
    NSMutableArray *callInTime_Array;
    NSMutableArray *payLevel_Array;
    NSMutableArray *typeOfserviceProvider_Array;
    NSMutableArray *serviceProvider_ID_Array;
    NSMutableArray *cancelled_Array;
    NSMutableArray *payType_Array;
    NSMutableArray *parking_Array;
    NSMutableArray *billAmt_Array;
    NSMutableArray *mileage_Array;
    NSMutableArray *invoice_Array;
    NSMutableArray *amtpaid_Array;
    NSMutableArray *billDate_Array;
    NSMutableArray *agencyFee_Array;
    NSMutableArray *payStatus_Array;
    NSMutableArray *expStatus_Array;
}
-(IBAction)pickerButtonPressed:(id)sender;
-(IBAction)closeButtonPressed:(id)sender;
-(IBAction)saveButtonPressed:(id)sender;

-(IBAction)radioButton_Pressed:(id)sender;
@end