//
//  GISPopOverTableViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 21/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISPopOverTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *popOverTableView;
}
@property(nonatomic,strong)NSMutableArray *popOverArray;

@end
