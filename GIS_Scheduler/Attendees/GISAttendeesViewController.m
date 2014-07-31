//
//  GISAttendeesViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISAttendeesViewController.h"
#import "GISAttendeesTopCell.h"
#import "GISConstants.h"
#import "GISFonts.h"
#import "GISAttendees_ListObject.h"
#import "GISUtility.h"
#import "GISDatabaseManager.h"
#import "GISJSONProperties.h"
#import "GISLoadingView.h"
#import "GISServerManager.h"
#import "GISJsonRequest.h"
#import "GISStoreManager.h"
#import "PCLogger.h"
#import "GISAttendeesDetailsStore.h"

@interface GISAttendeesViewController ()

@end

int row_count = 2;

@implementation GISAttendeesViewController

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
	// Do any additional setup after loading the view.
    
    attendeesObject=[[GISAttendeesObject alloc]init];
    attendeesObject.attendeesList_mutArray=[[NSMutableArray alloc]init];
    
    btnTag=0;
    
    preference_mutArray=[[NSMutableArray alloc]init];
    modeofcommunication_mutArray=[[NSMutableArray alloc]init];
    servicesNeeded_mutArray=[[NSMutableArray alloc]init];
    primaryAudience_mutArray=[[NSMutableArray alloc]init];
    
    expectedNo_mutArray=[[NSMutableArray alloc]initWithObjects:@"2-5",@"6-15",@"16-50", @"50+" , nil];
    expectedNo_ID_mutArray=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3", @"4" , nil];
    genderPreference_mutArray=[[NSMutableArray alloc]initWithObjects:@"No Preference",@"Male",@"Female", nil];
    genderPreference_ID_Array=[[NSMutableArray alloc]initWithObjects:@"0",@"M",@"F", nil];
    
    directly_utilizedServices_mutArray=[[NSMutableArray alloc]initWithObjects:@"Yes",@"No",@"Unknown", nil];
    
    
    NSString *preference_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROV_GENDER_PREFERENCE;"];
    preference_mutArray = [[[GISDatabaseManager sharedDataManager] getDropDownArray:preference_statement] mutableCopy];
    
    NSString *modeofcommunication_statement = [[NSString alloc]initWithFormat:@"select * from TBL_MODE_OF_COMMUNICATION;"];
    modeofcommunication_mutArray = [[[GISDatabaseManager sharedDataManager] getDropDownArray:modeofcommunication_statement] mutableCopy];
    
    NSString *servicesNeeded_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_NEEDED;"];
    servicesNeeded_mutArray = [[[GISDatabaseManager sharedDataManager] getDropDownArray:servicesNeeded_statement] mutableCopy];
    
    NSString *primaryAudience_statement = [[NSString alloc]initWithFormat:@"select * from TBL_PRIMARY_AUDIENCE;"];
    primaryAudience_mutArray = [[[GISDatabaseManager sharedDataManager] getDropDownArray:primaryAudience_statement] mutableCopy];
    
    NSString *loginStr = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *login_array = [[GISDatabaseManager sharedDataManager] geLoginArray:loginStr];
    login_Obj=[login_array lastObject];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    viewEditSchedule_obj=[[GISVIewEditRequestViewController alloc]init];
    viewEditSchedule_obj.chooseReq_protocol=self;
    for (int i=0; i<row_count; i++) {
        attendees_ListObject=[[GISAttendees_ListObject alloc]init];
        [attendeesObject.attendeesList_mutArray addObject:[self addEmptyData:attendees_ListObject]];
    }
    [self.attendees_tableView reloadData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedChooseRequestNumber:) name:kselectedChooseReqNumber object:nil];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else if (section==1) {
        return row_count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        GISAttendeesTopCell *topcell=(GISAttendeesTopCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return topcell.frame.size.height;
    }
    
    return 158;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 2)
        return 100;
    return 0;
}


