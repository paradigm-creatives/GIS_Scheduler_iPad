//
//  EditView.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/19/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFEditEventView.h"

#import "FFButtonWithDatePopover.h"
#import "FFButtonWithHourPopover.h"
#import "FFSearchBarWithAutoComplete.h"
#import "FFGuestsTableView.h"
#import "FFImportantFilesForCalendar.h"
#import "GISEventLabel.h"
#import "GISFonts.h"
#import "GISJSONProperties.h"
#import "GISServerManager.h"
#import "GISJsonRequest.h"
#import "PCLogger.h"
#import "GISLoadingView.h"
#import "GISUtility.h"
#import "GISLoginDetailsObject.h"
#import "GISDatabaseManager.h"
#import "GISUtility.h"
#import "GISConstants.h"
#import "FFDateManager.h"

//#import "SVProgressHUD.h"

@interface FFEditEventView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) FFEvent *event;
@property (nonatomic, strong) UIButton *buttonCancel;
@property (nonatomic, strong) UIButton *buttonDone;
@property (nonatomic, strong) UIButton *buttonDelete;
@property (nonatomic, strong) GISEventLabel *labelEventName,*paytypeLabel,*serviceProviderTypeLabel;
@property (nonatomic, strong) FFSearchBarWithAutoComplete *searchBarCustom;
@property (nonatomic, strong) FFButtonWithDatePopover *buttonDate;
@property (nonatomic, strong) FFButtonWithHourPopover *buttonTimeBegin;
@property (nonatomic, strong) FFButtonWithHourPopover *buttonTimeEnd;
@property (nonatomic, strong) FFGuestsTableView *tableViewGuests;
@end

@implementation FFEditEventView

#pragma mark - Synthesize

@synthesize protocol;
@synthesize event;
@synthesize buttonDone;
@synthesize buttonCancel;
@synthesize buttonDelete;
@synthesize labelEventName;
@synthesize searchBarCustom;
@synthesize buttonDate;
@synthesize buttonTimeBegin;
@synthesize buttonTimeEnd;
@synthesize tableViewGuests;
@synthesize paytypeLabel;
@synthesize serviceProviderTypeLabel;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame event:(FFEvent *)_event {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        event = _event;
        
        [self setBackgroundColor:[UIColor lightGrayCustom]];
        [self.layer setBorderColor:[UIColor lightGrayCustom].CGColor];
        [self.layer setBorderWidth:2.];
        
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [gesture setDelegate:self];
        [self addGestureRecognizer:gesture];

        [self addButtonCancel];
        [self addButtonDone];
        [self addSearchBar];
        [self addButtonDate];
        [self addButtonTimeBegin];
        [self addButtonTimeEnd];
        //[self addButtonDelete];
        //[self addEventTitle];
        [self addTypeOfService];
        [self addServiceProvider];
        //[self addtableViewGuests];
    }
    return self;
}

#pragma mark - Button Actions

- (IBAction)buttonCancelAction:(id)sender {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(removeThisView:)]) {
        [protocol removeThisView:self];
    }
}

- (IBAction)buttonDoneAction:(id)sender {
    
    //    [[SVProgressHUD sharedView] setTintColor:[UIColor blackColor]];
    //    [[SVProgressHUD sharedView] setBackgroundColor:[UIColor lighterGrayCustom]];
    
//    FFEvent *eventNew = [FFEvent new];
//    eventNew.stringCustomerName = labelEventName.text;
//    eventNew.numCustomerID = searchBarCustom.numCustomerID;
//    eventNew.dateDay = buttonDate.dateOfButton;
//    eventNew.dateTimeBegin = buttonTimeBegin.dateOfButton;
//    eventNew.dateTimeEnd = buttonTimeEnd.dateOfButton;
//    eventNew.payType = paytypeLabel.text;
//    eventNew.serviceProvider = serviceProviderTypeLabel.text;
    
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    GISLoginDetailsObject *login_Obj=[requetId_array lastObject];
    
    NSMutableDictionary *update_eventdict;
    update_eventdict=[[NSMutableDictionary alloc]init];
    
    [update_eventdict setObject:event.numCustomerID forKey:kJobDetais_JobID];
    [update_eventdict setObject:[GISUtility getEventTime:buttonTimeBegin.dateOfButton] forKey:kJobDetais_StartTime];
    [update_eventdict setObject:[GISUtility getEventTime:buttonTimeEnd.dateOfButton] forKey:kJobDetais_EndTime];
    [update_eventdict setObject:[GISUtility eventDisplayFormat:buttonDate.dateOfButton] forKey:kJobDetais_JobDate];
    [update_eventdict setObject:event.payType forKey:kViewSchedule_PayTypeID];
    [update_eventdict setObject:event.serviceProvider forKey:kViewSchedule_ServiceProviderID];
    [update_eventdict setObject:@"" forKey:kViewSchedule_SubroleID];
    [update_eventdict setObject:login_Obj.requestorID_string forKey:kLoginRequestorID];
    [update_eventdict setObject:@"" forKey:kViewSchedule_JobNotes];
    
    [[GISServerManager sharedManager] updateJobDetails:self withParams:update_eventdict finishAction:@selector(successmethod_updateScheduledata:) failAction:@selector(failuremethod_updateScheduledata:)];
    
    
    
//    NSString *stringError;
//    
//    if (!eventNew.numCustomerID) {
//        stringError = @"Please select a customer.";
//    } else if (![self isTimeBeginEarlier:eventNew.dateTimeBegin timeEnd:eventNew.dateTimeEnd]) {
//        stringError = @"Start time must occur earlier than end time.";
//    } else if (eventNew.arrayWithGuests.count == 0) {
//        stringError = @"Please select a guest.";
//    }
    
//    if (stringError) {
//        [[[UIAlertView alloc] initWithTitle:nil message:stringError delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
//        //        [SVProgressHUD showErrorWithStatus:stringError];
//    } else
//    if (protocol != nil && [protocol respondsToSelector:@selector(saveEvent:)]) {
//        [protocol saveEvent:eventNew];
//        [self buttonDeleteAction:nil];
//    }
}

