//
//  AppDelegate.h
//  GIS_Scheduler
//
//  Created by Paradigm on 08/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "GISDashBoardViewController.h"

@interface GISAppDelegate : UIResponder <UIApplicationDelegate,UISplitViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) GISDashBoardViewController *dashBoardViewController;
@property (strong,nonatomic) UISplitViewController *spiltViewController;

@property (strong, nonatomic) UINavigationController *navigationcontroller;

@property(nonatomic,strong)id detailViewController;

@end
