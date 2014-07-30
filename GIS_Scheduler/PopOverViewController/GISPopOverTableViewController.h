//
//  GISPopOverTableViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 21/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISAppDelegate.h"

@protocol PopOverSelected_Protocol <NSObject>
-(void)sendTheSelectedPopOverData: (NSString *)id_str value:(NSString *)value_str;
@end
@interface GISPopOverTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *popOverTableView;
    GISAppDelegate *appDelegate;
}

@property(nonatomic,strong) id <PopOverSelected_Protocol> popOverDelegate;
@property(nonatomic,strong)NSMutableArray *popOverArray;
@property (weak,nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint;

@end
