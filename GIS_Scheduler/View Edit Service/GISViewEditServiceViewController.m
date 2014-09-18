//
//  GISViewEditServiceViewController.m
//  GIS_Scheduler
//
//  Created by Anand on 27/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISViewEditServiceViewController.h"
#import "FFCalendar.h"
#import "GISConstants.h"
#import "GISLoginDetailsObject.h"
#import "GISDatabaseManager.h"
#import "GISServerManager.h"
#import "GISJsonRequest.h"
#import "GISDropDownStore.h"
#import "GISStoreManager.h"
#import "GISLoadingView.h"
#import "PCLogger.h"
#import "GISConstants.h"
#import "GISJSONProperties.h"
#import "GISUtility.h"
#import "GISViewEditStore.h"
#import "NSDate+FFDaysCount.h"
#import "FFDateManager.h"

@interface GISViewEditServiceViewController ()<FFMonthCalendarViewProtocol, FFWeekCalendarViewProtocol, FFDayCalendarViewProtocol>
@property (nonatomic) BOOL boolDidLoad;
@property (nonatomic) BOOL boolYearViewIsShowing;
@property (nonatomic, strong) NSMutableDictionary *dictEvents;
@property (nonatomic, strong) UILabel *labelWithMonthAndYear;
@property (nonatomic, strong) NSArray *arrayButtons;
@property (nonatomic, strong) NSArray *arrayCalendars;
@property (nonatomic, strong) FFEditEventPopoverController *popoverControllerEditar;

@property (nonatomic, strong) FFMonthCalendarView *viewCalendarMonth;
@property (nonatomic, strong) FFWeekCalendarView *viewCalendarWeek;
@property (nonatomic, strong) FFDayCalendarView *viewCalendarDay;
@property (nonatomic, strong) IBOutlet UIView *mainView;
@property (nonatomic, strong) IBOutlet UILabel *labelMonthAndYear;
@property (nonatomic, retain) IBOutlet UITabBar *mainTabbar;
@property (nonatomic, retain) IBOutlet UITabBarItem *dayItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *weekItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *monthItem;

@end

@implementation GISViewEditServiceViewController

@synthesize boolDidLoad;
@synthesize boolYearViewIsShowing;
@synthesize protocol;
@synthesize arrayWithEvents;
@synthesize dictEvents;
@synthesize labelWithMonthAndYear;
@synthesize arrayButtons;
@synthesize arrayCalendars;
@synthesize popoverControllerEditar;
@synthesize viewCalendarMonth;
@synthesize viewCalendarWeek;
@synthesize viewCalendarDay;
@synthesize labelMonthAndYear;
@synthesize dayItem;
@synthesize weekItem;
@synthesize monthItem;
@synthesize mainTabbar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.hidesBackButton = YES;
    
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys: UIColorFromRGB(0x666666), NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged:) name:DATE_MANAGER_DATE_CHANGED object:nil];
    self.navigationController.navigationBarHidden = YES;
    
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [self customNavigationBarLayout];
    
    [self addCalendars];
    
    [self buttonYearMonthWeekDayAction:[arrayButtons objectAtIndex:0]];
    
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"selected.png"]];
    
    self.dayItem.selectedImage = [[UIImage imageNamed:@"day_clicked.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.weekItem.selectedImage = [[UIImage imageNamed:@"week_clicked.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.monthItem.selectedImage = [[UIImage imageNamed:@"month_clicked.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIColor *titleHighlightedColor = UIColorFromRGB(0xffffff);
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    [[UITabBar appearance] setSelectedItem:self.dayItem];
    
    viewEdit_Array = [[NSMutableArray alloc] init];

}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (!boolDidLoad) {
        boolDidLoad = YES;
        [self buttonTodayAction:nil];
    }
}


#pragma mark - FFDateManager Notification

- (void)dateChanged:(NSNotification *)notification {
    
    
    [self updateLabelWithMonthAndYear];
}

- (void)updateLabelWithMonthAndYear {
    
    NSDateComponents *comp = [NSDate componentsOfDate:[[FFDateManager sharedManager] currentDate]];
    NSString *string = [NSString stringWithFormat:@"%@ %i", [arrayMonthName objectAtIndex:comp.month-1], comp.year];
    [labelWithMonthAndYear setText:string];
    [labelMonthAndYear setText:string];
    
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    GISLoginDetailsObject *login_Obj=[requetId_array lastObject];
    
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    if(appDelegate.isDateView){
        [paramsDict setObject:[GISUtility eventDisplayFormat:[[FFDateManager sharedManager] currentDate]] forKey:@"StartDate"];
        [paramsDict setObject:[GISUtility eventDisplayFormat:[[FFDateManager sharedManager] currentDate]] forKey:@"EndDate"];
    }else if(appDelegate.isWeekView){
        [paramsDict setObject:[GISUtility eventDisplayFormat:[NSDate getWeekFirstDate:[[FFDateManager sharedManager] currentDate]]] forKey:@"StartDate"];
        [paramsDict setObject:[GISUtility eventDisplayFormat:[NSDate getWeeklastDate:[[FFDateManager sharedManager] currentDate]]] forKey:@"EndDate"];
    }else if(appDelegate.isMonthView){
        
        [paramsDict setObject:[GISUtility eventDisplayFormat:[[FFDateManager sharedManager] currentDate]] forKey:@"StartDate"];
        [paramsDict setObject:[GISUtility eventDisplayFormat:[[FFDateManager sharedManager] currentDate]] forKey:@"EndDate"];
        
    }
    [paramsDict setObject:@"" forKey:@"ServiceProvider"];
    [paramsDict setObject:login_Obj.token_string forKey:@"token"];
    [[GISServerManager sharedManager] getViewEditScheduledata:self withParams:paramsDict finishAction:@selector(successmethod_viewEditScheduledata:) failAction:@selector(failuremethod_viewEditScheduledata:)];
}

#pragma mark - Init dictEvents

- (void)setArrayWithEvents:(NSMutableArray *)_arrayWithEvents {
    
    arrayWithEvents = _arrayWithEvents;
    
    dictEvents = [NSMutableDictionary new];
    
    for (FFEvent *event in _arrayWithEvents) {
        NSDateComponents *comp = [NSDate componentsOfDate:event.dateDay];
        NSDate *newDate = [NSDate dateWithYear:comp.year month:comp.month day:comp.day];
        NSMutableArray *array = [dictEvents objectForKey:newDate];
        if (!array) {
            array = [NSMutableArray new];
            [dictEvents setObject:array forKey:newDate];
        }
        [array addObject:event];
    }
}

#pragma mark - Custom NavigationBar

- (void)customNavigationBarLayout {
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor lighterGrayCustom]];
    
    [self addRightBarButtonItems];
    [self addLeftBarButtonItems];
}

