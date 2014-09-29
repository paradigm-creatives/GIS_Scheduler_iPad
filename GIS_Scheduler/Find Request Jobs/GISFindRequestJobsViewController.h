//
//  GISFindRequestJobsViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 04/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISAppDelegate.h"
#import "GISPopOverTableViewController.h"
#import "GISFindRequestJobsObject.h"

@interface GISFindRequestJobsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPopoverControllerDelegate,PopOverSelected_Protocol>
{
    GISAppDelegate *appDelegate;
    GISFindRequestJobsObject *findReqObj;
    
    UIPopoverController *popover;
    int btnTag;
    
    IBOutlet UITableView *findReqJobs_tableView;
    IBOutlet UILabel *requestId_label;
    IBOutlet UILabel *requestId_Answer_label;
    
    NSMutableArray *requestorType_array;
    NSMutableArray *requestor_array;
    NSMutableArray *registeredConsumers_array;
    NSMutableArray *generalLocation_array;
    NSMutableArray *eventType_array;
    NSMutableArray *payLevel_array;
    NSMutableArray *primaryAudience_array;
    NSMutableArray *model_array;
    NSMutableArray *serviceProviderType_array;
    NSMutableArray *serviceProvider_array;
    NSMutableArray *payType_array;
    NSMutableArray *billLevel_array;
    
}
-(IBAction)pickerButtonPressed:(id)sender;
-(IBAction)search_ButtonPressed:(id)sender;
-(IBAction)weekDays_ButtonPressed:(id)sender;
-(IBAction)radioButton_Pressed:(id)sender;
@end
