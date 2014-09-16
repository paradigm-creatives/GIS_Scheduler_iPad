//
//  GISAddUpdateJobsViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 09/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISAppDelegate.h"
@interface GISAddUpdateJobsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    GISAppDelegate *appDelegate;
    IBOutlet UITableView *addUpdateJobs_tableView;
}
-(IBAction)pickerButtonPressed:(id)sender;
-(IBAction)closeButtonPressed:(id)sender;
-(IBAction)saveButtonPressed:(id)sender;
@end