-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* headerView;
    if (section == 2)
    {
        headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
        UIButton *addButton = [[UIButton alloc] init];
        addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [addButton addTarget:self
                      action:@selector(createAttendee:)
            forControlEvents:UIControlEventTouchUpInside];
        addButton.frame = CGRectMake(headerView.frame.size.width/2-50, 10.0, 20.0, 20.0);
        [headerView addSubview:addButton];
        
        UILabel* headerLabel = [[UILabel alloc] init];
        headerLabel.frame = CGRectMake(headerView.frame.size.width/2-20, addButton.frame.size.height/2+5, 80, 10);
        headerLabel.textColor = UIColorFromRGB(0x00457c);
        headerLabel.font = [UIFont boldSystemFontOfSize:12];
        headerLabel.text=NSLocalizedStringFromTable(@"add attendee", TABLE, nil);
        [headerLabel setTextAlignment:NSTextAlignmentCenter];
        [headerView addSubview:headerLabel];
        
        UIButton *nextButton = [[UIButton alloc] init];
        nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [nextButton addTarget:self
                       action:@selector(nextButtonPressed:)
             forControlEvents:UIControlEventTouchUpInside];
        nextButton.frame = CGRectMake(headerView.frame.size.width/2-35, 40.0, 80.0, 30.0);
        
        [nextButton setTitle:NSLocalizedStringFromTable(@"next",TABLE, nil) forState:UIControlStateNormal];
        nextButton.backgroundColor=UIColorFromRGB(0x00457c);
        [nextButton setTitleColor:UIColorFromRGB(0xe8d4a2) forState:UIControlStateNormal];
        nextButton.titleLabel.font=[GISFonts larger];
        [nextButton.layer setCornerRadius:3.0f];
        [[nextButton layer] setMasksToBounds:YES];
        [headerView addSubview:nextButton];
        
    }
    else
    {
        headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    }
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        GISAttendeesTopCell *cell=(GISAttendeesTopCell *)[tableView dequeueReusableCellWithIdentifier:@"AttendeesCell"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISAttendeesCell" owner:self options:nil] objectAtIndex:0];
        }
        cell.attendee_count_Label.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        cell.email_textField.delegate=self;
        cell.firstname_textField.delegate=self;
        cell.lastname_textField.delegate=self;
        
        @try {
            GISAttendees_ListObject *attendee_ListObj_here ;
            @try {
                attendee_ListObj_here = [attendeesObject.attendeesList_mutArray objectAtIndex:indexPath.row];
            }
            @catch (NSException *exception) {
                [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in Attendeees CellForRowAtIndexPath %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
            }
            
            
            cell.email_textField.text=attendee_ListObj_here.email_String;
            cell.firstname_textField.text=attendee_ListObj_here.firstname_String;
            cell.lastname_textField.text=attendee_ListObj_here.lastname_String;
            cell.modeOf_answer_Label.text=attendee_ListObj_here.modeOf_String;
            cell.directly_utilized_services_answer_Label.text=attendee_ListObj_here.directly_utilzed_String;
            cell.servicesNeeded_answer_Label.text=attendee_ListObj_here.servicesNeeded_String;
            
            
            cell.cellSectionNumber = indexPath.section;
            cell.cellRowNumber = indexPath.row;
            cell.cellIndexpath = indexPath;
            cell.attendees_delegate=self;
            
            
            cell.attendee_Label.textColor=UIColorFromRGB(0x000000);
            cell.attendee_Label.font=[GISFonts large];
            cell.firstname_Label.font=[GISFonts normal];
            cell.firstname_textField.font=[GISFonts small];
            cell.lastname_Label.font=[GISFonts normal];
            cell.lastname_textField.font=[GISFonts small];
            cell.email_Label.font=[GISFonts normal];
            cell.email_textField.font=[GISFonts small];
            
            cell.modeOf_Label_2.font=[GISFonts normal];
            cell.modeOf_Label.font=[GISFonts normal];
            cell.modeOf_answer_Label.font=[GISFonts small];
            cell.directly_utilized_services_Label_2.font=[GISFonts normal];
            cell.directly_utilized_services_Label.font=[GISFonts normal];
            cell.directly_utilized_services_answer_Label.font=[GISFonts small];
            
            cell.servicesNeeded_Label.font=[GISFonts normal];
            cell.servicesNeeded_answer_Label.font=[GISFonts small];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        @catch (NSException *exception) {
            [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in Attendeees CellFor  action %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
        }
        return cell;
    }
    
    GISAttendeesTopCell *cell=(GISAttendeesTopCell *)[tableView dequeueReusableCellWithIdentifier:@"AttendeesCell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISAttendeesTopCell" owner:self options:nil] objectAtIndex:0];
    }
    if ([attendeesObject.primaryAudience_String length])
        cell.primaryAudience_answer_Label.text=attendeesObject.primaryAudience_String;
    else
        cell.primaryAudience_answer_Label.text=@"";
    
    if ([attendeesObject.expectedNo_String length])
        cell.expectedNo_answer_Label.text=attendeesObject.expectedNo_String;
    else
        cell.expectedNo_answer_Label.text=@"";
    
    if ([attendeesObject.genderPreference_String length])
        cell.genderPreference_answer_Label.text=attendeesObject.genderPreference_String;
    else
        cell.genderPreference_answer_Label.text=@"";
    
    if ([attendeesObject.preference_String length])
        cell.preference_answer_Label.text=attendeesObject.preference_String;
    else
        cell.preference_answer_Label.text=@"";
    
    return cell;
}


