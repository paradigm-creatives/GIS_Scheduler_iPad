//
//  GISEventDetailsViewController.h
//  GIS_Scheduler
//
//  Created by Anand on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISBaseViewController.h"

@interface GISEventDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPopoverControllerDelegate>

@property (nonatomic, retain) IBOutlet UITableView *eventDetaislTabelView;
@property (strong, nonatomic) NSArray *eventTypeArray;
@property (strong, nonatomic) NSArray *dresscodeArray;
@property (nonatomic,strong) UIPopoverController *popover;

- (IBAction)previousVersionBtnTap:(id)sender;
- (IBAction)showPopoverDetails:(id)sender;

@end
