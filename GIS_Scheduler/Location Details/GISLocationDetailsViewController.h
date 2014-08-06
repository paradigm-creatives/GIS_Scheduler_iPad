//
//  GISLocationDetailsViewController.h
//  GIS_Scheduler
//
//  Created by Anand on 17/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISPopOverTableViewController.h"

@interface GISLocationDetailsViewController : UIViewController<UIPopoverControllerDelegate,PopOverSelected_Protocol>
{
    NSString *generalLocationdata;
}

@property (nonatomic, retain) IBOutlet UITableView *locationDetaislTabelView;
@property (strong, nonatomic) NSArray *generalLocationArray;
@property (strong, nonatomic) NSArray *closestMetroArray;
@property (strong, nonatomic) NSArray *buildingNameArray;
@property (nonatomic,strong) UIPopoverController *popover;

@end