- (IBAction)createAttendee:(id)sender{
    
    row_count++;
    GISAttendees_ListObject *attendees_ListObject1=[[GISAttendees_ListObject alloc]init];
    [attendeesObject.attendeesList_mutArray addObject:[self addEmptyData:attendees_ListObject1]];
    [self.attendees_tableView reloadData];
}

-(GISAttendees_ListObject *)addEmptyData :(GISAttendees_ListObject *)listObj
{
    listObj.email_String=@"";
    listObj.firstname_String=@"";
    listObj.lastname_String=@"";
    listObj.modeOf_String=@"";
    listObj.directly_utilzed_String=@"";
    listObj.servicesNeeded_String=@"";
    return listObj;
}


-(IBAction)pickerButtonPressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    
    GISPopOverTableViewController *tableViewController = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController.popOverDelegate=self;
    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController];
    
    popover.delegate = self;
    popover.popoverContentSize = CGSizeMake(340, 150);
    
    if([sender tag]==111)
    {
        btnTag=111;
        
        tableViewController.popOverArray=expectedNo_mutArray;
    }
    else if ([sender tag]==222)
    {
        btnTag=222;
        tableViewController.popOverArray=genderPreference_mutArray;
    }
    else if ([sender tag]==333)
    {
        btnTag=333;
        tableViewController.popOverArray=preference_mutArray;
        
    }
    else if ([sender tag]==444)
    {
        btnTag=444;
        tableViewController.popOverArray=primaryAudience_mutArray;
        
    }
    else if ([sender tag]==555)
    {
        btnTag=555;
        tableViewController.popOverArray=modeofcommunication_mutArray;
    }
    else if ([sender tag]==666)
    {
        btnTag=666;
        tableViewController.popOverArray=directly_utilizedServices_mutArray;
    }
    else if ([sender tag]==777)
    {
        btnTag=777;
        tableViewController.popOverArray=servicesNeeded_mutArray;
    }

    [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+135, button.frame.origin.y+20, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
        [popover dismissPopoverAnimated:YES];
        GISAttendees_ListObject *attendees_ListObject_here = [attendeesObject.attendeesList_mutArray objectAtIndex:attendeesCell.cellRowNumber];
        if (btnTag==111) {
            attendeesObject.expectedNo_String=value_str;
            attendeesObject.expectedNo_ID_String=[expectedNo_ID_mutArray objectAtIndex:[self getExpectedNoRowCount:value_str]];
            
            int countHere=[self getExpectedStr_value_before_hypen:attendeesObject.expectedNo_String];
            
            //Duplicates Removing delete duplicates (this is the best code)
            NSMutableArray *discardedItems = [[NSMutableArray alloc]init];
            if(countHere<[attendeesObject.attendeesList_mutArray count]){
                int incrementCount=[attendeesObject.attendeesList_mutArray count];
                for (int i=countHere; i<incrementCount;i++){
                    GISAttendees_ListObject *listObj=[attendeesObject.attendeesList_mutArray objectAtIndex:countHere];
                    [discardedItems addObject:listObj];
                    [attendeesObject.attendeesList_mutArray removeObjectsInArray:discardedItems];
                }
            }
            
            if(![attendeesObject.attendeesList_mutArray count]<countHere){
                for (int i=row_count; i<countHere;i++){
                    GISAttendees_ListObject *attendees_ListObject1=[[GISAttendees_ListObject alloc]init];
                    [attendeesObject.attendeesList_mutArray addObject:[self addEmptyData:attendees_ListObject1]];
                }
                countHere=[attendeesObject.attendeesList_mutArray count];
            }
            
            row_count=[attendeesObject.attendeesList_mutArray count];
        }
        else if (btnTag==222)
        {
            attendeesObject.genderPreference_String=value_str;
            attendeesObject.genderPreference_ID_String=[genderPreference_ID_Array objectAtIndex:[self getGenderRowCount:value_str]];
        }
        else if (btnTag==333)
        {
            attendeesObject.preference_String=value_str;
            attendeesObject.preference_ID_String=id_str;
        }
        else if (btnTag==444)
        {
            attendeesObject.primaryAudience_String=value_str;
            attendeesObject.primaryAudience_ID_String=id_str;
        }
        else if (btnTag==555)
        {
            attendees_ListObject_here.modeOf_String=value_str;
            attendees_ListObject_here.modeOfCommuniation_ID_String=id_str;
            [attendeesObject.attendeesList_mutArray replaceObjectAtIndex:attendeesCell.cellRowNumber withObject:attendees_ListObject_here];
        }
        else if (btnTag==666)
        {
            attendees_ListObject_here.directly_utilzed_String=value_str;
            [attendeesObject.attendeesList_mutArray replaceObjectAtIndex:attendeesCell.cellRowNumber withObject:attendees_ListObject_here];
        }
        else if (btnTag==777)
        {
            attendees_ListObject_here.servicesNeeded_String=value_str;
            attendees_ListObject_here.serviceNedded_ID_String=id_str;
            [attendeesObject.attendeesList_mutArray replaceObjectAtIndex:attendeesCell.cellRowNumber withObject:attendees_ListObject_here];
        }
        [self.attendees_tableView reloadData];
        
}


