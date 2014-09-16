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
    
}

-(IBAction)nextButtonPressed:(id)sender;
-(IBAction)pickerButtonPressed:(id)sender;
-(void)editButtonPressed:(id)sender;
-(void)deleteButtonPressed:(id)sender;
-(IBAction)addNewJob_buttonPressed:(id)sender;

-(IBAction)jobHistory_TitleButtonPressed:(id)sender;
@end
