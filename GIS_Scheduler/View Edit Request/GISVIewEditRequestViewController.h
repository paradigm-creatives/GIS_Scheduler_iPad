//
//  GISVIewEditRequestViewController.h
//  GIS_Scheduler
//
//  Created by Anand on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISLoginDetailsObject.h"
#import "GISDropDownStore.h"
#import "GISPopOverTableViewController.h"
#import "GISAppDelegate.h"
#import "GISPopOverTableViewController.h"


@interface GISVIewEditRequestViewController : UIViewController<UITabBarDelegate,UIPopoverControllerDelegate,PopOverSelected_Protocol>
{
    GISLoginDetailsObject *login_Obj;
    GISDropDownStore *dropDownStore;
    NSMutableArray *requestNumbers_mutArray;
    GISAppDelegate *appDelegate;
}

@property (nonatomic, strong) IBOutlet UILabel *requestID_Label;
@property (nonatomic, strong) IBOutlet UIButton *requestBtn;

@property (nonatomic, retain) NSArray *viewControllers;
@property (nonatomic, retain) UIViewController *currentController;
@property (nonatomic,strong) UIPopoverController *popover;

@property (nonatomic, retain) IBOutlet UIView *mainView;
@property (nonatomic, retain) IBOutlet UITabBar *mainTabbar;
@property (nonatomic, retain) IBOutlet UITabBarItem *contactItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *eventDetailsItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *attendeesItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *locationdetaislItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *datesItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *jobdetailsItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *summarYItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *commentsItem;
@property (strong, nonatomic) NSArray *requetDetails;

@end
