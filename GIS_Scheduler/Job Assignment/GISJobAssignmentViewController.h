//
//  GISJobAssignmentViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 22/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISAppDelegate.h"
#import "GISPopOverTableViewController.h"
#import "GISBaseViewController.h"

@interface GISJobAssignmentViewController : GISBaseViewController<UITableViewDataSource,UITableViewDelegate,UISplitViewControllerDelegate,UIPopoverControllerDelegate,PopOverSelected_Protocol>
{
    IBOutlet UITableView *jobAssignment_tableView;
    IBOutlet UIView *dashBoard_UIViews;
    
    GISAppDelegate *appDelegate;
    
    IBOutlet UILabel *from_answer_Label;
    IBOutlet UILabel *to_answer_Label;
    IBOutlet UILabel *typeOfService_answer_Label;
    IBOutlet UILabel *chooseRequest_ID_answer_Label;
    
    IBOutlet UIView *segment_UIView;
    IBOutlet UIView *table_UIView;
    
    IBOutlet UISegmentedControl *segment_filled_Unfilled;
    
    UIPopoverController *popover;
    int btnTag;
    
    NSMutableArray *chooseRequest_mutArray;
    
    NSString *startDate_str;
    NSString *endDate_str;
    NSString *typeServiceID_str;
    NSMutableArray *typeOfservice_mutArray;
}


@property(nonatomic,strong) NSString *view_string;

@property(nonatomic,readwrite) BOOL isMasterHide;


-(IBAction)filterMore_ButtonPressed:(id)sender;
-(IBAction)searchButton_Pressed:(id)sender;
-(IBAction)segment_filled_Unfilled_ValueChanged:(id)sender;
-(IBAction)pickerButton_pressed:(id)sender;

-(IBAction)listOfServiceProviders_ButtonPressed:(id)sender;
@end
