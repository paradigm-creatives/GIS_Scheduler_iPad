//
//  GISAttendeesViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISAttendeesObject.h"
#import "GISAttendees_ListObject.h"
#import "GISAppDelegate.h"
#import "GISLoginDetailsObject.h"
#import "GISPopOverTableViewController.h"
#import "GISLoginDetailsObject.h"
@interface GISAttendeesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPopoverControllerDelegate,PopOverSelected_Protocol>
{
    GISAttendeesObject *attendeesObject;
    GISAttendees_ListObject *attendees_ListObject;
    GISAppDelegate *appDelegate;
    UITextField *currentTextField;
    IBOutlet UITableView *attendees_tableView;
    
    UIPopoverController *popover;
    
    int btnTag;
    NSMutableArray *expectedNo_mutArray;
    NSMutableArray *expectedNo_ID_mutArray;
    
    
    NSMutableArray *genderPreference_mutArray,*genderPreference_ID_Array;
    NSMutableArray *preference_mutArray;
    NSMutableArray *modeofcommunication_mutArray;
    NSMutableArray *directly_utilizedServices_mutArray;
    NSMutableArray *servicesNeeded_mutArray;
    NSMutableArray *primaryAudience_mutArray;
    
    int expectedNo_selectedRow;
    int genderPreference_selectedRow;
    int preference_selectedRow;
    int modeofcommunication_selectedRow;
    int directly_utilizedServices_selectedRow;
    int servicesNeeded_selectedRow;
    int  primaryAudience_selectedRow;
    
    GISLoginDetailsObject *login_Obj;
    
}

@property (nonatomic,strong) UIPopoverController *popover_controller;

@property(nonatomic,strong)IBOutlet UITableView *attendees_tableView;
-(IBAction)pickerButtonPressed:(id)sender;
@end
