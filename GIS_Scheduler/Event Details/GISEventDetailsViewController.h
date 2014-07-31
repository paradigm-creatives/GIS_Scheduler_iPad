//
//  GISEventDetailsViewController.h
//  GIS_Scheduler
//
//  Created by Anand on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISBaseViewController.h"
#import "GISPopOverTableViewController.h"

@interface GISEventDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPopoverControllerDelegate,PopOverSelected_Protocol,UITextViewDelegate>

{
    NSString *eventTypedata;
    NSString *dresscodeData;
    NSString *otherServicesdata;
    NSString *captionData;
    NSString *viewingTypeData;
    int btn_tag;
    BOOL broadCastSelected;
    
}

@property (nonatomic, retain) IBOutlet UITableView *eventDetaislTabelView;
@property (strong, nonatomic) NSArray *eventTypeArray;
@property (strong, nonatomic) NSArray *dresscodeArray;
@property (strong, nonatomic) NSArray *otherServicesArray;
@property (strong, nonatomic) NSArray *captionTypeArray;
@property (strong, nonatomic) NSArray *viewingTypeArray;
@property (nonatomic,strong) UIPopoverController *popover;
@property(nonatomic,retain) IBOutlet UIView * alertCustomView;

@property(nonatomic,strong)NSString *eventTypeId_string;
@property(nonatomic,strong)NSString *dressCode_Id_string;
@property(nonatomic,strong)NSString *open_toPublicStr;
@property(nonatomic,strong)NSString *re_broadcastStr;
@property(nonatomic,strong)NSString *on_goingStr;
@property(nonatomic,strong)NSString *otherServices_Str;
@property(nonatomic,strong)NSString *blackboard_accessStr;
@property(nonatomic,strong)NSString *websiteStr;
@property(nonatomic,strong)NSString *other_Str;
@property(nonatomic,strong)NSString *broadcastType_Str;
@property(nonatomic,strong)NSMutableString *othertechvalueStr;
@property(nonatomic,strong)NSString *eventdetails_unitIdStr;
@property(nonatomic,strong)NSString *eventdetails_statusStr;
@property(nonatomic,strong)NSString *eventdetails_viewOptions;
@property(nonatomic,strong)NSMutableString *fields;
@property(nonatomic,strong)NSString *outsideAgencyStr;



- (IBAction)previousVersionBtnTap:(id)sender;
- (IBAction)showPopoverDetails:(id)sender;

@end
