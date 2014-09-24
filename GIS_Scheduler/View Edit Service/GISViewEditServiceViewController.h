//
//  GISViewEditServiceViewController.h
//  GIS_Scheduler
//
//  Created by Anand on 27/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISBaseViewController.h"
#import "GISAppDelegate.h"
#import "GISPopOverTableViewController.h"

@protocol FFCalendarViewControllerProtocol <NSObject>
@required
- (void)arrayUpdatedWithAllEvents:(NSMutableArray *)arrayUpdated;
@end

@interface GISViewEditServiceViewController : GISBaseViewController<PopOverSelected_Protocol,UIPopoverControllerDelegate>
{
    NSMutableArray *viewEdit_Array;
    NSMutableArray *viewEdit_ServiceProvider_Array;
    NSMutableArray *viewEdit_ServiceProvider_unfilledArray;
    GISAppDelegate *appDelegate;
    BOOL isDateSelected;
    BOOL isServiceSelected;
    NSString *serviceProvider_String;
    NSString *serviceProvider_IDString;
    NSString *tabNameString;
}

@property (nonatomic, strong) id <FFCalendarViewControllerProtocol> protocol;
@property (nonatomic, strong) NSMutableArray *arrayWithEvents;
@property (nonatomic, strong) IBOutlet UISegmentedControl *fill_UnfillSegmentControl;
@property (nonatomic, strong) IBOutlet UISegmentedControl *staff_freeLancerSegmentControl;
@property (nonatomic, strong) IBOutlet UIButton *staff_freeLancerButton;
@property (nonatomic, strong) IBOutlet UIButton *dateButton;
@property (nonatomic, strong) IBOutlet UIButton *serviceProviderButton;
@property (strong, nonatomic) NSArray *ServiceProvider_TypeArray;
@property (nonatomic,strong) UIPopoverController *popover;

- (void)setArrayWithEvents:(NSMutableArray *)_arrayWithEvents;
- (IBAction) dateSelected:(id)sender;
- (IBAction) serviceProviderSelected:(id)sender;
- (IBAction)showServicePopoverDetails:(id)sender;

@end
