//
//  GISFindRequestJobsViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 04/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISAppDelegate.h"
@interface GISFindRequestJobsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    GISAppDelegate *appDelegate;
    IBOutlet UITableView *findReqJobs_tableView;
    IBOutlet UILabel *requestId_label;
    IBOutlet UILabel *requestId_Answer_label;
}
-(IBAction)pickerButtonPressed:(id)sender;
-(IBAction)search_ButtonPressed:(id)sender;
-(IBAction)weekDays_ButtonPressed:(id)sender;
@end
