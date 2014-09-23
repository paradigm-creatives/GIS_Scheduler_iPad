//
//  GISVIewEditRequestViewController.m
//  GIS_Scheduler
//
//  Created by Anand on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISVIewEditRequestViewController.h"
#import "GISConstants.h"
#import "GISEventDetailsViewController.h"

#import "GISContactsAndBillingViewController.h"
#import "GISAttendeesViewController.h"
#import "GISDatesAndTimesViewController.h"
#import "GISCommentViewController.h"

#import "GISFonts.h"
#import "GISLocationDetailsViewController.h"
#import "GISUtility.h"
#import "GISDatabaseManager.h"
#import "GISStoreManager.h"
#import "GISServerManager.h"
#import "GISJSONProperties.h"
#import "GISJsonRequest.h"
#import "GISDatabaseConstants.h"
#import "GISConstants.h"
#import "GISContactsAndBillingViewController.h"
#import "GISJobDetailsViewController.h"
#import "GISSummaryViewController.h"
#import "GISViewEditServiceViewController.h"
#import "FFEvent.h"
#import "FFImportantFilesForCalendar.h"
#import "GISLoadingView.h"
#import "PCLogger.h"
#import "GISViewEditStore.h"

@interface GISVIewEditRequestViewController ()

@end

@implementation GISVIewEditRequestViewController

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
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    requestNumbers_mutArray = [[NSMutableArray alloc] init];
    viewEdit_Array = [[NSMutableArray alloc] init];
    
    self.title=@"View/Edit Service Request";
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[GISFonts normal], NSFontAttributeName,  UIColorFromRGB(0x00457c), NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
//    [[UITabBarItem appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:[GISFonts small], NSFontAttributeName,  [UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateHighlighted];
    
    GISContactsAndBillingViewController *contactsBillingView=[[GISContactsAndBillingViewController alloc]initWithNibName:@"GISContactsAndBillingViewController" bundle:nil];
    
    GISEventDetailsViewController *eventDetailsView=[[GISEventDetailsViewController alloc]initWithNibName:@"GISEventDetailsViewController" bundle:nil];
    GISLocationDetailsViewController *locationDetailsView=[[GISLocationDetailsViewController alloc]initWithNibName:@"GISLocationDetailsViewController" bundle:nil];
