//
//  GISDashBoardViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 09/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISDashBoardViewController.h"
#import "GISFonts.h"
#import "GISConstants.h"
#import "GISDashBoardCell.h"
#import "GISVIewEditRequestViewController.h"
#import "GISDashBoardReqCell.h"
#import "GISDashBoardSPCell.h"
#import "GISStoreManager.h"
#import "GISServerManager.h"
#import "GISJsonRequest.h"
#import "GISJSONProperties.h"
#import "GISLoadingView.h"
#import "PCLogger.h"
#import "GISDatabaseManager.h"
#import "GISDropDownStore.h"
#import "GISDropDownsObject.h"
#import "GISUtility.h"
#import "GISServiceProviderRequestedJobsViewController.h"
#import "GISViewEditServiceViewController.h"
#import "GISJobAssignmentViewController.h"
#import "GISFindRequestJobsViewController.h"


@interface GISDashBoardViewController ()

@end

@implementation GISDashBoardViewController

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
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    
    //add the your gestureRecognizer , where to detect the touch..
    [datListView addGestureRecognizer:rightRecognizer];
    
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    
    [datListView addGestureRecognizer:leftRecognizer];
    
    self.isMasterHide= YES;
    
    self.title=@"DashBoard";
    
    SPJobsArray = [[NSMutableArray alloc] init];
    NMRequestsArray = [[NSMutableArray alloc] init];
    
    _gisresponseArray = [[NSArray alloc] initWithObjects:@"Select",@"Assigned",@"Not Assigned",@"Need More Information", nil];
    
    [self performSelector:@selector(hideAndUnHideMaster:) withObject:nil];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UISegmentedControl appearance] setTintColor:UIColorFromRGB(0x00457c)];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xffffff) ,NSFontAttributeName : [GISFonts normal]} forState:UIControlStateHighlighted];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x00457c) ,NSFontAttributeName : [GISFonts normal]} forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [GISFonts normal]} forState:UIControlStateSelected];

    accountName_Label.font=[GISFonts normal];
    requestID_Label.font=[GISFonts normal];
    eventType_Label.font=[GISFonts normal];
    otherServices_Label.font=[GISFonts normal];
    earliestDate_Label.font=[GISFonts normal];
    approvalDate_Label.font=[GISFonts normal];
    approvedBy_Label.font=[GISFonts normal];
    status_Label.font=[GISFonts normal];
    scheduler_Label.font=[GISFonts normal];
    newIncomingRequest_Count_Label.font=[GISFonts normal];
    requestForModification_Count_Label.font=[GISFonts normal];
    serviceProvReqJobs_Count_Label.font=[GISFonts normal];
    newRequest_Label.font=[GISFonts small];
    inProgress_Label.font=[GISFonts small];
    onHold_Label.font=[GISFonts small];
    waitingForApproval_Label.font=[GISFonts small];
    approvedRequest_Label.font=[GISFonts small];
    incompleteRequest_Label.font=[GISFonts small];
    
    accountNameReq_Label.font=[GISFonts normal];
    requestIDReq_Label.font=[GISFonts normal];
    eventTypeReq_Label.font=[GISFonts normal];
    otherServicesReq_Label.font=[GISFonts normal];
    submissionDateReq_Label.font=[GISFonts normal];
    earlierDateReq_Label.font=[GISFonts normal];
    statusReq_Label.font=[GISFonts normal];
    schedulerReq_Label.font=[GISFonts normal];
    
    jobNameSP_Label.font=[GISFonts normal];
    jobDateSP_Label.font=[GISFonts normal];
    startTimeSP_Label.font=[GISFonts normal];
    endTimeSP_Label.font=[GISFonts normal];
    totalHoursSP_Label.font=[GISFonts normal];
    eventtypeSP_Label.font=[GISFonts normal];
    serviceProviderSP_Label.font=[GISFonts normal];
    requestedDateSP_Label.font=[GISFonts normal];
    payTypeSP_Label.font=[GISFonts normal];
    gisResponseSP_Label.font=[GISFonts normal];

    accountName_Label.textColor=UIColorFromRGB(0x00457c);
    requestID_Label.textColor=UIColorFromRGB(0x00457c);
    eventType_Label.textColor=UIColorFromRGB(0x00457c);
    otherServices_Label.textColor=UIColorFromRGB(0x00457c);
    earliestDate_Label.textColor=UIColorFromRGB(0x00457c);
    approvalDate_Label.textColor=UIColorFromRGB(0x00457c);
    approvedBy_Label.textColor=UIColorFromRGB(0x00457c);
    status_Label.textColor=UIColorFromRGB(0x00457c);
    scheduler_Label.textColor=UIColorFromRGB(0x00457c);
    newIncomingRequest_Count_Label.textColor=UIColorFromRGB(0x00457c);
    requestForModification_Count_Label.textColor=UIColorFromRGB(0x00457c);
    serviceProvReqJobs_Count_Label.textColor=UIColorFromRGB(0x00457c);
    newRequest_Label.textColor=UIColorFromRGB(0x333333);
    inProgress_Label.textColor=UIColorFromRGB(0x333333);
    onHold_Label.textColor=UIColorFromRGB(0x333333);
    waitingForApproval_Label.textColor=UIColorFromRGB(0x333333);
    approvedRequest_Label.textColor=UIColorFromRGB(0x333333);
    incompleteRequest_Label.textColor=UIColorFromRGB(0x333333);
    
    accountNameReq_Label.textColor=UIColorFromRGB(0x00457c);
    requestIDReq_Label.textColor=UIColorFromRGB(0x00457c);
    eventTypeReq_Label.textColor=UIColorFromRGB(0x00457c);
    otherServicesReq_Label.textColor=UIColorFromRGB(0x00457c);
    submissionDateReq_Label.textColor=UIColorFromRGB(0x00457c);
    earlierDateReq_Label.textColor=UIColorFromRGB(0x00457c);
    statusReq_Label.textColor=UIColorFromRGB(0x00457c);
    schedulerReq_Label.textColor=UIColorFromRGB(0x00457c);
    
    jobNameSP_Label.textColor=UIColorFromRGB(0x00457c);
    jobDateSP_Label.textColor=UIColorFromRGB(0x00457c);
    startTimeSP_Label.textColor=UIColorFromRGB(0x00457c);
    endTimeSP_Label.textColor=UIColorFromRGB(0x00457c);
    totalHoursSP_Label.textColor=UIColorFromRGB(0x00457c);
    eventtypeSP_Label.textColor=UIColorFromRGB(0x00457c);
    serviceProviderSP_Label.textColor=UIColorFromRGB(0x00457c);
    requestedDateSP_Label.textColor=UIColorFromRGB(0x00457c);
    payTypeSP_Label.textColor=UIColorFromRGB(0x00457c);
    gisResponseSP_Label.textColor=UIColorFromRGB(0x00457c);
    
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    GISLoginDetailsObject *login_Obj=[requetId_array lastObject];
    
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    [paramsDict setObject:login_Obj.requestorID_string forKey:@"id"];
    [paramsDict setObject:login_Obj.token_string forKey:@"token"];
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    [[GISServerManager sharedManager] getSchedulerNewandModifiedRequests:self withParams:paramsDict finishAction:@selector(successmethod_NewModifiedRequests:) failAction:@selector(failuremethod_NewModifiedRequests:)];
    [[GISServerManager sharedManager] getSchedulerRequestedJobs:self withParams:paramsDict finishAction:@selector(successmethod_Requestjobs:) failAction:@selector(failuremethod_Requestjobs:)];
    
    [_countLabel1 setFont:[GISFonts tiny]];
    _countLabel1.textAlignment = NSTextAlignmentCenter;
    _countLabel1.layer.cornerRadius = 10.0;
    _countLabel1.layer.masksToBounds = YES;
    [_countLabel1 setTextColor:[UIColor blackColor]];
    _countLabel1.userInteractionEnabled = YES;
    
    [_countLabel2 setFont:[GISFonts tiny]];
    _countLabel2.textAlignment = NSTextAlignmentCenter;
    _countLabel2.layer.cornerRadius = 10.0;
    _countLabel2.layer.masksToBounds = YES;
    [_countLabel2 setTextColor:[UIColor blackColor]];
    _countLabel2.userInteractionEnabled = YES;
    
    [_countLabel3 setFont:[GISFonts tiny]];
    _countLabel3.textAlignment = NSTextAlignmentCenter;
    _countLabel3.layer.cornerRadius = 10.0;
    _countLabel3.layer.masksToBounds = YES;
    [_countLabel3 setTextColor:[UIColor blackColor]];
    _countLabel3.userInteractionEnabled = YES;

}