- (BOOL)isTimeBeginEarlier:(NSDate *)dateBegin timeEnd:(NSDate *)dateEnd {
    
    BOOL boolIsRight = YES;
    
    NSDateComponents *compDateBegin = [NSDate componentsOfDate:dateBegin];
    NSDateComponents *compDateEnd = [NSDate componentsOfDate:dateEnd];
    
    if ((compDateBegin.hour > compDateEnd.hour) || (compDateBegin.hour == compDateEnd.hour && compDateBegin.minute >= compDateEnd.minute)) {
        boolIsRight = NO;
    }
    
    return boolIsRight;
}

- (IBAction)buttonDeleteAction:(id)sender {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(deleteEvent:)]) {
        [protocol deleteEvent:event];
    }
    
   [self buttonCancelAction:nil];
}

#pragma mark - Tap Gesture

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    
    [searchBarCustom closeKeyboardAndTableView];
}

#pragma mark - Add Subviews

- (void)addButtonCancel {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, BUTTON_HEIGHT+30)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [view setBackgroundColor:[UIColor lighterGrayCustom]];
    [self addSubview:view];
    
    buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonCancel setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];
    [buttonCancel.titleLabel setFont:[GISFonts large]];
    [self customLayoutOfButton:buttonCancel withTitle:@"Cancel" action:@selector(buttonCancelAction:) frame:CGRectMake(20, 0, 80, BUTTON_HEIGHT+30)];
    [view addSubview:buttonCancel];
}

- (void)addButtonDone {
    
    buttonDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonDone setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    [buttonDone.titleLabel setFont:[GISFonts large]];
    [self customLayoutOfButton:buttonDone withTitle:@"Done" action:@selector(buttonDoneAction:) frame:CGRectMake(buttonCancel.superview.frame.size.width-80-10, buttonCancel.frame.origin.y, 80, buttonCancel.frame.size.height)];
    [buttonCancel.superview addSubview:buttonDone];
}