-(int)getExpectedStr_value_before_hypen:(NSString *)idSTr
{
    NSArray *array=[idSTr componentsSeparatedByString:@"-"];
    if ([idSTr isEqualToString:@"4"]) {
        array=[attendeesObject.expectedNo_String componentsSeparatedByString:@"+"];
    }
    
    return [[array objectAtIndex:0] intValue];
}

-(int)getExpectedNoRowCount:(NSString *)valueStr
{
    int rowValue;
    for (int i=0; i<expectedNo_mutArray.count; i++) {
        NSString *findValue_str=[expectedNo_mutArray objectAtIndex:i];
        if([findValue_str isEqualToString:valueStr])
            rowValue=i;
    }
    return rowValue;
}


-(int)getGenderRowCount:(NSString *)valueStr
{
    int rowValue;
    for (int i=0; i<genderPreference_mutArray.count; i++) {
        NSString *findValue_str=[genderPreference_mutArray objectAtIndex:i];
        if([findValue_str isEqualToString:valueStr])
            rowValue=i;
    }
    return rowValue;
    
}

-(void)selectedChooseRequestNumber:(NSNotification*)notification
{
    NSDictionary *dict=[notification userInfo];
    [[NSNotificationCenter defaultCenter]removeObserver:kselectedChooseReqNumber];
    attendeesObject.choose_request_String=[dict valueForKey:@"value"];
    attendeesObject.choose_request_ID_String=[dict valueForKey:@"id"];
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    [paramsDict setObject:attendeesObject.choose_request_ID_String forKey:kID];
    [paramsDict setObject:login_Obj.token_string forKey:kToken];
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    [[GISServerManager sharedManager] getChooseRequestDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_getChooseRequestDetails:) failAction:@selector(failuremethod_getChooseRequestDetails:)];
}

