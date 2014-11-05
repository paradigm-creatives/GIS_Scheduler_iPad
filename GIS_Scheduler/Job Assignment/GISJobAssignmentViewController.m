//
//  GISJobAssignmentViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 22/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISJobAssignmentViewController.h"
#import "GISJobAssignmentCell.h"
#import "GISConstants.h"
#import "GISDatabaseManager.h"
#import "GISUtility.h"
#import "GISFilterMoreViewController.h"
#import "GISServiceProviderPopUpViewController.h"
#import "GISJsonRequest.h"
#import "GISStoreManager.h"
#import "GISServerManager.h"
#import "GISJSONProperties.h"
#import "GISConstants.h"
#import "GISFonts.h"
#import "GISLoadingView.h"
#import "GISSchedulerSPJobsObject.h"
#import "GISSchedulerSPJobsStore.h"



@interface GISJobAssignmentViewController ()

@end

@implementation GISJobAssignmentViewController

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
    
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    login_Obj=[requetId_array lastObject];
    
    selected_row=999999;
    ota_dictionary=[[NSMutableDictionary alloc]init];
    chooseRequest_mutArray=[[NSMutableArray alloc]init];
    
    NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_CHOOSE_REQUEST ORDER BY ID DESC;"];
    chooseRequest_mutArray = [[[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement] mutableCopy];
    
//    //self.navigationItem.hidesBackButton = YES;
    dashBoard_UIView.hidden=YES;
//    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
//    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
//    [rightRecognizer setNumberOfTouchesRequired:1];
//    
//    //add the your gestureRecognizer , where to detect the touch..
//    [self.view addGestureRecognizer:rightRecognizer];
//    
//    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
//    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
//    [leftRecognizer setNumberOfTouchesRequired:1];
//    
//    [self.view addGestureRecognizer:leftRecognizer];
    
    self.title=NSLocalizedStringFromTable(@"Jobs_Assignment", TABLE, nil);
    CGRect frame1=table_UIView.frame;
    frame1.origin.x=0;
    table_UIView.frame=frame1;
    
    serviceProvider_Array=[[NSMutableArray alloc]init];
    serviceProviderType_array=[[NSMutableArray alloc]init];
    payType_array=[[NSMutableArray alloc]init];
    NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO"];
    serviceProvider_Array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
    NSString *typeOfService_statement = [[NSString alloc]initWithFormat:@"select * from TBL_TYPE_OF_SERVICE  ORDER BY ID DESC;"];
    serviceProviderType_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:typeOfService_statement] mutableCopy];
    NSString *payType_statement = [[NSString alloc]initWithFormat:@"select * from TBL_PAY_TYPE"];
    payType_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:payType_statement] mutableCopy];
    
    
    mainArray=[[NSMutableArray alloc]init];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.view_string isEqualToString:kFindRequestJobs_Screen]) {
        segment_UIView.hidden=YES;
        CGRect new_frame=table_UIView.frame;
        new_frame.origin.y=90;
        table_UIView.frame=new_frame;
        self.title=NSLocalizedStringFromTable(@"Find_Requests_Jobs", TABLE, nil);
    }
    NSLog(@"----Array is -->%@--count-->%d",[self.requested_Jobs_Array description],self.requested_Jobs_Array.count);
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonPressed)];
//    
//    self.navigationItem.hidesBackButton = YES;
//    self.navigationItem.leftBarButtonItem = item;
}

-(void)backButtonPressed
{
    if (table_UIView.frame.origin.x==0) {
        [self performSelector:@selector(hideAndUnHideMaster:) withObject:nil];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)splitViewController: (UISplitViewController*)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return self.isMasterHide;
}