//    _viewControllers=[NSArray arrayWithObjects: eventDetailsView,locationDetailsView, nil];
//    _currentController= eventDetailsView;
//    [_mainView addSubview:_currentController.view];

    GISAttendeesViewController *attendeesView=[[GISAttendeesViewController alloc]initWithNibName:@"GISAttendeesViewController" bundle:nil];
    
    GISDatesAndTimesViewController *datesAndTimesView=[[GISDatesAndTimesViewController alloc]initWithNibName:@"GISDatesAndTimesViewController" bundle:nil];
    
    GISJobDetailsViewController *jobDetailsViewController=[[GISJobDetailsViewController alloc]initWithNibName:@"GISJobDetailsViewController" bundle:nil];
    
    GISSummaryViewController *summaryView =[[GISSummaryViewController alloc]initWithNibName:@"GISSummaryViewController" bundle:nil];

    GISCommentViewController *commentView=[[GISCommentViewController alloc]initWithNibName:@"GISCommentViewController" bundle:nil];
    
    GISViewEditServiceViewController *serviceView=[[GISViewEditServiceViewController alloc]initWithNibName:@"GISViewEditServiceViewController" bundle:nil];
    [serviceView setArrayWithEvents:[self arrayWithEvents]];
    
    _viewControllers=[NSArray arrayWithObjects:contactsBillingView, eventDetailsView,attendeesView,locationDetailsView,datesAndTimesView,jobDetailsViewController,summaryView,commentView,serviceView, nil];
    appDelegate.isDateView = YES;
    
    if(appDelegate.isFromViewEditService){
        
        _currentController= serviceView;

        [_topView setHidden:YES];
        CGRect frame = _mainView.frame;
        frame.origin.y = 64;
        _mainView.frame = frame;
        
    }else{
        _currentController= contactsBillingView;
    }
    
    [_mainView addSubview:_currentController.view];
    
    [[UINavigationBar appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[GISFonts large],NSFontAttributeName,UIColorFromRGB(0x00457c),NSForegroundColorAttributeName, nil]];

    [self setItemFont:_contactItem];
    [self setItemFont:_eventDetailsItem];
    [self setItemFont:_attendeesItem];
    [self setItemFont:_locationdetaislItem];
    [self setItemFont:_datesItem];
    [self setItemFont:_jobdetailsItem];
    [self setItemFont:_summarYItem];
    [self setItemFont:_commentsItem];
    
    [_contactItem setTitle:NSLocalizedStringFromTable(@"contact_billing", TABLE, nil)];
    [_eventDetailsItem setTitle:NSLocalizedStringFromTable(@"event_details", TABLE, nil)];
    [_attendeesItem setTitle:NSLocalizedStringFromTable(@"attendees", TABLE, nil)];
    [_locationdetaislItem setTitle:NSLocalizedStringFromTable(@"location_details", TABLE, nil)];
    [_datesItem setTitle:NSLocalizedStringFromTable(@"dates_times", TABLE, nil)];
    [_jobdetailsItem setTitle:NSLocalizedStringFromTable(@"job_details", TABLE, nil)];
    [_summarYItem setTitle:NSLocalizedStringFromTable(@"summary", TABLE, nil)];
    [_commentsItem setTitle:NSLocalizedStringFromTable(@"comments", TABLE, nil)];
    
    
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"selected.png"]];
    
    _contactItem.selectedImage = [[UIImage imageNamed:@"contact_and_billing_pressed.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _eventDetailsItem.selectedImage = [[UIImage imageNamed:@"event_details_pressed.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _attendeesItem.selectedImage = [[UIImage imageNamed:@"attendees_pressed.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _locationdetaislItem.selectedImage = [[UIImage imageNamed:@"location_pressed.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _datesItem.selectedImage = [[UIImage imageNamed:@"dates_and_times_pressed.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _jobdetailsItem.selectedImage = [[UIImage imageNamed:@"job_details_pressed.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _summarYItem.selectedImage = [[UIImage imageNamed:@"summary_pressed.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _commentsItem.selectedImage = [[UIImage imageNamed:@"comments_pressed.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIColor *titleHighlightedColor = UIColorFromRGB(0xffffff);
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    
    self.navigationItem.title = @"View/Edit Service Request";
    
    self.requestID_Label.textColor=UIColorFromRGB(0x00457c);
    self.created_by_value_Label.textColor=UIColorFromRGB(0x00457c);
    self.created_date_value_Label.textColor=UIColorFromRGB(0x00457c);
    self.status_value_Label.textColor=UIColorFromRGB(0x00457c);
    
    self.created_by_Label.textColor=UIColorFromRGB(0x666666);
    self.created_date_Label.textColor=UIColorFromRGB(0x666666);
    self.status_Label.textColor=UIColorFromRGB(0x666666);
    
    self.requestID_Label.font=[GISFonts normal];
    self.created_by_Label.font=[GISFonts normal];
    self.created_date_Label.font=[GISFonts normal];
    self.status_Label.font=[GISFonts normal];
    
    self.created_by_value_Label.font=[GISFonts normal];
    self.created_date_value_Label.font=[GISFonts normal];
    self.status_value_Label.font=[GISFonts normal];
    
    [_requestBtn.titleLabel setFont:[GISFonts small]];
    [_requestBtn.titleLabel setTextColor:UIColorFromRGB(0x00457c)];
    
    if(appDelegate.isNewRequest){
        [_requestBtn setTitle:NSLocalizedStringFromTable(@"new request", TABLE, nil) forState:UIControlStateNormal];
        [_requestBtn removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
        appDelegate.chooseRequest_ID_String = @"0";
    }else{
        [_requestBtn setTitle:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil) forState:UIControlStateNormal];
        [_requestBtn addTarget:self action:@selector(showPopoverDetails:) forControlEvents:UIControlEventTouchUpInside];
        appDelegate.chooseRequest_ID_String = _requestBtn.titleLabel.text;
    }
    
    [[UITabBar appearance] setSelectedItem:_contactItem];
    
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    login_Obj=[requetId_array lastObject];
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    [paramsDict setObject:login_Obj.requestorID_string forKey:kID];
    [paramsDict setObject:login_Obj.token_string forKey:kToken];
    [[GISStoreManager sharedManager]removeRequestNumbersObjects];
    
    [[GISServerManager sharedManager] getRequestNumbersData:self withParams:paramsDict finishAction:@selector(successmethod_chooseRequest:) failAction:@selector(failuremethod_chooseRequest:)];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moveUp:) name:kMoveUp object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabSelcted:) name:kTabSelected object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getRequestInfo) name:kRequestInfo object:nil];
       
    [self getUpdatedEventDetails];
    

}


-(void)setItemFont:(UITabBarItem *)tabbarItem{
    [tabbarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                          UIColorFromRGB(0x00457c), NSForegroundColorAttributeName,
                                          [GISFonts small], NSFontAttributeName, nil]
                                forState:UIControlStateNormal];
    //[NSValue  valueWithUIOffset:UIOffsetMake(0,0)], NSShadowAttributeName,
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor yellowColor]];
    UIViewController *selectedTabView=nil;
    
    selectedTabView= [_viewControllers objectAtIndex:item.tag];
    
    [_currentController.view removeFromSuperview];
    _currentController=selectedTabView;
    
    if(_currentController == [_viewControllers objectAtIndex:0]){
        
        appDelegate.isContact = YES;
    }else{
        
        appDelegate.isContact = NO;
    }

    for (UIView *subView in _mainView.subviews)
    {
        [subView removeFromSuperview];
    }
    [_mainView addSubview:selectedTabView.view];
    [self.view bringSubviewToFront:_mainView];
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    appDelegate.chooseRequest_ID_String=id_str;
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:id_str forKey:@"id"];
    [dict setValue:value_str forKey:@"value"];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kselectedChooseReqNumber object:nil userInfo:dict];
    
    //[self.chooseReq_protocol selectedChooseRequestNumber:id_str :value_str];
    [_requestBtn setTitle:value_str forState:UIControlStateNormal];
    
    
    if(_popover)
        [_popover dismissPopoverAnimated:YES];
    
}

