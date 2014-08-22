//
//  GISDashBoardViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 09/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISAppDelegate.h"

@interface GISDashBoardViewController : UIViewController<UISplitViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIView *datListView;
    //IBOutlet UILabel *_Label;
    IBOutlet UILabel *accountName_Label;
    IBOutlet UILabel *requestID_Label;
    IBOutlet UILabel *eventType_Label;
    IBOutlet UILabel *otherServices_Label;
    IBOutlet UILabel *earliestDate_Label;
    IBOutlet UILabel *approvalDate_Label;
    IBOutlet UILabel *approvedBy_Label;
    IBOutlet UILabel *status_Label;
    IBOutlet UILabel *scheduler_Label;
    IBOutlet UILabel *newIncomingRequest_Count_Label;
    IBOutlet UILabel *requestForModification_Count_Label;
    IBOutlet UILabel *serviceProvReqJobs_Count_Label;
    IBOutlet UILabel *newRequest_Label;
    IBOutlet UILabel *inProgress_Label;
    IBOutlet UILabel *onHold_Label;
    IBOutlet UILabel *waitingForApproval_Label;
    IBOutlet UILabel *approvedRequest_Label;
    IBOutlet UILabel *incompleteRequest_Label;
    
    IBOutlet UIView *dashBoard_UIView;
    IBOutlet UIView *tableHeader_UIView;
    
    IBOutlet UIView *colorIndicator_UIView;
    IBOutlet UISegmentedControl *segmentedControl_;
    
    IBOutlet UITableView *listTableView;
    
    
}
- (IBAction)hideAndUnHideMaster:(id)sender;
-(IBAction)SegmentToggle:(UISegmentedControl*)sender;
@property(nonatomic,strong)IBOutlet UINavigationItem *navigation_item;
@property(nonatomic,readwrite) BOOL isMasterHide;
@property(nonatomic,strong)IBOutlet UINavigationBar *navigationBar;
-(void)pushToViewController;
@end