- (IBAction)hideAndUnHideMaster:(id)sender
{
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    UIButton *btn = (UIButton*)sender;
    GISAppDelegate *appDelegate1 = (GISAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.isMasterHide= !self.isMasterHide;
    NSString *buttonTitle = self.isMasterHide ? @""  : @"  "; //@""== Unhide   @"  "==Hide
    if ([buttonTitle isEqualToString:@""])
    {
        dashBoard_UIView.hidden=NO;
        CGRect frame1=table_UIView.frame;
        frame1.origin.x=75;
        table_UIView.frame=frame1;
    }
    else
    {
        dashBoard_UIView.hidden=YES;
        CGRect frame1=table_UIView.frame;
        frame1.origin.x=0;
        table_UIView.frame=frame1;
    }
    
    [btn setTitle:buttonTitle forState:UIControlStateNormal];
    [appDelegate1.spiltViewController.view setNeedsLayout ];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.requested_Jobs_Array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISJobAssignmentCell *cell=(GISJobAssignmentCell *)[tableView dequeueReusableCellWithIdentifier:@"AssignmentCell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISJobAssignmentCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    cell.service_Provider_type_button.tag=indexPath.row;
//    cell.service_Provider_button.tag=indexPath.row;
//    cell.payType_button.tag=indexPath.row;
    GISSchedulerSPJobsObject *obj=[self.requested_Jobs_Array objectAtIndex:indexPath.row];
    cell.oTA_button.tag=indexPath.row;
    cell.edit_button.tag=indexPath.row;
    [cell.oTA_button addTarget:self action:@selector(OTA_Button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.edit_button addTarget:self action:@selector(editButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.jobId_label.text=obj.JobNumber_String;
    cell.jobDate_label.text=obj.JobDate_String;
    cell.startTime_label.text=obj.startTime_String;
    cell.endTime_label.text=obj.endTime_String;
    cell.serviceProviderType_label.text=obj.typeOfService_string;
    cell.serviceProvider_label.text=obj.ServiceProviderName_String;
    cell.payType_label.text=obj.PayType_String;
    cell.location_label.text=obj.location_string;
    cell.account_label.text=obj.accountName_string;
    cell.requestor_label.text=obj.requestorName_string;
    
    if ([ota_dictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
        [cell.oTA_imageView setImage:[UIImage imageNamed:@"checked.png"]];
    else
        [cell.oTA_imageView setImage:[UIImage imageNamed:@"unchecked.png"]];
    
    
    if (selected_row==indexPath.row && isEdit_Button_Clicked) {
        cell.serviceProviderType_label.text=typeOfservice_temp_string;
        cell.payType_label.text=payType_temp_string;
        [cell.edit_button setImage:[UIImage imageNamed:@"check_pressed"] forState:UIControlStateNormal];
    }
    else
    {
        //check.png
        [cell.edit_button setImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
    }
    
    return cell;
}

-(void)OTA_Button_pressed:(id)sender
{
    if ([ota_dictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]]) {
        [ota_dictionary removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
    }
    else
    {
        [ota_dictionary setObject:[NSString stringWithFormat:@"%ld",(long)[sender tag]] forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
    }
    [jobAssignment_tableView reloadData];

}

-(IBAction)pickerButton_pressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    GISPopOverTableViewController *tableViewController1 = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController1.popOverDelegate=self;
    
    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController1];
    popover.delegate = self;
    popover.popoverContentSize = CGSizeMake(340, 150);
    if([sender tag]==111 || [sender tag]==222 || [sender tag]==333 || [sender tag]==444)
    {
        if([sender tag]==111)
        {
            btnTag=111;
            tableViewController1.view_String=[GISUtility returningstring:chooseRequest_ID_answer_Label.text];
            tableViewController1.popOverArray=chooseRequest_mutArray;
        }
        else if([sender tag]==222)
        {
            btnTag=222;
            tableViewController1.view_String=@"datestimes";
            tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:from_answer_Label.text];
        }
        else if ([sender tag]==333)
        {
            btnTag=333;
            tableViewController1.view_String=@"datestimes";
            tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:to_answer_Label.text];
            
        }
        else if ([sender tag]==444)
        {
            btnTag=444;
            //tableViewController1.view_String=[GISUtility returningstring:typeOfService_answer_Label.text];
            tableViewController1.popOverArray=serviceProviderType_array;
            
        }
        else if ([sender tag]==555)
        {
            btnTag=555;
            tableViewController1.popOverArray=serviceProvider_Array;
            
        }
        else if ([sender tag]==666)
        {
            btnTag=666;
            tableViewController1.popOverArray=payType_array;
            
        }
        //NSLog(@"-----x-->%@",NSStringFromCGRect(button.frame));
        if ([sender tag]==111)
            [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+button.frame.size.width+45, 148, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        else
            [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+button.frame.size.width+45, 185, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    else
    {
        if ([sender tag]==555)
        {
            btnTag=555;
            //tableViewController1.view_String=[GISUtility returningstring:typeOfService_answer_Label.text];
            tableViewController1.popOverArray=serviceProviderType_array;
            
        }
        else if ([sender tag]==777)
        {
            btnTag=777;
            tableViewController1.popOverArray=payType_array;
            
        }
        popover.popoverContentSize = CGSizeMake(340, 250);
        GISJobAssignmentCell *tempCell_JobAssignment=(GISJobAssignmentCell *)button.superview.superview.superview.superview.superview;
        
        if ([sender tag]==555)
         [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+button.frame.size.width+310, button.frame.origin.x+button.frame.size.width-57, 1, 1) inView:tempCell_JobAssignment.contentView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        else
            [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+button.frame.size.width+530, button.frame.origin.x+button.frame.size.width-57, 1, 1) inView:tempCell_JobAssignment.contentView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    [self performSelector:@selector(dismissPopOverNow) withObject:nil afterDelay:0.0];
    if (btnTag==111)
    {
        chooseRequest_ID_answer_Label.text=value_str;
        chooseRequestID_str = id_str;
        
    }
    else if (btnTag==222)
    {
        from_answer_Label.text=value_str;
        startDate_str = value_str;
        if ([from_answer_Label.text length] && [to_answer_Label.text length]){
            if ([GISUtility dateComparision:from_answer_Label.text :to_answer_Label.text:YES])
            {
            }
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"start Date alert", TABLE, nil)];
                from_answer_Label.text=@"";
            }
        }
    }
    else if (btnTag==333)
    {
        to_answer_Label.text=value_str;
        endDate_str = value_str;
        if ([from_answer_Label.text length] && [to_answer_Label.text length]){
            if ([GISUtility dateComparision:from_answer_Label.text :to_answer_Label.text:NO])
            {}
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"end Date alert", TABLE, nil)];
                to_answer_Label.text=@"";
            }
        }
    }
    else  if (btnTag==444)
    {
        typeOfService_answer_Label.text=value_str;
        typeServiceID_str = id_str;
    }
    else  if (btnTag==555)
    {
        typeOfservice_temp_string=value_str;
    }
    else  if (btnTag==777)
    {
        payType_temp_string=value_str;
    }
    if (btnTag==555||btnTag==777)
        [jobAssignment_tableView reloadData];
}

-(void)dismissPopOverNow
{
    [popover dismissPopoverAnimated:YES];
}

-(IBAction)filterMore_ButtonPressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    
    GISFilterMoreViewController *tableViewController = [[GISFilterMoreViewController alloc] initWithNibName:@"GISFilterMoreViewController" bundle:nil];
    //tableViewController.popOverDelegate=self;
    //popover.popoverContentSize = CGSizeMake(433, 504);
    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController];
    popover.popoverContentSize = CGSizeMake(433, 504);
    [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+68, button.frame.origin.y+88, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];

}


-(IBAction)searchButton_Pressed:(id)sender
{
    /*
    if (![chooseRequestID_str length]) {
        [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_choose_request", TABLE, nil)]; return;
        return;
    }
    */
    if([startDate_str length] == 0  )
    {
        startDate_str = @"";
    }
    if( [endDate_str length] == 0 )
    {
        endDate_str = @"";
    }
    if([typeServiceID_str length] == 0)
    {
        typeServiceID_str = @"";
    }
    if([chooseRequestID_str length] == 0)
    {
        chooseRequestID_str = @"";
    }
    
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    [paramsDict setObject:startDate_str forKey:kJobAssignmentStartDate];
    [paramsDict setObject:endDate_str forKey:kJobAssignmentEndDate];
    [paramsDict setObject:typeServiceID_str forKey:kJobAssignmentSPSubRole];
    [paramsDict setObject:chooseRequestID_str forKey:kRequestID];
    [paramsDict setObject:login_Obj.requestorID_string forKey:kLoginRequestorID];
    [paramsDict setObject:login_Obj.token_string forKey:keventDetails_token];
    
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    
    [[GISServerManager sharedManager] jobAssignmentJobs:self withParams:paramsDict finishAction:@selector(successmethod_jobAssignmentRequest:) failAction:@selector(failuremethod_jobAssignmentRequest:)];
    
}

/*
 
    Service Provider if Empty i.e., We are getting like this ServiceProvider = "" -----> Unfilled
    Service Provider if Not Empty ---> filled
 
 */

-(void)successmethod_jobAssignmentRequest:(GISJsonRequest *)response
{
    
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    NSLog(@"successmethod_jobAssignmentRequest Success---%@",saveUpdateDict);
    
    [[GISStoreManager sharedManager] removeRequestJobs_SPJobsObject];
    GISSchedulerSPJobsStore *spJobsStore;
    spJobsStore=[[GISSchedulerSPJobsStore alloc]initWithJsonDictionary:response.responseJson];
    self.requested_Jobs_Array=[[GISStoreManager sharedManager] getRequestJobs_SPJobsObject];
    [mainArray addObjectsFromArray:self.requested_Jobs_Array];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"filledOrUnfilled_string=%@",@"filled"];
    NSArray *array=[self.requested_Jobs_Array filteredArrayUsingPredicate:predicate];
    self.requested_Jobs_Array=[array mutableCopy];
    
    [jobAssignment_tableView reloadData];
    [self removeLoadingView];
    
}

