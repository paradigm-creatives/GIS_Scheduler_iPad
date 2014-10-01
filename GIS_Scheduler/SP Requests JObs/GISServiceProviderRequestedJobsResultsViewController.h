//
//  GISServiceProviderRequestedJobsResultsViewController.h
//  GIS_Scheduler
//
//  Created by Anand on 30/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISBaseViewController.h"
#import "GISAppDelegate.h"

@interface GISServiceProviderRequestedJobsResultsViewController : GISBaseViewController
{
    
    GISAppDelegate *appDelegate;
}

@property(nonatomic,strong)NSMutableArray *SPJobsArray;

@property(nonatomic,strong)IBOutlet UIView *flipView;
@property(nonatomic,strong)IBOutlet UITableView *jobResultsTableView;
@property(nonatomic,strong)IBOutlet UIView *horizontalview;

@end
