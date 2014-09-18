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

@protocol FFCalendarViewControllerProtocol <NSObject>
@required
- (void)arrayUpdatedWithAllEvents:(NSMutableArray *)arrayUpdated;
@end

@interface GISViewEditServiceViewController : GISBaseViewController
{
    NSMutableArray *viewEdit_Array;
    GISAppDelegate *appDelegate;
}

@property (nonatomic, strong) id <FFCalendarViewControllerProtocol> protocol;
@property (nonatomic, strong) NSMutableArray *arrayWithEvents;
@property (nonatomic, strong) IBOutlet UISegmentedControl *fill_UnfillSegmentControl;
@property (nonatomic, strong) IBOutlet UISegmentedControl *staff_freeLancerSegmentControl;
@property (nonatomic, strong) IBOutlet UIButton *staff_freeLancerButton;

- (void)setArrayWithEvents:(NSMutableArray *)_arrayWithEvents;
- (IBAction) dateSelected:(id)sender;

@end