-(void)failuremethod_jobAssignmentRequest:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
}


-(IBAction)segment_filled_Unfilled_ValueChanged:(id)sender
{
    UISegmentedControl *segment=(UISegmentedControl *)sender;
    if (segment.selectedSegmentIndex==0) {
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"filledOrUnfilled_string=%@",@"filled"];
        NSArray *array=[mainArray filteredArrayUsingPredicate:predicate];
        [self.requested_Jobs_Array removeAllObjects];
        self.requested_Jobs_Array=[array mutableCopy];
    }
    else if (segment.selectedSegmentIndex==1) {
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"filledOrUnfilled_string=%@",@"unfilled"];
        NSArray *array=[mainArray filteredArrayUsingPredicate:predicate];
        [self.requested_Jobs_Array removeAllObjects];
        self.requested_Jobs_Array=[array mutableCopy];
    }
    [jobAssignment_tableView reloadData];
    if ((self.requested_Jobs_Array.count<1)) {
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"no_data",TABLE, nil)];
    }
}

-(IBAction)listOfServiceProviders_ButtonPressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    id tempCellRef=(GISJobAssignmentCell *)button.superview.superview.superview.superview.superview;
    GISJobAssignmentCell *attendeesCell=(GISJobAssignmentCell *)tempCellRef;
    
    GISServiceProviderPopUpViewController *popOverController=[[GISServiceProviderPopUpViewController alloc]initWithNibName:@"GISServiceProviderPopUpViewController" bundle:nil];
    
    NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO WHERE TYPE = '%@'",[GISUtility returningstring:typeOfservice_temp_string]];
    serviceProvider_Array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
    popOverController.popOverArray=serviceProvider_Array;

    popover=[[UIPopoverController alloc]initWithContentViewController:popOverController];
    popover.popoverContentSize = CGSizeMake(340, 357);
    [popover presentPopoverFromRect:CGRectMake(attendeesCell.service_Provider_button.frame.origin.x+480, attendeesCell.service_Provider_button.frame.origin.y+35, 1, 1) inView:attendeesCell.contentView permittedArrowDirections:(UIPopoverArrowDirectionAny) animated:YES];
}