- (void)addRightBarButtonItems {
    
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = 30.;
    
    FFRedAndWhiteButton *buttonYear = [self calendarButtonWithTitle:@"year"];
    FFRedAndWhiteButton *buttonMonth = [self calendarButtonWithTitle:@"month"];
    FFRedAndWhiteButton *buttonWeek = [self calendarButtonWithTitle:@"week"];
    FFRedAndWhiteButton *buttonDay = [self calendarButtonWithTitle:@"day"];
    
    UIBarButtonItem *barButtonMonth = [[UIBarButtonItem alloc] initWithCustomView:buttonMonth];
    UIBarButtonItem *barButtonWeek = [[UIBarButtonItem alloc] initWithCustomView:buttonWeek];
    UIBarButtonItem *barButtonDay = [[UIBarButtonItem alloc] initWithCustomView:buttonDay];
    
    arrayButtons = @[buttonYear, buttonMonth, buttonWeek, buttonDay];
    [self.navigationItem setRightBarButtonItems:@[barButtonMonth, barButtonWeek, barButtonDay]];
}

- (void)addLeftBarButtonItems {
    
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = 30.;
    
    FFRedAndWhiteButton *buttonToday = [[FFRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 80., 30)];
    [buttonToday addTarget:self action:@selector(buttonTodayAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonToday setTitle:@"today" forState:UIControlStateNormal];
    UIBarButtonItem *barButtonToday = [[UIBarButtonItem alloc] initWithCustomView:buttonToday];
    
    labelWithMonthAndYear = [[UILabel alloc] initWithFrame:CGRectMake(0., 0., 170., 30)];
    [labelWithMonthAndYear setTextColor:[UIColor redColor]];
    [labelWithMonthAndYear setFont:buttonToday.titleLabel.font];
    UIBarButtonItem *barButtonLabel = [[UIBarButtonItem alloc] initWithCustomView:labelWithMonthAndYear];
    
    [self.navigationItem setLeftBarButtonItems:@[barButtonLabel, fixedItem, barButtonToday]];
}

- (FFRedAndWhiteButton *)calendarButtonWithTitle:(NSString *)title {
    
    FFRedAndWhiteButton *button = [[FFRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 80., 30.)];
    [button addTarget:self action:@selector(buttonYearMonthWeekDayAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

#pragma mark - Add Calendars

- (void)addCalendars {
    
    CGRect frame = CGRectMake(0., 0., self.mainView.frame.size.width, self.mainView.frame.size.height);
    
    //    viewCalendarYear = [[FFYearCalendarView alloc] initWithFrame:frame];
    //    [viewCalendarYear setProtocol:self];
    //    [self.mainView addSubview:viewCalendarYear];
    
    viewCalendarMonth = [[FFMonthCalendarView alloc] initWithFrame:frame];
    [viewCalendarMonth setProtocol:self];
    [viewCalendarMonth setDictEvents:dictEvents];
    [self.mainView addSubview:viewCalendarMonth];
    
    viewCalendarWeek = [[FFWeekCalendarView alloc] initWithFrame:frame];
    [viewCalendarWeek setProtocol:self];
    [viewCalendarWeek setDictEvents:dictEvents];
    [self.mainView addSubview:viewCalendarWeek];
    
    viewCalendarDay = [[FFDayCalendarView alloc] initWithFrame:frame];
    [viewCalendarDay setProtocol:self];
    [viewCalendarDay setDictEvents:dictEvents];
    [self.mainView addSubview:viewCalendarDay];
    
    arrayCalendars = @[viewCalendarDay,  viewCalendarWeek, viewCalendarMonth];
}

#pragma mark - Button Action

- (IBAction)buttonYearMonthWeekDayAction:(id)sender {
    
    int index = [sender tag];//[arrayButtons indexOfObject:sender];
    
    [self.mainView bringSubviewToFront:[arrayCalendars objectAtIndex:index]];
    
    for (UIButton *button in arrayButtons) {
        button.selected = (button == sender);
    }
    
    boolYearViewIsShowing = (index == 0);
    [self updateLabelWithMonthAndYear];
}

- (IBAction)buttonTodayAction:(id)sender {
    
    [[FFDateManager sharedManager] setCurrentDate:[NSDate dateWithYear:[NSDate componentsOfCurrentDate].year
                                                                 month:[NSDate componentsOfCurrentDate].month
                                                                   day:[NSDate componentsOfCurrentDate].day]];
}

#pragma mark - Interface Rotation

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    //[viewCalendarYear invalidateLayout];
    [viewCalendarMonth invalidateLayout];
    [viewCalendarWeek invalidateLayout];
    [viewCalendarDay invalidateLayout];
}

#pragma mark - FFButtonAddEventWithPopover Protocol

- (void)addNewEvent:(FFEvent *)eventNew {
    
    NSMutableArray *arrayNew = [dictEvents objectForKey:eventNew.dateDay];
    if (!arrayNew) {
        arrayNew = [NSMutableArray new];
        [dictEvents setObject:arrayNew forKey:eventNew.dateDay];
    }
    [arrayNew addObject:eventNew];
    
    [self setNewDictionary:dictEvents];
}

#pragma mark - FFMonthCalendarView, FFWeekCalendarView and FFDayCalendarView Protocols

- (void)setNewDictionary:(NSDictionary *)dict {
    
    dictEvents = (NSMutableDictionary *)dict;
    
    [viewCalendarMonth setDictEvents:dictEvents];
    [viewCalendarWeek setDictEvents:dictEvents];
    [viewCalendarDay setDictEvents:dictEvents];
    
    [self arrayUpdatedWithAllEvents];
}

#pragma mark - FFYearCalendarView Protocol

- (void)showMonthCalendar {
    
    [self buttonYearMonthWeekDayAction:[arrayButtons objectAtIndex:1]];
}

#pragma mark - Sending Updated Array to FFCalendarViewController Protocol

- (void)arrayUpdatedWithAllEvents {
    
    NSMutableArray *arrayNew = [NSMutableArray new];
    
    NSArray *arrayKeys = dictEvents.allKeys;
    for (NSDate *date in arrayKeys) {
        NSArray *arrayOfDate = [dictEvents objectForKey:date];
        for (FFEvent *event in arrayOfDate) {
            [arrayNew addObject:event];
        }
    }
    
    if (protocol != nil && [protocol respondsToSelector:@selector(arrayUpdatedWithAllEvents:)]) {
        [protocol arrayUpdatedWithAllEvents:arrayNew];
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor yellowColor]];
    
    int index = item.tag;//[arrayButtons indexOfObject:sender];
    
    if(item.tag == 0){
        appDelegate.isDateView = YES;
        appDelegate.isWeekView = NO;
        appDelegate.isMonthView = NO;
        
    }else if(item.tag == 1){
        appDelegate.isWeekView = YES;
        appDelegate.isDateView = NO;
        appDelegate.isMonthView = NO;
        
    }else if(item.tag == 2){
        appDelegate.isMonthView = YES;
        appDelegate.isWeekView = NO;
        appDelegate.isDateView = NO;
    }
    
    [self.mainView bringSubviewToFront:[arrayCalendars objectAtIndex:index]];
    
    boolYearViewIsShowing = (index == 0);
    [self updateLabelWithMonthAndYear];

}

-(IBAction)SegmentToggle:(UISegmentedControl*)sender {
    
    if (sender.selectedSegmentIndex==0) {
        
        [_staff_freeLancerSegmentControl setHidden:NO];
        [_staff_freeLancerButton setHidden:NO];
        
        CGRect frame = _mainView.frame;
        frame.origin.y= 154.0f;
        _mainView.frame = frame;
        
    }else if(sender.selectedSegmentIndex==1)
    {
      
        [_staff_freeLancerSegmentControl setHidden:YES];
        [_staff_freeLancerButton setHidden:YES];
        
        CGRect frame = _mainView.frame;
        frame.origin.y= 121.0f;
        _mainView.frame = frame;
    }
}
-(void)successmethod_viewEditScheduledata:(GISJsonRequest *)response
{
    
    NSLog(@"successmethod_viewEditSchedule Success---%@",response.responseJson);
    @try {
        if ([response.responseJson isKindOfClass:[NSArray class]])
        {
            
            id array=response.responseJson;
            NSDictionary *dictHere=[array lastObject];
            
            if ([[dictHere objectForKey:kStatusCode] isEqualToString:@"200"]) {
                
                GISViewEditStore *viewEditStore;
                
                if([viewEdit_Array count]>0)
                   [viewEdit_Array removeAllObjects];
                
                [[GISStoreManager sharedManager] removeViewEditObjects];
               viewEditStore=[[GISViewEditStore alloc]initWithJsonDictionary:response.responseJson];
               viewEdit_Array = [[GISStoreManager sharedManager] getViewEditObjects];
                
                [self addEventCalander:viewEdit_Array];
                
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
    }
    @catch (NSException *exception)
    {
        [self removeLoadingView];
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in get PatTypedata action %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
}
-(void)failuremethod_viewEditScheduledata:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
}

-(void)addLoadViewWithLoadingText:(NSString*)title
{
    [[GISLoadingView sharedDataManager] addLoadingAlertView:title];
    // _loadingView = [LoadingView loadingViewInView:self.navigationController.view andWithText:title];
    
}
-(void)removeLoadingView
{
    [[GISLoadingView sharedDataManager] removeLoadingAlertview];
}


- (IBAction) dateSelected:(id)sender{
    
//    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
//    
//    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
//    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
//    GISLoginDetailsObject *login_Obj=[requetId_array lastObject];
//    
//    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
//    [paramsDict setObject:[GISUtility eventDisplayFormat:[[FFDateManager sharedManager] currentDate]] forKey:@"StartDate"];
//    [paramsDict setObject:[GISUtility eventDisplayFormat:[[FFDateManager sharedManager] currentDate]] forKey:@"EndDate"];
//    [paramsDict setObject:@"" forKey:@"ServiceProvider"];
//    [paramsDict setObject:login_Obj.token_string forKey:@"token"];
//    [[GISServerManager sharedManager] getViewEditScheduledata:self withParams:paramsDict finishAction:@selector(successmethod_viewEditScheduledata:) failAction:@selector(failuremethod_viewEditScheduledata:)];
    
}

-(void)addEventCalander:(NSMutableArray *)eventArray{
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    [dictEvents removeAllObjects];
        
    for(GISViewEditDateObject *viewEditObject in eventArray){
        
        FFEvent *event = [FFEvent new];
        [event setStringCustomerName: viewEditObject.jobNumber_String];
        [event setNumCustomerID:[f numberFromString:viewEditObject.jobId_String]];
        [event setDateDay:[NSDate dateWithString:viewEditObject.jobDate_String]];
        NSString *str = [GISUtility getTimeData:viewEditObject.startTime_String];
        NSArray *strArray = [str componentsSeparatedByString:@":"];
        [event setDateTimeBegin:[NSDate dateWithHour:[[strArray objectAtIndex:0] intValue] min:[[strArray objectAtIndex:1] intValue]]];
        NSString *endTimestr = [GISUtility getTimeData:viewEditObject.endTime_String];
        NSArray *endTImestrArray = [endTimestr componentsSeparatedByString:@":"];
        [event setDateTimeEnd:[NSDate dateWithHour:[[endTImestrArray objectAtIndex:0] intValue] min:[[endTImestrArray objectAtIndex:1] intValue]]];
        [self addNewEvent:event];
    }
    
    [self removeLoadingView];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
