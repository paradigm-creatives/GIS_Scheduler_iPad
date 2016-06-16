//
//  GISJobAssignmentViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 22/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISAppDelegate.h"
#import "GISPopOverTableViewController.h"
#import "GISBaseViewController.h"
#import "GISLoginDetailsObject.h"
#import "GISServiceProviderPopUpViewController.h"
#import "GISFilterMoreViewController.h"
@interface GISJobAssignmentViewController : GISBaseViewController<UITableViewDataSource,UITableViewDelegate,UISplitViewControllerDelegate,UIPopoverControllerDelegate,PopOverSelected_Protocol,ListOfServiceProvidersProtocol,FilterMore_Protocol>
{
    GISAppDelegate *appDelegate;
    GISLoginDetailsObject *login_Obj;

    UIPopoverController *popover;
    int btnTag;
    
    NSMutableArray *chooseRequest_mutArray;
    
    NSString *startDate_str;
    NSString *endDate_str;
    NSString *typeServiceID_str;
    NSString *chooseRequestID_str;
    
    NSMutableArray *serviceProvider_Array;
    NSMutableArray *serviceProviderType_array;
    NSMutableArray *payType_array;
    
    NSMutableDictionary *ota_dictionary;
    
    BOOL isEdit_Button_Clicked;
    int selected_row;
    
    NSString *typeOfservice_temp_string;
    NSString *serviceProvider_temp_string;
    NSString *payType_temp_string;
    NSMutableArray *mainArray;
    
    NSString *eventType_ID_string;
    NSString *serviceProvider_ID_string;
    NSString *registeredConsumers_ID_string;
    NSString *unitAccount_ID_string;
    NSString *typeOfAct_ID_string;
    NSString *onGoing_ID_string;
    
    UISegmentedControl *segment;
    
    
}


@property(nonatomic,strong)NSMutableArray *requested_Jobs_Array;
@property(nonatomic,strong) NSString *view_string;
@property(nonatomic,strong)  IBOutlet UILabel *from_answer_Label;
@property(nonatomic,strong)  IBOutlet UILabel *to_answer_Label;
@property(nonatomic,strong)  IBOutlet UILabel *typeOfService_answer_Label;
@property(nonatomic,strong) IBOutlet UILabel *chooseRequest_ID_answer_Label;
@property(nonatomic,strong)  IBOutlet UILabel *fromLabel;
@property(nonatomic,strong)  IBOutlet UIView *segment_UIView;
@property(nonatomic,strong)  IBOutlet UIView *table_UIView;
@property(nonatomic,strong)  IBOutlet UILabel *toLabel;
@property(nonatomic,strong)  IBOutlet UISegmentedControl *segment_filled_Unfilled;
@property(nonatomic,strong)  IBOutlet UILabel *typeServiceLabel;
@property(nonatomic,strong)  IBOutlet UIButton *filterMoreButton;
@property(nonatomic,strong)  IBOutlet UILabel *requestId;
@property(nonatomic,strong)  IBOutlet UITableView *jobAssignment_tableView;
@property(nonatomic,strong)  IBOutlet UIView *dashBoard_UIViews;

@property (strong, nonatomic) IBOutlet UILabel *endTiemLabel;
@property (strong, nonatomic) IBOutlet UILabel *serviceProviderTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *serviceProviderLabel;
@property (strong, nonatomic) IBOutlet UILabel *payTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *requestorLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobIdLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *startTimeLabel;

-(IBAction)filterMore_ButtonPressed:(id)sender;
-(IBAction)searchButton_Pressed:(id)sender;
-(IBAction)segment_filled_Unfilled_ValueChanged:(id)sender;
-(IBAction)pickerButton_pressed:(id)sender;

-(IBAction)listOfServiceProviders_ButtonPressed:(id)sender;
@end
