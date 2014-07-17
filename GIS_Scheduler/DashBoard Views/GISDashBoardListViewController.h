//
//  GISDashBoardListViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 09/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISAppDelegate.h"

@class GISDashBoardViewController;

@interface GISDashBoardListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    int rowCount;
    BOOL hideClicked;
    BOOL sectionhideClicked;
    GISAppDelegate *appDelegate;
}

@property (nonatomic,retain)  IBOutlet UITableView *dashBoard_ListTableView;

@end