- (BOOL)splitViewController: (UISplitViewController*)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return self.isMasterHide;
}

- (IBAction)hideAndUnHideMaster:(id)sender
{
    datListView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    UIButton *btn = (UIButton*)sender;
    GISAppDelegate *appDelegate1 = (GISAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.isMasterHide= !self.isMasterHide;
    NSString *buttonTitle = self.isMasterHide ? @""  : @"  "; //@""== Unhide   @"  "==Hide
    if ([buttonTitle isEqualToString:@""])
    {
        dashBoard_UIView.hidden=NO;
        CGRect frame1=datListView.frame;
        frame1.origin.x=75;
        datListView.frame=frame1;
    }
    else
    {
        dashBoard_UIView.hidden=YES;
        CGRect frame1=datListView.frame;
        frame1.origin.x=0;
        datListView.frame=frame1;
    }
    
    [btn setTitle:buttonTitle forState:UIControlStateNormal];
    [ appDelegate1.spiltViewController.view setNeedsLayout ];
    appDelegate1.spiltViewController.delegate = self;
    
    [appDelegate1.spiltViewController willRotateToInterfaceOrientation:self.interfaceOrientation duration:0];
}

- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"rightSwipeHandle");
    [self performSelector:@selector(hideAndUnHideMaster:) withObject:nil];
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"leftSwipeHandle");
    [self performSelector:@selector(hideAndUnHideMaster:) withObject:nil];
}

