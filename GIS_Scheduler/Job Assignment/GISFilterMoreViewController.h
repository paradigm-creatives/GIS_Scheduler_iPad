//
//  GISFilterMoreViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 11/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISPopOverTableViewController.h"

@protocol FilterMore_Protocol <NSObject>

-(void)sendFilterMoreValues:(NSMutableDictionary *)dict;

@end

@interface GISFilterMoreViewController : UIViewController<UIPopoverControllerDelegate,PopOverSelected_Protocol>
{

    NSMutableArray *unitAccount_array;
    NSMutableArray *registeredConsumers_array;
    NSMutableArray *eventType_array;
    NSMutableArray *serviceProviderType_array;
    NSMutableArray *serviceProvider_array;
    
    UIPopoverController *popover;
    int btnTag;
    
    NSString *typeOfAct_string;
    NSString *onGoing_string;
    NSString *eventType_ID_string;
    NSString *serviceProvider_ID_string;
    NSString *registeredCOnsumers_ID_string;
    NSString *unitAccount_ID_string;
}
@property (strong, nonatomic) IBOutlet UILabel *filtersLabel;
@property (strong, nonatomic) IBOutlet UILabel *serviceProviderName;
@property (strong, nonatomic) IBOutlet UILabel *typeOfAccountLabel;
@property (strong, nonatomic) IBOutlet UILabel *ongoingRequest;
@property (strong, nonatomic) IBOutlet UILabel *unitAccountLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventType;
@property (strong, nonatomic) IBOutlet UILabel *eventType_AnswerLabel;
@property (strong, nonatomic) IBOutlet UILabel *serviceProvider_AnswerLabel;
@property (strong, nonatomic) IBOutlet UILabel *registeredConsumers_AnswerLabel;
@property (strong, nonatomic) IBOutlet UILabel *unitAccount_AnswerLabel;
@property (strong, nonatomic) IBOutlet UIButton *external_btn;
@property (strong, nonatomic) IBOutlet UIButton *internal_btn;
@property (strong, nonatomic) IBOutlet UIButton *yes_btn_OnGoing;
@property (strong, nonatomic) IBOutlet UIButton *no_btn_OnGoing;
@property (strong, nonatomic) IBOutlet UILabel *internalLabel;
@property (strong, nonatomic) IBOutlet UILabel *ongoingYesLabel;
@property (strong, nonatomic) IBOutlet UILabel *onGoingNo;
@property (strong, nonatomic) IBOutlet UILabel *externalLabel;


@property(nonatomic,strong)id<FilterMore_Protocol> delegate_filter;
-(IBAction)pickerButtonPressed:(id)sender;
-(IBAction)apply_Cancel_ButtonPressed:(id)sender;
-(IBAction)radioButton_Pressed:(id)sender;
@end
