//
//  GISAttendeesViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISAttendeesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)IBOutlet UITableView *attendees_tableView;

@end