- (IBAction)showPopoverDetails:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    
     GISPopOverTableViewController *tableViewController = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController.popOverDelegate = self;

    _popover =   [GISUtility showPopOver:(NSMutableArray *)_requetDetails viewController:tableViewController];
       
    _popover.delegate = self;
    
    
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }
    
    [_popover presentPopoverFromRect:CGRectMake(btn.frame.origin.x+btn.frame.size.width-15, btn.frame.origin.y+15, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}


-(void)successmethod_chooseRequest:(GISJsonRequest *)response
{
    NSLog(@"Success---%@",response.responseJson);
    dropDownStore=[[GISDropDownStore alloc]initWithStoreDictionary:response.responseJson];
    requestNumbers_mutArray=[[GISStoreManager sharedManager]getRequestNumbersObjects];
    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_CHOOSE_REQUEST];
    for (int i=0; i<requestNumbers_mutArray.count; i++) {
        GISDropDownsObject *bObj=[requestNumbers_mutArray objectAtIndex:i];
        NSArray *objectsArray1 = [NSArray arrayWithObjects:bObj.id_String,bObj.type_String,bObj.value_String, nil];
        NSArray *keysArray1 = [NSArray arrayWithObjects: kDropDownID, kDropDownType,kDropDownValue, nil];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
        [[GISDatabaseManager sharedDataManager] insertDropDownData:dic Query:[NSString stringWithFormat:@"INSERT INTO TBL_CHOOSE_REQUEST(ID,TYPE,VALUE) VALUES (?,?,?)"]];
    }
    NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_CHOOSE_REQUEST  ORDER BY ID DESC;"];
    _requetDetails = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
}

-(void)failuremethod_chooseRequest:(GISJsonRequest *)response
{
    NSLog(@"Failure");
}

-(void)moveUp:(NSNotification *) notification{
    
    NSDictionary *infoDict=notification.userInfo;
    
    NSString *value;
    if(infoDict != nil){
       value =[infoDict objectForKey:@"yValue"];
    }
    
   [GISUtility moveemailView:YES viewHeight:[value intValue] view:self.view];
}

-(void)tabSelcted:(NSNotification *) notification{
    
    NSDictionary *infoDict=notification.userInfo;
    
    NSString *value;
    if(infoDict != nil){
        value =[infoDict objectForKey:@"tabValue"];
    }
    
    UITabBarItem *tabItem = [self.mainTabbar.items objectAtIndex:[value intValue]];
    [self tabBar:self.mainTabbar didSelectItem:tabItem];
    [self.mainTabbar setSelectedItem:tabItem];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [_requestBtn setTitle:[userDefaults valueForKey:kDropDownValue] forState:UIControlStateNormal];
    appDelegate.chooseRequest_ID_String = [userDefaults valueForKey:kDropDownID];
    
}

-(void)getRequestInfo{
    
    _created_by_value_Label.text = appDelegate.createdByString;
    _created_date_value_Label.text = appDelegate.createdDateString;
    _status_value_Label.text = appDelegate.statusString;
    
    _created_by_value_Label.textColor = UIColorFromRGB(0x003e84);
    _created_date_value_Label.textColor = UIColorFromRGB(0x003e84);
    _status_value_Label.textColor = UIColorFromRGB(0x003e84);
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kMoveUp object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kTabSelected object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kRequestInfo object:nil];
    
}

- (NSMutableArray *)arrayWithEvents {
    
    return nil;
}

- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"rightSwipeHandle");
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"leftSwipeHandle");
}

-(void)getUpdatedEventDetails{
    
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    GISLoginDetailsObject *login_Objs=[requetId_array lastObject];
    
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
    [paramsDict setObject:login_Objs.token_string forKey:@"token"];
    [[GISServerManager sharedManager] getViewEditScheduledata:self withParams:paramsDict finishAction:@selector(successmethod_viewEditScheduledata:) failAction:@selector(failuremethod_viewEditScheduledata:)];

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


-(void)addEventCalander:(NSMutableArray *)eventArray{
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSMutableArray *eventDetailsView =  [[NSMutableArray alloc] init];
    
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
        [eventDetailsView addObject:event];
    }
    
    GISViewEditServiceViewController *serviceView=[[GISViewEditServiceViewController alloc]initWithNibName:@"GISViewEditServiceViewController" bundle:nil];
    [serviceView setArrayWithEvents:eventDetailsView];
    
    if(appDelegate.isFromViewEditService){
        _currentController= serviceView;
        [_topView setHidden:YES];
        CGRect frame = _mainView.frame;
        frame.origin.y = 64;
        _mainView.frame = frame;
    }
    [_currentController.view removeFromSuperview];
    [_mainView addSubview:_currentController.view];
    
    [self removeLoadingView];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
