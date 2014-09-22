//
//  GISJobDetailsViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 18/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISPopOverTableViewController.h"
#import "GISAppDelegate.h"
#import "GISLoginDetailsObject.h"
@interface GISJobDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPopoverControllerDelegate,PopOverSelected_Protocol>
{
    IBOutlet UITableView *jobDetails_tableView;
    
    UIPopoverController *popover;
    int btnTag;
    
    NSMutableArray *serviceProvider_Array;
    NSMutableArray *filled_Unfilled_Array;
        NSMutableArray *jobDetails_Array;
    
    GISAppDelegate *appDelegate;

    GISLoginDetailsObject *login_Obj;
    int selected_row;
    NSString *typeOfservice_temp_string;
    NSString *serviceProvider_temp_string;
    NSString *payType_temp_string;
    BOOL isDelete;
    int currentObjTag_toDelete;
    IBOutlet UIView *jobChangeHistory_background_UIView;
     IBOutlet UIView *jobChangeHistory_foreground_UIView;
    
    IBOutlet UIView *createJobs_UIVIew;
    IBOutlet UIView *createJobs_Middle_UIVIew;
    IBOutlet UITableView *createJObs_tableView;
    
    IBOutlet UITextField *noOfServiceProviders_TextField;
    IBOutlet UILabel *typeOfServiceProvidersLabel;
    IBOutlet UILabel *payLevel_Label;
    IBOutlet UILabel *billLevel_Label;
    NSMutableDictionary *createJobsCheckDictionary;
    BOOL isAlljobs_Checked;
    IBOutlet UIButton *alljobs_Checked_button;
    NSMutableArray *detail_mut_array;
}
@property(nonatomic,strong)NSMutableArray *detail_mut_array;
-(IBAction)createJobsButton_Pressed:(id)sender;
-(IBAction)cancelButtonPressed_CreateJobs:(id)sender;
-(IBAction)doneButtonPressed_CreateJobs:(id)sender;
-(IBAction)checkAllJobs_buttonPressed:(id)sender;

-(IBAction)nextButtonPressed:(id)sender;
-(IBAction)pickerButtonPressed:(id)sender;
-(void)editButtonPressed:(id)sender;
-(void)deleteButtonPressed:(id)sender;
-(IBAction)addNewJob_buttonPressed:(id)sender;

-(IBAction)jobHistory_TitleButtonPressed:(id)sender;
@end
