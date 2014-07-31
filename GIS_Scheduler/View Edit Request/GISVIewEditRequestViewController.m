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
    
    self.title=@"View/Edit Service Request";
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[GISFonts normal], NSFontAttributeName,  UIColorFromRGB(0x00457c), NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
//    [[UITabBarItem appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:[GISFonts small], NSFontAttributeName,  [UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateHighlighted];
    
    GISContactsAndBillingViewController *contactsBillingView=[[GISContactsAndBillingViewController alloc]initWithNibName:@"GISContactsAndBillingViewController" bundle:nil];
    
    GISEventDetailsViewController *eventDetailsView=[[GISEventDetailsViewController alloc]initWithNibName:@"GISEventDetailsViewController" bundle:nil];
    GISLocationDetailsViewController *locationDetailsView=[[GISLocationDetailsViewController alloc]initWithNibName:@"GISLocationDetailsViewController" bundle:nil];
    _viewControllers=[NSArray arrayWithObjects: eventDetailsView,locationDetailsView, nil];
    _currentController= eventDetailsView;
    [_mainView addSubview:_currentController.view];

    GISAttendeesViewController *attendeesView=[[GISAttendeesViewController alloc]initWithNibName:@"GISAttendeesViewController" bundle:nil];
    
    GISDatesAndTimesViewController *datesAndTimesView=[[GISDatesAndTimesViewController alloc]initWithNibName:@"GISDatesAndTimesViewController" bundle:nil];

    

    
    GISCommentViewController *commentView=[[GISCommentViewController alloc]initWithNibName:@"GISCommentViewController" bundle:nil];
    
    _viewControllers=[NSArray arrayWithObjects:contactsBillingView, eventDetailsView,attendeesView,locationDetailsView,datesAndTimesView,commentView, nil];
    
    _currentController= contactsBillingView;
    
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
    self.requestID_Label.font=[GISFonts normal];
    [_requestBtn.titleLabel setFont:[GISFonts small]];
    
    
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
    
}

-(void)setItemFont:(UITabBarItem *)tabbarItem{
    
    [tabbarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                          UIColorFromRGB(0x00457c), NSForegroundColorAttributeName,
                                          [GISFonts small], NSFontAttributeName, nil]
                                forState:UIControlStateNormal];//[NSValue  valueWithUIOffset:UIOffsetMake(0,0)], NSShadowAttributeName,
    

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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