-(void)successmethod_getChooseRequestDetails:(GISJsonRequest *)response
{
    //[self removeLoadingView];
    NSLog(@"successmethod_getRequestDetails Success---%@",response.responseJson);
    [[GISStoreManager sharedManager]removeChooseRequestDetailsObjects];
    chooseRequestDetailsObj=[[GISChooseRequestDetailsObject alloc]initWithStoreChooseRequestDetailsDictionary:response.responseJson];
    [[GISStoreManager sharedManager]addChooseRequestDetailsObject:chooseRequestDetailsObj];
    
    appDelegate.createdDateString = chooseRequestDetailsObj.createdDate_String_chooseReqParsedDetails;
    appDelegate.createdByString = chooseRequestDetailsObj.reqFirstName_String_chooseReqParsedDetails;
    appDelegate.statusString = chooseRequestDetailsObj.requestStatus_String_chooseReqParsedDetails;
    
    
    
    @try {
        //Expected no
        // attendeesObject.expectedNo_String=chooseRequestDetailsObj.expected_No_of_attendees_String_chooseReqParsedDetails;
        isCompleteRequest = chooseRequestDetailsObj.isCompleteRequest_String_chooseReqParsedDetails;
        inCompleteTab_string = chooseRequestDetailsObj.inCompleteTab_String_chooseReqParsedDetails;
        
        for (int i=0; i<expectedNo_ID_mutArray.count; i++) {
            NSString *findValue_str=[expectedNo_ID_mutArray objectAtIndex:i];
            BOOL found;
            if([findValue_str isEqualToString:chooseRequestDetailsObj.expected_No_of_attendees_String_chooseReqParsedDetails])
            {
                found=YES;
                attendeesObject.expectedNo_String=[expectedNo_mutArray objectAtIndex:i];
                attendeesObject.expectedNo_ID_String=[expectedNo_ID_mutArray objectAtIndex:i];
            }
            if(!found)
                attendeesObject.expectedNo_String=@"";
            
        }
        
        //Gender Value
        //attendeesObject.genderPreference_String=chooseRequestDetailsObj.gender_preference_String_chooseReqParsedDetails;
        for (int i=0; i<genderPreference_ID_Array.count; i++) {
            BOOL found;
            NSString *find_str= [genderPreference_ID_Array objectAtIndex:i];
            if([find_str isEqualToString:chooseRequestDetailsObj.gender_preference_String_chooseReqParsedDetails])
            {
                found=YES;
                attendeesObject.genderPreference_String=[genderPreference_mutArray objectAtIndex:i];
                attendeesObject.genderPreference_ID_String=[genderPreference_ID_Array objectAtIndex:i];
            }
            if(!found)
                attendeesObject.genderPreference_String=@"";
        }
        
        ////service Provider Preference
        //attendeesObject.preference_String=chooseRequestDetailsObj.service_providergender_preference_String_chooseReqParsedDetails;
        for (int i=0; i<preference_mutArray.count; i++) {
            BOOL found;
            GISDropDownsObject *reqObj= [preference_mutArray objectAtIndex:i];
            if([reqObj.id_String isEqualToString:chooseRequestDetailsObj.service_providergender_preference_String_chooseReqParsedDetails])
            {
                found=YES;
                attendeesObject.preference_String=reqObj.value_String;
                attendeesObject.preference_ID_String=reqObj.id_String;
            }
            if(!found)
                attendeesObject.preference_String=@"";
        }
        
        for (int i=0; i<primaryAudience_mutArray.count; i++) {
            BOOL found;
            GISDropDownsObject *reqObj= [primaryAudience_mutArray objectAtIndex:i];
            if([reqObj.id_String isEqualToString:chooseRequestDetailsObj.primaryAudience_String_chooseReqParsedDetails])
            {
                found=YES;
                attendeesObject.primaryAudience_String=reqObj.value_String;
                attendeesObject.primaryAudience_ID_String=reqObj.id_String;
            }
            if(!found)
                attendeesObject.primaryAudience_String=@"";
        }
    }
    @catch (NSException *exception) {
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in Attendeees getChooseRequestDetails  action %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
    
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    [paramsDict setObject:attendeesObject.choose_request_ID_String forKey:kID];
    [paramsDict setObject:login_Obj.token_string forKey:kToken];
    
    [[GISServerManager sharedManager] getAttendees_Details_Data:self withParams:paramsDict finishAction:@selector(successmethod_get_Attendees_Details:) failAction:@selector(failuremethod_get_Attendees_Details:)];
}

-(void)failuremethod_getChooseRequestDetails:(GISJsonRequest *)response
{
    NSLog(@"Failure");
}


-(void)successmethod_get_Attendees_Details:(GISJsonRequest *)response
{
    [self removeLoadingView];
    GISAttendeesDetailsStore *store;
    NSLog(@"successmethod_get_Attendees_Details Success---%@",response.responseJson);
    [[GISStoreManager sharedManager]removeAttendees_Details_Objects];
    [attendeesObject.attendeesList_mutArray removeAllObjects];
    store =[[GISAttendeesDetailsStore alloc]initWithStoreDictionary:response.responseJson];
    attendeesObject.attendeesList_mutArray= [[GISStoreManager sharedManager]getAttendees_Details_Objects];
    
    
    if (attendeesObject.attendeesList_mutArray.count==0) {
        row_count=2;
        [self performSelector:@selector(add_AttendeeListObj_ForStoring_Data) withObject:nil];
    }
    else if (attendeesObject.attendeesList_mutArray.count==1) {
        row_count=2;
        [self performSelector:@selector(add_AttendeeListObj_ForStoring_Data) withObject:nil];
    }
    else
    {
        row_count=[attendeesObject.attendeesList_mutArray count];
        
    }
    [self.attendees_tableView reloadData];
    
    
    
}
-(void)failuremethod_get_Attendees_Details:(GISJsonRequest *)response
{
    NSLog(@"Failure");
}

-(void)add_AttendeeListObj_ForStoring_Data
{
    [attendeesObject.attendeesList_mutArray removeAllObjects];
    NSMutableArray *arrayHere=[[NSMutableArray alloc]init];
    for (int i=0; i<row_count; i++)
    {
        GISAttendees_ListObject *attendees_ListObject1=[[GISAttendees_ListObject alloc]init];
        [arrayHere addObject:[self addEmptyData:attendees_ListObject1]];
    }
    attendeesObject.attendeesList_mutArray=arrayHere;
    [attendees_tableView reloadData];
}

#pragma mark Text Field Delegate Methods


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    currentTextField=textField;
    id textFieldSuper = textField;
    while (![textFieldSuper isKindOfClass:[GISAttendeesTopCell class]]) {
        textFieldSuper = [textFieldSuper superview];
    }
    id tempCellRef = (GISAttendeesTopCell *)textField.superview.superview.superview;
    GISAttendeesTopCell *attendeeCellHere = (GISAttendeesTopCell *)tempCellRef;
    if (attendeeCellHere.cellSectionNumber == 1){
        if (textField.tag==333) {
            [GISUtility moveemailView:YES viewHeight:195 view:self.view];
        }
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    // Get the cell in which the textfield is embedded
    id textFieldSuper = textField;
    while (![textFieldSuper isKindOfClass:[GISAttendeesTopCell class]]) {
        textFieldSuper = [textFieldSuper superview];
    }
    //[GISUtility moveemailView:YES viewHeight:195 view:_currentView];
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    id tempCellRef = (GISAttendeesTopCell *)textField.superview.superview.superview;
    GISAttendeesTopCell *attendeeCellHere = (GISAttendeesTopCell *)tempCellRef;
    if (attendeeCellHere.cellSectionNumber == 1)
    {
        if (textField.tag==333) {
            [GISUtility moveemailView:NO viewHeight:0 view:self.view];
        }
        GISAttendees_ListObject *attendees_ListObject_here = [attendeesObject.attendeesList_mutArray objectAtIndex:attendeeCellHere.cellRowNumber];
        attendees_ListObject_here.email_String=attendeeCellHere.email_textField.text;
        attendees_ListObject_here.firstname_String=attendeeCellHere.firstname_textField.text;
        attendees_ListObject_here.lastname_String=attendeeCellHere.lastname_textField.text;
        [attendeesObject.attendeesList_mutArray replaceObjectAtIndex:attendeeCellHere.cellRowNumber withObject:attendees_ListObject_here];
        
        if ([attendees_ListObject_here.email_String length]) {
            NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailReg];
            if ([emailTest evaluateWithObject:attendees_ListObject_here.email_String] != YES)
            {
                [self resignCurrentTextField];
                [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"please_Enter_Valid_Email", TABLE, nil)];
                return;
            }
        }
    }
}

-(void)resignCurrentTextField
{
    
    [GISUtility moveemailView:NO viewHeight:0 view:self.view];
    [currentTextField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resignCurrentTextField];
    return YES;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