-(IBAction)SegmentToggle:(UISegmentedControl*)sender {
    
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    GISLoginDetailsObject *login_Obj=[requetId_array lastObject];
    
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    [paramsDict setObject:login_Obj.requestorID_string forKey:@"id"];
    [paramsDict setObject:login_Obj.token_string forKey:@"token"];

    if (sender.selectedSegmentIndex==0) {
        tableHeader1_UIView.hidden = FALSE;
        tableHeader2_UIView.hidden = TRUE;
        tableHeader3_UIView.hidden = TRUE;
        
        CGRect frame = listTableView.frame;
        frame.origin.x = 0;
        listTableView.frame = frame;
        
        [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
        [[GISServerManager sharedManager] getSchedulerNewandModifiedRequests:self withParams:paramsDict finishAction:@selector(successmethod_NewModifiedRequests:) failAction:@selector(failuremethod_NewModifiedRequests:)];

    }
    else if(sender.selectedSegmentIndex==1)
    {
        tableHeader2_UIView.hidden = FALSE;
        tableHeader1_UIView.hidden = TRUE;
        tableHeader3_UIView.hidden = TRUE;
        
        CGRect frame = listTableView.frame;
        frame.origin.x = 20;
        listTableView.frame = frame;
        
        [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
        
        [[GISServerManager sharedManager] getSchedulerNewandModifiedRequests:self withParams:paramsDict finishAction:@selector(successmethod_NewModifiedRequests:) failAction:@selector(failuremethod_NewModifiedRequests:)];
    
    }
    else if(sender.selectedSegmentIndex==2)
    {
        tableHeader3_UIView.hidden = FALSE;
        tableHeader1_UIView.hidden = TRUE;
        tableHeader2_UIView.hidden = TRUE;
        
        CGRect frame = listTableView.frame;
        frame.origin.x = 0;
        listTableView.frame = frame;
        
        [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
        
        [[GISServerManager sharedManager] getSchedulerRequestedJobs:self withParams:paramsDict finishAction:@selector(successmethod_Requestjobs:) failAction:@selector(failuremethod_Requestjobs:)];
        
        [[GISServerManager sharedManager] getPayTypedata:self withParams:paramsDict finishAction:@selector(successmethod_PatTypedata:) failAction:@selector(failuremethod_PatTypedata:)];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!tableHeader3_UIView.isHidden){
        return [SPJobsArray count];
    }
    else if(!tableHeader1_UIView.isHidden){
        return [NMRequestsArray count];
    }
    else if (!tableHeader2_UIView.isHidden){
        return [NMRequestsArray count];
    }
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISDashBoardCell *cell;
    if(!tableHeader1_UIView.isHidden){
       GISDashBoardCell *cell=(GISDashBoardCell *)[tableView dequeueReusableCellWithIdentifier:@"dashBoardCell"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISDashBoardCell" owner:self options:nil] objectAtIndex:0];
        }
        
        GISSchedulerNMRequestsObject *nmReqObj = [NMRequestsArray objectAtIndex:indexPath.row];

        cell.accountName_Label.text = nmReqObj.AccountName_String;
        cell.requestID_Label.text = nmReqObj.RequestID_String;
        cell.eventType_Label.text = nmReqObj.EventType_String;
        cell.otherServices_Label.text = nmReqObj.OtherServices_String;
        cell.earliestDate_Label.text = nmReqObj.EarliestDate_String;
        cell.approvalDate_Label.text = nmReqObj.ApprovalDate_String;
        cell.approvedBy_Label.text = nmReqObj.ApproveddBy_String;
        cell.scheduler_Label.text = nmReqObj.Shceduler_String;
        
        if ([nmReqObj.RequestStatus_String isEqualToString:@"SkyBlue"]) {
            cell.status_Label.backgroundColor=UIColorFromRGB(0x6698FF);
        }else if ([nmReqObj.RequestStatus_String isEqualToString:@"Yellow"]) {
            cell.status_Label.backgroundColor=[UIColor yellowColor];
        }else if ([nmReqObj.RequestStatus_String isEqualToString:@"Orange"]) {
            cell.status_Label.backgroundColor=[UIColor orangeColor];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }
    if(!tableHeader2_UIView.isHidden){
        
        GISDashBoardReqCell *cell=(GISDashBoardReqCell *)[tableView dequeueReusableCellWithIdentifier:@"dashBoardReqCell"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISDashBoardReqCell" owner:self options:nil] objectAtIndex:0];
        }
        
        GISSchedulerNMRequestsObject *nmReqObj = [NMRequestsArray objectAtIndex:indexPath.row];
        
        cell.accountName_Label.text = nmReqObj.AccountName_String;
        cell.requestID_Label.text = nmReqObj.RequestID_String;
        cell.eventType_Label.text = nmReqObj.EventType_String;
        cell.otherServices_Label.text = nmReqObj.OtherServices_String;
        cell.requestSubmissinDate_Label.text = nmReqObj.RequestSubmissionDate_String;
        cell.dateOfEarlier_Label.text = nmReqObj.DateofEarlierAssigment_String;
        cell.scheduler_Label.text = nmReqObj.Shceduler_String;
        
        if ([nmReqObj.RequestStatus_String isEqualToString:@"SkyBlue"]) {
            cell.status_Label.backgroundColor=UIColorFromRGB(0x6698FF);
        }else if ([nmReqObj.RequestStatus_String isEqualToString:@"Yellow"]) {
            cell.status_Label.backgroundColor=[UIColor yellowColor];
        }else if ([nmReqObj.RequestStatus_String isEqualToString:@"Orange"]) {
            cell.status_Label.backgroundColor=[UIColor orangeColor];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }
    if(!tableHeader3_UIView.isHidden){
        
        GISDashBoardSPCell *cell=(GISDashBoardSPCell *)[tableView dequeueReusableCellWithIdentifier:@"dashBoardSPCell"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISDashBoardSPCell" owner:self options:nil] objectAtIndex:0];
        }
        
        GISSchedulerSPJobsObject *spJobsObj = [SPJobsArray objectAtIndex:indexPath.row];
        
        [cell.jobId_Label setText:spJobsObj.JobNumber_String];
        [cell.jobdate_Label setText:spJobsObj.JobDate_String];
        [cell.startTime_Label setText:spJobsObj.startTime_String];
        [cell.endTime_Label setText:spJobsObj.endTime_String];
        [cell.totalHours_Label setText:spJobsObj.TotalHours_String];
        [cell.eventType_Label setText:spJobsObj.EventType_String];
        [cell.serviceProviderName_Label setText:spJobsObj.ServiceProviderName_String];
        [cell.requestedDate_Label setText:spJobsObj.RequestedDate_String];
        
        NSArray *payTypeArray = [[GISStoreManager sharedManager] getPayTypeObjects];
        
        for (GISDropDownsObject *dropDownObj in payTypeArray) {
            if ([dropDownObj.id_String isEqualToString:spJobsObj.PayType_id_String]) {
                spJobsObj.PayType_String=dropDownObj.value_String;
            }
        }

        [cell.done_btn addTarget:self action:@selector(saveSPData:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.payType_btn addTarget:self action:@selector(showPopoverDetails_payType_btn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.payType_btn setTitleColor:UIColorFromRGB(0x616161) forState:UIControlStateNormal];
        
        if([spJobsObj.PayType_String length] == 0)
           [cell.payType_btn setTitle:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil) forState:UIControlStateNormal];
        else
            [cell.payType_btn setTitle:spJobsObj.PayType_String forState:UIControlStateNormal];
        
        [cell.response_status_btn addTarget:self action:@selector(showPopoverDetails_response_status_btn:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.response_status_btn setTitleColor:UIColorFromRGB(0x616161) forState:UIControlStateNormal];
        
        if([spJobsObj.GisResponse_String length] == 0)
            [cell.response_status_btn setTitle:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil) forState:UIControlStateNormal];
        else
            [cell.response_status_btn setTitle:spJobsObj.GisResponse_String forState:UIControlStateNormal];
        
        [cell.payType_btn setTag:indexPath.row];
        [cell.response_status_btn setTag:indexPath.row];
        [cell.done_btn setTag:indexPath.row];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        return cell;
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

-(void)pushToViewController:(int)section rowValue:(int)row{
    
     appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if(section == 0){
        appDelegate.isFromViewEditService = NO;
        [self.navigationController popViewControllerAnimated:NO];
    }
    else if(section ==1){
        
        appDelegate.isFromViewEditService = NO;
        
        [self.navigationController popViewControllerAnimated:NO];
        
        if(row == 1){
            
            appDelegate.isNewRequest = NO;
            GISVIewEditRequestViewController *viewEditView=[[GISVIewEditRequestViewController alloc]initWithNibName:@"GISVIewEditRequestViewController" bundle:nil];
            [self.navigationController pushViewController:viewEditView animated:NO];
        }else if(row == 0){
            
            appDelegate.isNewRequest = YES;
            GISVIewEditRequestViewController *viewEditView=[[GISVIewEditRequestViewController alloc]initWithNibName:@"GISVIewEditRequestViewController" bundle:nil];
            [self.navigationController pushViewController:viewEditView animated:NO];
        }
        else if(row == 2){
            GISServiceProviderRequestedJobsViewController *serviceProviderRequested=[[GISServiceProviderRequestedJobsViewController alloc]initWithNibName:@"GISServiceProviderRequestedJobsViewController" bundle:nil];
            [self.navigationController pushViewController:serviceProviderRequested animated:NO];
        }
        
    } else if(section ==2){
        
        [self.navigationController popViewControllerAnimated:NO];
        
        if (row==0) {
            
            appDelegate.isFromViewEditService = NO;
            GISJobAssignmentViewController *detailViewController = (GISJobAssignmentViewController *)[[GISJobAssignmentViewController alloc]initWithNibName:@"GISJobAssignmentViewController" bundle:nil];
            detailViewController.view_string = kJobAssignment_Screen;
            [self.navigationController pushViewController:detailViewController animated:NO];
        }

        if(row == 1){
            
            appDelegate.isFromViewEditService = YES;
            GISVIewEditRequestViewController *viewEditView=[[GISVIewEditRequestViewController alloc]initWithNibName:@"GISVIewEditRequestViewController" bundle:nil];
            
            [self.navigationController pushViewController:viewEditView animated:NO];
            
//            GISViewEditServiceViewController *serviceViewController =[[GISViewEditServiceViewController alloc]initWithNibName:@"GISViewEditServiceViewController" bundle:nil];
//            [self.navigationController pushViewController:serviceViewController animated:NO];
        }
    }
    
  
    else if(section == 3){
        
        [self.navigationController popViewControllerAnimated:NO];
        
        appDelegate.isFromViewEditService = NO;
        
        if (row==0) {
            
            GISFindRequestJobsViewController *findReqJobs=(GISFindRequestJobsViewController *)[[GISFindRequestJobsViewController alloc]initWithNibName:@"GISFindRequestJobsViewController" bundle:nil];
            [self.navigationController pushViewController:findReqJobs animated:NO];
            
//            GISJobAssignmentViewController *detailViewController = (GISJobAssignmentViewController *)[[GISJobAssignmentViewController alloc]initWithNibName:@"GISJobAssignmentViewController" bundle:nil];
//            detailViewController.view_string = kFindRequestJobs_Screen;
//            [self.navigationController pushViewController:detailViewController animated:NO];
            
        }
    }
}

-(void)successmethod_Requestjobs:(GISJsonRequest *)response
{
    
    NSLog(@"successmethod_getRequestJobs Success---%@",response.responseJson);
    @try {
        if ([response.responseJson isKindOfClass:[NSArray class]])
        {
            
            id array=response.responseJson;
            NSDictionary *dictHere=[array lastObject];
            
            if ([[dictHere objectForKey:kStatusCode] isEqualToString:@"200"]) {
                
                [[GISStoreManager sharedManager] removeRequestJobs_SPJobsObject];
                spJobsStore=[[GISSchedulerSPJobsStore alloc]initWithJsonDictionary:response.responseJson];
                SPJobsArray=[[GISStoreManager sharedManager] getRequestJobs_SPJobsObject];
                [_countLabel3 setText:[NSString stringWithFormat:@"%d",[SPJobsArray count]]];

                
                [self removeLoadingView];
                
                [listTableView reloadData];
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
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in get Request JObs action %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
}
-(void)failuremethod_Requestjobs:(GISJsonRequest *)response
{
    NSLog(@"Failure");
}

-(void)successmethod_NewModifiedRequests:(GISJsonRequest *)response
{
    
    NSLog(@"successmethod_getRequestJobs Success---%@",response.responseJson);
    @try {
        if ([response.responseJson isKindOfClass:[NSArray class]])
        {
            
            id array=response.responseJson;
            NSDictionary *dictHere=[array lastObject];
            
            if ([[dictHere objectForKey:kStatusCode] isEqualToString:@"200"]) {
                
                [[GISStoreManager sharedManager] removeRequest_NMRequestObject];

                nmRequestStore=[[GISSchedulerNMRequestsStore alloc]initWithJsonDictionary:response.responseJson];
                NMRequestsArray=[[GISStoreManager sharedManager] getRequest_NMRequestObject];
                
                [_countLabel1 setText:[NSString stringWithFormat:@"%d",[NMRequestsArray count]]];
                [_countLabel2 setText:[NSString stringWithFormat:@"%d",[NMRequestsArray count]]];
                
                [self removeLoadingView];
                
                [listTableView reloadData];
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
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in get Request JObs action %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
}
-(void)failuremethod_NewModifiedRequests:(GISJsonRequest *)response
{
    NSLog(@"Failure");
}

-(void)successmethod_PatTypedata:(GISJsonRequest *)response
{
    
    NSLog(@"successmethod_PatTypedata Success---%@",response.responseJson);
    @try {
        if ([response.responseJson isKindOfClass:[NSArray class]])
        {
            
            id array=response.responseJson;
            NSDictionary *dictHere=[array lastObject];
            
            if ([[dictHere objectForKey:kStatusCode] isEqualToString:@"200"]) {
                
                GISDropDownStore *dropDownStore;
                
                [[GISStoreManager sharedManager] removePayTypeObjects];
                dropDownStore=[[GISDropDownStore alloc]initWithStoreDictionary:response.responseJson];
                _payTypeArray = [[GISStoreManager sharedManager] getPayTypeObjects];
                [self removeLoadingView];
                
                //[listTableView reloadData];
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
-(void)failuremethod_PatTypedata:(GISJsonRequest *)response
{
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


- (IBAction)showPopoverDetails_payType_btn:(id)sender{
    
    pay_type = YES;
    
    UIButton *btn=(UIButton*)sender;
    
    GISDashBoardSPCell *spCell=(GISDashBoardSPCell *)btn.superview.superview.superview;
    
    btn_tag = btn.tag;
    
    GISPopOverTableViewController *tableViewController = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    
    tableViewController.popOverDelegate = self;
    
    _popover =   [GISUtility showPopOver:(NSMutableArray *)_payTypeArray viewController:tableViewController];
    _popover.delegate = self;
    
    _popover.popoverContentSize = CGSizeMake(180, 210);

    
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }
    [_popover presentPopoverFromRect:CGRectMake(spCell.payType_btn.frame.origin.x+66, spCell.payType_btn.frame.origin.y+12, 1, 1) inView:spCell.contentView permittedArrowDirections:UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown  animated:YES];
    
    
}

- (IBAction)showPopoverDetails_response_status_btn:(id)sender{
    
    pay_type = NO;
    
    UIButton *btn=(UIButton*)sender;
    
    GISDashBoardSPCell *spCell=(GISDashBoardSPCell *)btn.superview.superview.superview;
    
    btn_tag = btn.tag;
    
    GISPopOverTableViewController *tableViewController = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    
    tableViewController.popOverDelegate = self;
    
    _popover =   [GISUtility showPopOver:(NSMutableArray *)_gisresponseArray viewController:tableViewController];
    _popover.delegate = self;
    
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }
    [_popover presentPopoverFromRect:CGRectMake(spCell.response_status_btn.frame.origin.x+66, spCell.response_status_btn.frame.origin.y+12, 1, 1) inView:spCell.contentView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    if(pay_type){
        
        pay_type_data= value_str;
        pay_type_ID_String=id_str;
        
        GISSchedulerSPJobsObject *spJobsObj = [SPJobsArray objectAtIndex:btn_tag];
        spJobsObj.PayType_String = pay_type_data;
        spJobsObj.PayType_id_String = pay_type_ID_String;
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:btn_tag inSection:0];
        
        NSArray *reloadArray = [[NSArray alloc] initWithObjects:path, nil];
        
        [listTableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
        
    }else{
        
        gis_response_data= value_str;
        if([gis_response_data isEqualToString:@"Select"]){
            
            gisresponse_ID_String=@"0";
        }else if([gis_response_data isEqualToString:@"Assigned"]){
            
            gisresponse_ID_String=@"1";
        }else if([gis_response_data isEqualToString:@"Not Assigned"]){
            
            gisresponse_ID_String=@"2";
        }else if([gis_response_data isEqualToString:@"Need More Information"]){
            
            gisresponse_ID_String=@"3";
        }
        
        GISSchedulerSPJobsObject *spJobsObj = [SPJobsArray objectAtIndex:btn_tag];
        spJobsObj.GisResponse_String = gis_response_data;
        spJobsObj.GisResponse_id_String = gisresponse_ID_String;
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:btn_tag inSection:0];
        
        NSArray *reloadArray = [[NSArray alloc] initWithObjects:path, nil];
        
        [listTableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
    }
    
    if(_popover)
        [_popover dismissPopoverAnimated:YES];

    
}

- (IBAction)saveSPData:(id)sender{
    
    GISSchedulerSPJobsObject *spJobsObj = [SPJobsArray objectAtIndex:btn_tag];
    
    UIButton *btn=(UIButton*)sender;
    
    btn_tag = btn.tag;
    
    NSMutableString *alertString = [[NSMutableString alloc] init];
    [alertString setString:@""];
    
    if([spJobsObj.GisResponse_id_String length] == 0 || [spJobsObj.PayType_id_String length] == 0){
        
        if([spJobsObj.GisResponse_id_String length] == 0){
            [alertString appendFormat:@"%@ %@",@"GIS Response",@"\n"];
        }
        
        if([spJobsObj.PayType_id_String length] == 0){
            
            [alertString appendFormat:@"%@",@"PayType"];
        }
        
        [GISUtility showAlertWithTitle:@"" andMessage:[NSString stringWithFormat:NSLocalizedStringFromTable(@"enter_valid_details",TABLE, nil),alertString]];
        
        return;
    }
    
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    GISLoginDetailsObject *login_Obj=[requetId_array lastObject];
    
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    [paramsDict setObject:login_Obj.token_string forKey:@"token"];
    [paramsDict setObject:login_Obj.requestorID_string forKey:@"RequestorID"];
    [paramsDict setObject:spJobsObj.SPRequestJobID_String forKey:@"SPRequestJobID"];
    [paramsDict setObject:spJobsObj.JobID_String forKey:@"JobID"];
    [paramsDict setObject:spJobsObj.GisResponse_id_String forKey:@"GISResponse"];
    [paramsDict setObject:spJobsObj.PayType_id_String forKey:@"PayTypeID"];


    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"GISResponse", TABLE, nil)];
    [[GISServerManager sharedManager] saveSPRequestData:self withParams:paramsDict finishAction:@selector(successmethod_SaveSPRequests:) failAction:@selector(failuremethod_SaveSPRequests:)];

//    pay_type_data= value_str;
//    UIButton *payTypeBtn=(UIButton *)[self.view viewWithTag:btn_tag];
//    [payTypeBtn setTitle:pay_type_data forState:UIControlStateNormal];
//    pay_type_ID_String=id_str;
    
}

-(void)successmethod_SaveSPRequests:(GISJsonRequest *)response
{

    NSLog(@"successmethod_SaveSPRequests Success---%@",response.responseJson);
    @try {
        if ([response.responseJson isKindOfClass:[NSArray class]])
        {
            
            id array=response.responseJson;
            NSDictionary *dictHere=[array lastObject];
            
            if ([[dictHere objectForKey:kStatusCode] doubleValue] == 200) {
                
                [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"successfully_saved", TABLE, nil)];
                
                [self removeLoadingView];
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
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in successmethod_SaveSPRequests action %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
}
-(void)failuremethod_SaveSPRequests:(GISJsonRequest *)response
{
    NSLog(@"Failure");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
