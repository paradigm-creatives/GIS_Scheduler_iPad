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
@interface GISAttendeesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    GISAttendeesObject *attendeesObject;
    GISAttendees_ListObject *attendees_ListObject;
    GISAppDelegate *appDelegate;
    UITextField *currentTextField;
    IBOutlet UITableView *attendees_tableView;
}



@property(nonatomic,strong)IBOutlet UITableView *attendees_tableView;

@end