-(void)editButtonPressed:(id)sender
{
    NSLog(@"tag--%d",[sender tag]);
    if(!isEdit_Button_Clicked)
    {
        isEdit_Button_Clicked=YES;
        selected_row=[sender tag];
        GISSchedulerSPJobsObject *obj=[self.requested_Jobs_Array objectAtIndex:selected_row];

        typeOfservice_temp_string=obj.typeOfService_string;
        serviceProvider_temp_string=obj.ServiceProviderName_String;
        payType_temp_string=obj.PayType_String;
    }
    else if(isEdit_Button_Clicked){
        
         GISSchedulerSPJobsObject *obj=[self.requested_Jobs_Array objectAtIndex:selected_row];

         obj.typeOfService_string=typeOfservice_temp_string;
         obj.ServiceProviderName_String=serviceProvider_temp_string;
         obj.PayType_String=payType_temp_string;
         [self.requested_Jobs_Array replaceObjectAtIndex:selected_row withObject:obj];
         //Call the Save Update JObs Service here
        
        NSString *typeOfService_ID_temp_String=@"";
        NSString *serviceProvider_ID_temp_String=@"";
        NSString *payType_ID_temp_String=@"";
        
        NSPredicate *predicate_typeOfService=[NSPredicate predicateWithFormat:@"value_String=%@",obj.typeOfService_string];
        NSArray *array_typeOfService=[serviceProviderType_array filteredArrayUsingPredicate:predicate_typeOfService];
        if (array_typeOfService.count>0) {
            GISDropDownsObject *obj=[array_typeOfService lastObject];
            typeOfService_ID_temp_String=obj.id_String;
        }
        
        NSPredicate *predicate_serviceProvider=[NSPredicate predicateWithFormat:@"service_Provider_String=%@",obj.ServiceProviderName_String];
        NSArray *array_serviceProvider=[serviceProvider_Array filteredArrayUsingPredicate:predicate_serviceProvider];
        if (array_serviceProvider.count>0) {
            GISServiceProviderObject *obj=[array_serviceProvider lastObject];
            serviceProvider_ID_temp_String=obj.id_String;
        }
        
        NSPredicate *predicate_payType=[NSPredicate predicateWithFormat:@"value_String=%@",obj.PayType_String];
        NSArray *array_payType=[payType_array filteredArrayUsingPredicate:predicate_payType];
        if (array_payType.count>0) {
            GISDropDownsObject *obj=[array_payType lastObject];
            payType_ID_temp_String=obj.id_String;
        }
        
        NSMutableDictionary *update_eventdict;
        update_eventdict=[[NSMutableDictionary alloc]init];
        
        [update_eventdict setObject:obj.JobID_String forKey:kJobDetais_JobID];
        [update_eventdict setObject:obj.startTime_String forKey:kJobDetais_StartTime];
        [update_eventdict setObject:obj.endTime_String forKey:kJobDetais_EndTime];
        [update_eventdict setObject:obj.JobDate_String forKey:kJobDetais_JobDate];
        [update_eventdict setObject:payType_ID_temp_String forKey:kViewSchedule_PayTypeID];
        [update_eventdict setObject:serviceProvider_ID_temp_String forKey:kViewSchedule_ServiceProviderID];
        [update_eventdict setObject:typeOfService_ID_temp_String forKey:kViewSchedule_SubroleID];
        [update_eventdict setObject:login_Obj.requestorID_string forKey:kLoginRequestorID];
        [update_eventdict setObject:@"" forKey:kViewSchedule_JobNotes];
        
        [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
        [[GISServerManager sharedManager] updateJobDetails:self withParams:update_eventdict finishAction:@selector(successmethod_updateJobDetails_data:) failAction:@selector(failuremethod_updateJobDetails_data:)];
        
        
        selected_row=999999;
        isEdit_Button_Clicked=NO;
    }
    [jobAssignment_tableView reloadData];
}


-(void)successmethod_updateJobDetails_data:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"successmethod_updateScheduledata Success---%@",response.responseJson);
    NSArray *array=response.responseJson;
    NSDictionary *dictNew=[array lastObject];
    NSString *success= [NSString stringWithFormat:@"%@",[dictNew objectForKey:kStatusCode]];
    
    if ([success isEqualToString:@"200"]) {
        [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"updated_successfully", TABLE, nil)];
    }
    else{
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
    }
    
}
-(void)failuremethod_updateJobDetails_data:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
}

-(void)addLoadViewWithLoadingText:(NSString*)title
{
    [[GISLoadingView sharedDataManager] addLoadingAlertView:title];
}
-(void)removeLoadingView
{
    [[GISLoadingView sharedDataManager] removeLoadingAlertview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
