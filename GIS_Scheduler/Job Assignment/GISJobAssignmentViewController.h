//
//  GISJobAssignmentViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 22/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISAppDelegate.h"

@interface GISJobAssignmentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISplitViewControllerDelegate>
{
    IBOutlet UITableView *jobAssignment_tableView;
    IBOutlet UIView *dashBoard_UIView;
    
    GISAppDelegate *appDelegate;
    
    IBOutlet UILabel *from_answer_Label;
    IBOutlet UILabel *to_answer_Label;
    IBOutlet UILabel *typeOfService_answer_Label;
    IBOutlet UILabel *chooseRequest_ID_answer_Label;
    
    IBOutlet UIView *segment_UIView;
    IBOutlet UIView *table_UIView;
    
    UISegmentedControl *segment_filled_Unfilled;
    
}
@property(nonatomic,strong) NSString *view_string;

@property(nonatomic,readwrite) BOOL isMasterHide;


-(IBAction)filterMore_ButtonPressed:(id)sender;
-(IBAction)searchButton_Oressed:(id)sender;

@end