- (void)addSearchBar {
    
    searchBarCustom = [[FFSearchBarWithAutoComplete alloc] initWithFrame:CGRectMake(0,buttonCancel.superview.frame.origin.y+buttonCancel.superview.frame.size.height+ BUTTON_HEIGHT, self.frame.size.width, BUTTON_HEIGHT)];
    [searchBarCustom setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [searchBarCustom setStringClientName:event.stringCustomerName];
    [searchBarCustom setNumCustomerID:event.numCustomerID];
    [searchBarCustom setHidden:TRUE];
    [self addSubview:searchBarCustom];
    
    labelEventName = [[GISEventLabel alloc] initWithFrame:CGRectMake(0,buttonCancel.superview.frame.origin.y+buttonCancel.superview.frame.size.height+ BUTTON_HEIGHT, self.frame.size.width, BUTTON_HEIGHT)];
    [labelEventName setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [labelEventName setTextAlignment:NSTextAlignmentCenter];
    [labelEventName setFont:[GISFonts large]];
    labelEventName.text = [NSString stringWithFormat:@"Job ID %@", event.stringCustomerName];
    [self addSubview:labelEventName];
}

- (void)addButtonDate {
    
    buttonDate = [[FFButtonWithDatePopover alloc] initWithFrame:CGRectMake(0, searchBarCustom.frame.origin.y+searchBarCustom.frame.size.height+2, self.frame.size.width, BUTTON_HEIGHT) date:event.dateDay];
    [buttonDate setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [buttonDate.titleLabel setFont:[GISFonts large]];
    [self addSubview:buttonDate];
}

- (void)addEventTitle{
    
    labelEventName = [[GISEventLabel alloc] initWithFrame:CGRectMake(0, buttonDate.frame.origin.y+buttonDate.frame.size.height, self.frame.size.width, BUTTON_HEIGHT)];
    [labelEventName setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [labelEventName setTextAlignment:NSTextAlignmentCenter];
    labelEventName.text = [NSString stringWithFormat:@"Job ID %@", event.numCustomerID];
    [self addSubview:labelEventName];
}

- (void)addButtonTimeBegin {
    
    buttonTimeBegin = [[FFButtonWithHourPopover alloc] initWithFrame:CGRectMake(0, buttonDate.frame.origin.y+buttonDate.frame.size.height+BUTTON_HEIGHT, self.frame.size.width, BUTTON_HEIGHT) date:event.dateTimeBegin];
    [buttonTimeBegin setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [buttonTimeBegin.titleLabel setFont:[GISFonts large]];
    [self addSubview:buttonTimeBegin];
}

- (void)addButtonTimeEnd {
    
    buttonTimeEnd = [[FFButtonWithHourPopover alloc] initWithFrame:CGRectMake(0, buttonTimeBegin.frame.origin.y+buttonTimeBegin.frame.size.height+2, self.frame.size.width, BUTTON_HEIGHT) date:event.dateTimeEnd];
    [buttonTimeEnd setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [buttonTimeEnd.titleLabel setFont:[GISFonts large]];
    [self addSubview:buttonTimeEnd];
}

- (void)addTypeOfService{
    
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, buttonTimeEnd.frame.origin.y+buttonTimeEnd.frame.size.height+2, self.frame.size.width, BUTTON_HEIGHT)];
    [_backgroundView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_backgroundView];
    
    UIButton *addButton1 = [[UIButton alloc] init];
    addButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton1 setBackgroundImage:[UIImage imageNamed:@"choose_request_bg.png"] forState:UIControlStateNormal];
    [addButton1 addTarget:self
                   action:@selector(showPopoverDetails:)
         forControlEvents:UIControlEventTouchUpInside];
    addButton1.frame = CGRectMake(150, 5.0, 130.0, 27.0);
    addButton1 .contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    [addButton1.titleLabel setFont:[GISFonts small]];
    [addButton1 setTitleColor:UIColorFromRGB(0x616161) forState:UIControlStateNormal];
    [addButton1 setTitle:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil) forState:UIControlStateNormal];
    [addButton1 setTag:1235];
    [_backgroundView addSubview:addButton1];

    
//    paytypeLabel = [[GISEventLabel alloc] initWithFrame:CGRectMake(0, buttonTimeEnd.frame.origin.y+buttonTimeEnd.frame.size.height+2, self.frame.size.width, BUTTON_HEIGHT)];
//    [paytypeLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
//    [paytypeLabel setTextAlignment:NSTextAlignmentCenter];
//    paytypeLabel.text = [NSString stringWithFormat:@" %@", event.payType];
//    [self addSubview:paytypeLabel];
}

- (void)addServiceProvider{
    
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, labelEventName.frame.origin.y+labelEventName.frame.size.height+2, self.frame.size.width, BUTTON_HEIGHT)];
    [_backgroundView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_backgroundView];
    
    UIButton *addButton1 = [[UIButton alloc] init];
    addButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton1 setBackgroundImage:[UIImage imageNamed:@"choose_request_bg.png"] forState:UIControlStateNormal];
    [addButton1 addTarget:self
                   action:@selector(showPopoverDetails:)
         forControlEvents:UIControlEventTouchUpInside];
    addButton1.frame = CGRectMake(150, 5.0, 130.0, 27.0);
    addButton1 .contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    [addButton1.titleLabel setFont:[GISFonts small]];
    [addButton1 setTitleColor:UIColorFromRGB(0x616161) forState:UIControlStateNormal];
    [addButton1 setTitle:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil) forState:UIControlStateNormal];
    [addButton1 setTag:1234];
    [_backgroundView addSubview:addButton1];
    
