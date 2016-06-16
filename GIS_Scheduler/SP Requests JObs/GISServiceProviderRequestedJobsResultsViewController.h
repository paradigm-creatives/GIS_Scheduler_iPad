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
#import "GISLoginDetailsObject.h"
#import "GISPopOverTableViewController.h"
@interface GISServiceProviderRequestedJobsResultsViewController : GISBaseViewController<UIPopoverControllerDelegate,PopOverSelected_Protocol>
{
    
    GISAppDelegate *appDelegate;
    BOOL isEdit_Button_Clicked;
    GISLoginDetailsObject *login_Obj;
    int selected_row;
    
    NSString *gisResponse_temp_string;
    NSString *serviceProvider_temp_string;
    NSString *payType_temp_string;
   
     NSMutableArray *gisResponse_array;
    NSMutableArray *eventType_array;
    NSMutableArray *payType_array;
    NSMutableArray *serviceProviderName_Array;
    
    UIPopoverController *popover;
    int btnTag;
}
@property (strong, nonatomic) IBOutlet UILabel *jobLabel;
@property (strong, nonatomic) IBOutlet UILabel *startDate;
@property (strong, nonatomic) IBOutlet UILabel *endtimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalHoursLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *serviceProviderName;
@property (strong, nonatomic) IBOutlet UILabel *requestDate;
@property (strong, nonatomic) IBOutlet UILabel *payTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *gisResponseLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobdateLabel;

@property(nonatomic,strong)NSMutableArray *SPJobsArray;

@property(nonatomic,strong)IBOutlet UIView *flipView;
@property(nonatomic,strong)IBOutlet UITableView *jobResultsTableView;
@property(nonatomic,strong)IBOutlet UIView *horizontalview;
-(IBAction)pickerButtonPressed:(id)sender;
-(IBAction)restoreButtonPressed:(id)sender;
@end
