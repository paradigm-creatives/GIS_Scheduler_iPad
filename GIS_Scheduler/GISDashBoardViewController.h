//
//  GISDashBoardViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 09/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISAppDelegate.h"
@interface GISDashBoardViewController : UIViewController<UISplitViewControllerDelegate>
{
    IBOutlet UIView *datListView;
}
- (IBAction)hideAndUnHideMaster:(id)sender;
@property(nonatomic,readwrite) BOOL isMasterHide;

@end