//    serviceProviderTypeLabel = [[GISEventLabel alloc] initWithFrame:CGRectMake(0, labelEventName.frame.origin.y+labelEventName.frame.size.height+2, self.frame.size.width, BUTTON_HEIGHT)];
//    [serviceProviderTypeLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
//    [serviceProviderTypeLabel setTextAlignment:NSTextAlignmentCenter];
//    serviceProviderTypeLabel.text = [NSString stringWithFormat:@"%@", event.serviceProvider];
//    [self addSubview:serviceProviderTypeLabel];
}

- (void)addButtonDelete {
    
    buttonDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonDelete setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [self customLayoutOfButton:buttonDelete withTitle:@"Assign" action:@selector(buttonDeleteAction:) frame:CGRectMake(0, self.frame.size.height-2*BUTTON_HEIGHT, self.frame.size.width, 2*BUTTON_HEIGHT)];
    [buttonDelete setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:buttonDelete];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, buttonDelete.frame.origin.y-BUTTON_HEIGHT, self.frame.size.width, BUTTON_HEIGHT)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [self addSubview:view];
}

- (void)addtableViewGuests {
    
    CGFloat y = buttonTimeEnd.frame.origin.y+buttonTimeEnd.frame.size.height+BUTTON_HEIGHT;
    
    tableViewGuests = [[FFGuestsTableView alloc] initWithFrame:CGRectMake(0, y, self.frame.size.width,buttonDelete.frame.origin.y-y-BUTTON_HEIGHT)];
    [tableViewGuests setAutoresizingMask:AR_WIDTH_HEIGHT];
    [self addSubview:tableViewGuests];
}

#pragma mark - Button Layout

- (void)customLayoutOfButton:(UIButton *)button withTitle:(NSString *)title action:(SEL)action frame:(CGRect)frame {
    
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:button.titleLabel.font.pointSize]];
    [button setFrame:frame];
    [button setContentMode:UIViewContentModeScaleAspectFit];
}

#pragma mark - UIGestureRecognizer Delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    CGPoint point = [gestureRecognizer locationInView:self];
    
    return !(searchBarCustom.arrayOfTableView.count != 0 && CGRectContainsPoint(searchBarCustom.tableViewCustom.frame, point)) &&
    CGRectContainsPoint(tableViewGuests.frame, point) && searchBarCustom.tableViewCustom.superview;
}

-(void)successmethod_updateScheduledata:(GISJsonRequest *)response
{
    
    NSLog(@"successmethod_updateScheduledata Success---%@",response.responseJson);
    @try {
        if ([response.responseJson isKindOfClass:[NSArray class]])
        {
            
            id array=response.responseJson;
            NSDictionary *dictHere=[array lastObject];
            
            if ([[dictHere objectForKey:kStatus] isEqualToString:@"Success"]) {
                
                [self removeLoadingView];
                [[NSNotificationCenter defaultCenter] postNotificationName:DATE_CHANGED_UPDATE_EVENT object:nil];
            }
            else
            {
                [self removeLoadingView];
            }
        }
        else
        {
            [self removeLoadingView];
        }
        
        if (protocol != nil && [protocol respondsToSelector:@selector(removeThisView:)]) {
            [protocol removeThisView:self];
        }
        
    }
    @catch (NSException *exception)
    {
        [self removeLoadingView];
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in get PatTypedata action %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
}
-(void)failuremethod_updateScheduledata:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
}

-(void)addLoadViewWithLoadingText:(NSString*)title
{
    [[GISLoadingView sharedDataManager] addLoadingAlertView:title];
    // _loadingView = [LoadingView loadingViewInView:self.navigationController.view andWithText:title];
}

- (IBAction)showPopoverDetails:(id)sender {
    
    UIButton *btn=(UIButton*)sender;
    
   GISAppDelegate *appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    GISPopOverTableViewController *tableViewController = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    
    tableViewController.popOverDelegate = self;
    
    _popover =   [GISUtility showPopOver:appDelegate.payTypeArray viewController:tableViewController];
    _popover.delegate = self;
    
    _popover.popoverContentSize = CGSizeMake(180, 210);
    
    
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }
    [_popover presentPopoverFromRect:CGRectMake(btn.frame.origin.x+66, btn.frame.origin.y+120, 1, 1) inView:self permittedArrowDirections:UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown  animated:YES];
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    UIButton *payTypebtnn=(UIButton *)[_backgroundView viewWithTag:1234];
    [payTypebtnn setTitle:value_str forState:UIControlStateNormal];
    
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }
}


-(void)removeLoadingView
{
    [[GISLoadingView sharedDataManager] removeLoadingAlertview];
}


@end
