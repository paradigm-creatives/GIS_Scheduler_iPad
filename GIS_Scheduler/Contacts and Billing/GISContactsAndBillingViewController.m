//
//  GISContactsAndBillingViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISContactsAndBillingViewController.h"
#import "GISFonts.h"
#import "GISConstants.h"
#import "GISDatabaseManager.h"
#import "GISJSONProperties.h"
#import "GISServerManager.h"
#import "GISContactsInfoStore.h"
#import "GISJsonRequest.h"
#import "GISStoreManager.h"
#import "GISDatabaseConstants.h"
#import "GISUtility.h"
#import "GISEventDetailsViewController.h"
@interface GISContactsAndBillingViewController ()

@end

@implementation GISContactsAndBillingViewController

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
    contactBilling_Object= [[GISContactAndBillingObject alloc]init];
    
    btnTag=0;
    requestorDetails_Label.textColor=UIColorFromRGB(0x666666);
    
    unitOrDep_Label.textColor=UIColorFromRGB(0x666666);
    unitOrDep_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    firstName_Label.textColor=UIColorFromRGB(0x666666);
    firstName_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    lastName_Label.textColor=UIColorFromRGB(0x666666);
    lastName_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    email_Label.textColor=UIColorFromRGB(0x666666);
    email_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    contacts_Label.textColor=UIColorFromRGB(0x666666);
    contacts_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    billingDetails_Label.textColor=UIColorFromRGB(0x666666);
    
    accountName_Label.textColor=UIColorFromRGB(0x666666);
    accountName_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    department_Label.textColor=UIColorFromRGB(0x666666);
    department_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    buhFirstName_Label.textColor=UIColorFromRGB(0x666666);
    buhFirstName_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    buhLastName_Label.textColor=UIColorFromRGB(0x666666);
    buhLastName_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    buhEmail_Label.textColor=UIColorFromRGB(0x666666);
    buhEmail_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    buhAddress1_Label.textColor=UIColorFromRGB(0x666666);
    buhAddress2_Label.textColor=UIColorFromRGB(0x666666);
    
    buhAddress1_TextView.textColor=UIColorFromRGB(0x666666);
    buhAddress2_textView.textColor=UIColorFromRGB(0x666666);
    
    buhCity_Label.textColor=UIColorFromRGB(0x666666);
    buhCity_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    buhState_Label.textColor=UIColorFromRGB(0x666666);
    buhState_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    buhZip_Label.textColor=UIColorFromRGB(0x666666);
    buhZip_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    
    nextButton.backgroundColor=UIColorFromRGB(0x00457c);
    [nextButton setTitleColor:UIColorFromRGB(0xe8d4a2) forState:UIControlStateNormal];
    nextButton.titleLabel.font=[GISFonts larger];
    [nextButton.layer setCornerRadius:3.0f];
    /////
    requestorDetails_Label.font=[GISFonts large];
    
    unitOrDep_Label.font=[GISFonts normal];
    unitOrDep_Answer_Label.font=[GISFonts small];
    
    firstName_Label.font=[GISFonts normal];
    firstName_Answer_Label.font=[GISFonts small];
    
    lastName_Label.font=[GISFonts normal];
    lastName_Answer_Label.font=[GISFonts small];
    
    email_Label.font=[GISFonts normal];
    email_Answer_Label.font=[GISFonts small];
    
    contacts_Label.font=[GISFonts normal];
    contacts_Answer_Label.font=[GISFonts small];
    
    billingDetails_Label.font=[GISFonts large];
    
    accountName_Label.font=[GISFonts normal];
    accountName_Answer_Label.font=[GISFonts small];
    
    department_Label.font=[GISFonts normal];
    department_Answer_Label.font=[GISFonts small];
    
    buhFirstName_Label.font=[GISFonts normal];
    buhFirstName_Answer_Label.font=[GISFonts small];
    
    buhLastName_Label.font=[GISFonts normal];
    buhLastName_Answer_Label.font=[GISFonts small];
    
    buhEmail_Label.font=[GISFonts normal];
    buhEmail_Answer_Label.font=[GISFonts small];
    
    buhAddress1_Label.font=[GISFonts normal];
    buhAddress2_Label.font=[GISFonts normal];
    
    buhAddress1_TextView.font=[GISFonts small];
    buhAddress2_textView.font=[GISFonts small];
    
    buhCity_Label.font=[GISFonts normal];
    buhCity_Answer_Label.font=[GISFonts small];
    
    buhState_Label.font=[GISFonts normal];
    buhState_Answer_Label.font=[GISFonts small];
    
    buhZip_Label.font=[GISFonts normal];
    buhZip_Answer_Label.font=[GISFonts small];
    
    
    [buhAddress1_TextView.layer setBorderWidth:0.2];
    [buhAddress1_TextView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [buhAddress1_TextView.layer setCornerRadius:5.0f];
    
    [buhAddress2_textView.layer setBorderWidth:0.2];
    [buhAddress2_textView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [buhAddress2_textView.layer setCornerRadius:5.0f];
    
    unitOrDep_Label.text=NSLocalizedStringFromTable(@"unit_department", TABLE, nil);
    firstName_Label.text=NSLocalizedStringFromTable(@"first_name", TABLE, nil);
    lastName_Label.text=NSLocalizedStringFromTable(@"last_name", TABLE, nil);
    email_Label.text=NSLocalizedStringFromTable(@"email", TABLE, nil);
    contacts_Label.text=NSLocalizedStringFromTable(@"contacts", TABLE, nil);
    
    department_Label.text=NSLocalizedStringFromTable(@"department", TABLE, nil);
    buhFirstName_Label.text=NSLocalizedStringFromTable(@"buh_first_name", TABLE, nil);
    buhLastName_Label.text=NSLocalizedStringFromTable(@"buh_last_name", TABLE, nil);
    buhEmail_Label.text=NSLocalizedStringFromTable(@"buh_email", TABLE, nil);
    buhAddress1_Label.text=NSLocalizedStringFromTable(@"buh_address_one", TABLE, nil);
    buhAddress2_Label.text=NSLocalizedStringFromTable(@"buh_address_two", TABLE, nil);
    buhState_Label.text=NSLocalizedStringFromTable(@"buh_state", TABLE, nil);
    buhCity_Label.text=NSLocalizedStringFromTable(@"buh_city", TABLE, nil);
    buhZip_Label.text=NSLocalizedStringFromTable(@"buh_zip", TABLE, nil);
    
    requestorDetails_Label.text=NSLocalizedStringFromTable(@"requestor_Details", TABLE, nil);
    billingDetails_Label.text=NSLocalizedStringFromTable(@"billing_details", TABLE, nil);
    
    [nextButton setTitle:NSLocalizedStringFromTable(@"Next", TABLE, nil) forState:UIControlStateNormal];
    
    [unitOrDepartment_mutArray removeAllObjects];
   
    NSString *unitIDorDep_statement = [[NSString alloc]initWithFormat:@"select * from TBL_UNIT_DEPARTMENT;"];
    unitOrDepartment_mutArray = [[[GISDatabaseManager sharedDataManager] getDropDownArray:unitIDorDep_statement] mutableCopy];
    
    NSString *loginStr = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *login_array = [[GISDatabaseManager sharedDataManager] geLoginArray:loginStr];
    login_Obj=[login_array lastObject];
    
    firstName_Answer_Label.text=login_Obj.firstName_string;
    lastName_Answer_Label.text=login_Obj.lastName_string;
    email_Answer_Label.text=login_Obj.email_string;
    
    contactBilling_Object.firstName_String=login_Obj.firstName_string;
    contactBilling_Object.lastName_String=login_Obj.lastName_string;
    contactBilling_Object.email_String=login_Obj.email_string;
    
    
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    [paramsDict setObject:login_Obj.requestorID_string forKey:kID];
    [paramsDict setObject:login_Obj.token_string forKey:kToken];
    [[GISServerManager sharedManager] getContactsData:self withParams:paramsDict finishAction:@selector(successmethod_ContactsData:) failAction:@selector(failuremethod_ContactsData:)];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
}

- (IBAction)chooseRequestDropDown:(id)sender{
    
    UIButton *button = (UIButton*)sender;
    
    tableViewController = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController.popOverDelegate=self;
    CGRect frame=tableViewController.view.frame;
    frame.size.width=438;
    tableViewController.view.frame=frame;
    
    CGRect frame1= tableViewController.popOverTableView.frame;
    frame1.size.width=438;
    tableViewController.popOverTableView.frame=frame1;
    
    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController];
    
    popover.delegate = self;
    popover.popoverContentSize = CGSizeMake(340, 150);
    
    if([sender tag]==111)
    {
        btnTag=111;
        
       tableViewController.popOverArray=unitOrDepartment_mutArray;
        [popover presentPopoverFromRect:CGRectMake(button.frame.size.width*2+10, button.frame.size.height / 1+50, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    else if ([sender tag]==222)
    {
        btnTag=222;
       tableViewController.popOverArray=contacts_Info_mutArray;
        [popover presentPopoverFromRect:CGRectMake(317, 167, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}


-(void)successmethod_ContactsData:(GISJsonRequest *)response
{
    GISContactsInfoStore *contactsInfoStore;
    NSLog(@"successmethod_ContactsData Success---%@",response.responseJson);
    contactsInfoStore=[[GISContactsInfoStore alloc]initWithJsonDictionary:response.responseJson];
    [contacts_Info_mutArray removeAllObjects];
    contacts_Info_mutArray=[[GISStoreManager sharedManager]getContactsInfoObjects];
    
    //Contacts INFO DB
    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_CONTACTS_INFO];
    for (int i=0; i<contacts_Info_mutArray.count; i++) {
        GISContactsInfoObject *contactObj=[contacts_Info_mutArray objectAtIndex:i];
        NSArray *objectsArray1 = [NSArray arrayWithObjects: contactObj.contactInfoId_String,contactObj.contactNo_String,contactObj.contactType_String,contactObj.contactTypeId_String,contactObj.contactTypeNo_String, nil];
        NSArray *keysArray1 = [NSArray arrayWithObjects: kGetContactInfoId,kGetContactNo,kGetContactType,kGetContactTypeId,kGetContactTypeNo, nil];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
        [[GISDatabaseManager sharedDataManager] insertContactInfoData:dic];
    }
    
    ////Contacts INFO
}

-(void)failuremethod_ContactsData:(GISJsonRequest *)response
{
    NSLog(@"Failure");
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str  value:(NSString *)value_str
{
    if (btnTag==111) {
        unitOrDep_Answer_Label.text=value_str;
        contactBilling_Object.unitOrDepartment_ID_String=id_str;
        NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
//        [paramsDict setObject:id_str forKey:kID];
//        [paramsDict setObject:login_Obj.token_string forKey:kToken];
//        [[GISServerManager sharedManager] getBillingsData:self withParams:paramsDict finishAction:@selector(successmethod_BillingsData:) failAction:@selector(failuremethod_BillingsData:)];
        
        if (![appDelegate.chooseRequest_ID_String isKindOfClass:[NSNull class]]|| (appDelegate.chooseRequest_ID_String!=nil)) {
            [paramsDict setObject:appDelegate.chooseRequest_ID_String forKey:kID];
            [paramsDict setObject:login_Obj.token_string forKey:kToken];
             [[GISServerManager sharedManager] getChooseRequestDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_getRequestDetails:) failAction:@selector(failuremethod_getRequestDetails:)];
        }
        else{
            [[GISServerManager sharedManager] getBillingsData:self withParams:paramsDict finishAction:@selector(successmethod_BillingsData:) failAction:@selector(failuremethod_BillingsData:)];
        }
       
        
    }
    else
    {
        contacts_Answer_Label.text=value_str;
    }
    [popover dismissPopoverAnimated:YES];
}

//Here we get UnitID from this again we have to get Billing details
-(void)successmethod_getRequestDetails:(GISJsonRequest *)response
{
    NSLog(@"successmethod_getRequestDetails Success---%@",response.responseJson);
    
    chooseRequestDetailsObj=[[GISChooseRequestDetailsObject alloc]initWithStoreChooseRequestDetailsDictionary:response.responseJson];
    [[GISStoreManager sharedManager]addChooseRequestDetailsObject:chooseRequestDetailsObj];
    appDelegate.createdDateString = chooseRequestDetailsObj.createdDate_String_chooseReqParsedDetails;
    appDelegate.createdByString = chooseRequestDetailsObj.reqFirstName_String_chooseReqParsedDetails;
    appDelegate.statusString = chooseRequestDetailsObj.requestStatus_String_chooseReqParsedDetails;
    
    
    NSArray *reqDetailsArray=response.responseJson;
    if (reqDetailsArray.count>0) {
        NSDictionary *reqDict=[reqDetailsArray lastObject];
        NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
        [paramsDict setObject:[reqDict objectForKey:KGetRequestDetails_UnitID ] forKey:kID];
        [paramsDict setObject:login_Obj.token_string forKey:kToken];
        BOOL unitId_found;
        for (GISDropDownsObject *dropDownObj in unitOrDepartment_mutArray) {
            if ([dropDownObj.id_String isEqualToString:[reqDict objectForKey:KGetRequestDetails_UnitID ]]) {
                unitId_found=YES;
                contactBilling_Object.unitOrDepartment_String=dropDownObj.value_String;
                contactBilling_Object.unitOrDepartment_ID_String=dropDownObj.id_String;
                
            }
        }
        if (unitId_found)
        {
            
        }
        else
        {
            contactBilling_Object.unitOrDepartment_String=[reqDict objectForKey:KGetRequestDetails_UnitID ];
            contactBilling_Object.unitOrDepartment_ID_String=[reqDict objectForKey:KGetRequestDetails_UnitID ];
        }
        
        [[GISServerManager sharedManager] getBillingsData:self withParams:paramsDict finishAction:@selector(successmethod_BillingsData:) failAction:@selector(failuremethod_BillingsData:)];
    }
    else
    {
        
    }
    
}
-(void)failuremethod_getRequestDetails:(GISJsonRequest *)response
{
    NSLog(@"Failure");
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    currentTextField=textField;
    [GISUtility moveemailView:YES viewHeight:195 view:self.view];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
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


-(void)successmethod_BillingsData:(GISJsonRequest *)response
{
    NSLog(@"Success---%@----",response.responseJson);
    [self loadTableWithBuildingdata:response.responseJson];
}

-(void)failuremethod_BillingsData:(GISJsonRequest *)response
{
    NSLog(@"Failure");
}

-(void)loadTableWithBuildingdata:(id)sender
{
    [[GISStoreManager sharedManager]removeBillingDataObjects];
    GISBilingDataObject *billingDataObj=[[GISBilingDataObject alloc]initWithStoreBillingDataDictionary:sender];
    [[GISStoreManager sharedManager]addBillingDataObject:billingDataObj];
    
    NSMutableArray *billingArray=[[GISStoreManager sharedManager]getBillingDataObject];
    if (billingArray.count>0) {
        billingDataObj=[billingArray lastObject];
        buhAddress1_TextView.text=billingDataObj.buh_address1_String;
       buhAddress2_textView.text=billingDataObj.buh_address2_String;
       buhCity_Answer_Label.text=billingDataObj.buh_city_String;
       buhEmail_Answer_Label.text=billingDataObj.buh_email_String;
       buhFirstName_Answer_Label.text=billingDataObj.buh_firstName_String;
       buhLastName_Answer_Label.text=billingDataObj.buh_lastName_String;
       buhState_Answer_Label.text=billingDataObj.buh_state_String;
       buhZip_Answer_Label.text=billingDataObj.buh_zip_String;
       department_Answer_Label.text=billingDataObj.department_String;
    }
}

- (IBAction)nextButtonPressed:(id)sender
{
    
    contactBilling_Object.chooseRequest_ID_String=[GISUtility returningstring:appDelegate.chooseRequest_ID_String];
    
    @try {
        
        NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
        
        if ([contactBilling_Object.chooseRequest_String isEqualToString:NSLocalizedStringFromTable(@"new request", TABLE, nil)]||  contactBilling_Object.chooseRequest_String==nil || [contactBilling_Object.chooseRequest_String isKindOfClass:[NSNull class]])
        {
            [paramsDict setObject:@"0" forKey:@"requestNo"];
            appDelegate.isNewRequest = YES;
        }
        else{
            [paramsDict setObject:contactBilling_Object.chooseRequest_ID_String forKey:@"requestNo"];
            appDelegate.isNewRequest = NO;
        }
        if ([GISUtility returningstring:contactBilling_Object.unitOrDepartment_ID_String] || [contactBilling_Object.unitOrDepartment_ID_String length]>0)
            [paramsDict setObject:contactBilling_Object.unitOrDepartment_ID_String forKey:kunitid];
        else{
            [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select Unit/Department", TABLE, nil)];
            return;
        }
        
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults synchronize];
        [userDefaults setValue:contactBilling_Object.unitOrDepartment_ID_String forKey:kunitid];
        [userDefaults setValue:contactBilling_Object.chooseRequest_String forKey:kRequestNo];
        
        [paramsDict setObject:login_Obj.requestorID_string forKey:krequestorid];
        if ([contactBilling_Object.chooseRequest_ID_String length] == 0 || [contactBilling_Object.chooseRequest_ID_String isKindOfClass:[NSNull class]])
        {
            [paramsDict setObject:kInComplete forKey:kstatusid];
            [paramsDict setObject:@"" forKey:keventDetails_capnoofUsers];
            [paramsDict setObject:@"" forKey:keventDetails_captionView];
            [paramsDict setObject:@"" forKey:keventDetails_captiontype];
            [paramsDict setObject:@"" forKey:keventDetails_dresscodeId];
            [paramsDict setObject:@"" forKey:keventDetails_eventDesc];
            [paramsDict setObject:@""forKey:keventDetails_eventName];
            [paramsDict setObject:@""forKey:keventDetails_eventId];
            [paramsDict setObject:@"" forKey:keventDetails_onGoing];
            [paramsDict setObject:@"" forKey:keventDetails_eventPublic];
            [paramsDict setObject:@"" forKey:keventDetails_otherServices];
            [paramsDict setObject:@"" forKey:keventDetails_Othertech];
            [paramsDict setObject:@"" forKey:keventDetails_broadcast];
            [paramsDict setObject:@"" forKey:keventDetails_recordBroadcastYes];
            [paramsDict setObject:@"" forKey:keventDetails_CourseId];
        }
        else{
            //anand newly added fields
            [paramsDict setObject:chooseRequestDetailsObj.statusID_String_chooseReqParsedDetails forKey:kstatusid];
            [paramsDict setObject:chooseRequestDetailsObj.CapNoOfUsers_String_chooseReqParsedDetails forKey:keventDetails_capnoofUsers];
            [paramsDict setObject:chooseRequestDetailsObj.CapViewOptions_String_chooseReqParsedDetails forKey:keventDetails_captionView];
            [paramsDict setObject:chooseRequestDetailsObj.CaptionTypeID_String_chooseReqParsedDetails forKey:keventDetails_captiontype];
            [paramsDict setObject:chooseRequestDetailsObj.dressCodeID_String_chooseReqParsedDetails forKey:keventDetails_dresscodeId];
            [paramsDict setObject:chooseRequestDetailsObj.eventDescription_String_chooseReqParsedDetails forKey:keventDetails_eventDesc];
            [paramsDict setObject:chooseRequestDetailsObj.eventName_String_chooseReqParsedDetails forKey:keventDetails_eventName];
            [paramsDict setObject:chooseRequestDetailsObj.eventTypeID_String_chooseReqParsedDetails forKey:keventDetails_eventId];
            [paramsDict setObject:chooseRequestDetailsObj.onGoing_String_chooseReqParsedDetails forKey:keventDetails_onGoing];
            [paramsDict setObject:chooseRequestDetailsObj.openToPublic_String_chooseReqParsedDetails forKey:keventDetails_eventPublic];
            [paramsDict setObject:chooseRequestDetailsObj.OtherServiceID_String_chooseReqParsedDetails forKey:keventDetails_otherServices];
            [paramsDict setObject:chooseRequestDetailsObj.otherTechnologies_String_chooseReqParsedDetails forKey:keventDetails_Othertech];
            [paramsDict setObject:chooseRequestDetailsObj.recBroadcast_String_chooseReqParsedDetails forKey:keventDetails_broadcast];
            [paramsDict setObject:chooseRequestDetailsObj.recBroadcastYes_String_chooseReqParsedDetails forKey:keventDetails_recordBroadcastYes];
            [paramsDict setObject:chooseRequestDetailsObj.courseID_String_chooseReqParsedDetails forKey:keventDetails_CourseId];
            
            [paramsDict setObject:chooseRequestDetailsObj.reqLocation_Id_chooseReqParsedDetails forKey:kChooseReqDetails_reqlocationid];
            [paramsDict setObject:chooseRequestDetailsObj.generalLocation_String_chooseReqParsedDetails forKey:kChooseReqDetails_generallocationid];
            [paramsDict setObject:chooseRequestDetailsObj.building_Id_String_chooseReqParsedDetails forKey:kChooseReqDetails_buildingid];
            [paramsDict setObject:chooseRequestDetailsObj.RoomNunber_String_chooseReqParsedDetails forKey:kChooseReqDetails_roomnunber];
            [paramsDict setObject:chooseRequestDetailsObj.RoomName_String_chooseReqParsedDetails forKey:kChooseReqDetails_roomname];
            [paramsDict setObject:chooseRequestDetailsObj.other_String_chooseReqParsedDetails forKey:kChooseReqDetails_other];
            [paramsDict setObject:chooseRequestDetailsObj.offCamp_LocationName_String_chooseReqParsedDetails forKey:kChooseReqDetails_offcamplocname];
            [paramsDict setObject:chooseRequestDetailsObj.offCamp_address1_String_chooseReqParsedDetails forKey:kChooseReqDetails_offcampaddress1];
            [paramsDict setObject:chooseRequestDetailsObj.offCamp_address2_String_chooseReqParsedDetails forKey:kChooseReqDetails_offcampaddress2];
            [paramsDict setObject:chooseRequestDetailsObj.offCamp_state_String_chooseReqParsedDetails forKey:kChooseReqDetails_offcampstate];
            [paramsDict setObject:chooseRequestDetailsObj.offCamp_city_String_chooseReqParsedDetails forKey:kChooseReqDetails_offcampcity];
            [paramsDict setObject:chooseRequestDetailsObj.offCamp_zip_String_chooseReqParsedDetails forKey:kChooseReqDetails_offcampzip];
            [paramsDict setObject:chooseRequestDetailsObj.ClosestMetro_String_chooseReqParsedDetails forKey:kChooseReqDetails_closestmetro];
            [paramsDict setObject:chooseRequestDetailsObj.parking_String_chooseReqParsedDetails forKey:kChooseReqDetails_parking];
            [paramsDict setObject:chooseRequestDetailsObj.SpecialProtocol_String_chooseReqParsedDetails forKey:kChooseReqDetails_specialprotocol];
            [paramsDict setObject:chooseRequestDetailsObj.otherInfo_String_chooseReqParsedDetails forKey:kChooseReqDetails_other_info];
            [paramsDict setObject:chooseRequestDetailsObj.offLoc_ID_String_chooseReqParsedDetails forKey:kChooseReqDetails_OffCampLocID];
            [paramsDict setObject:chooseRequestDetailsObj.transportation_String_chooseReqParsedDetails forKey:kChooseReqDetails_Transport];
            [paramsDict setObject:chooseRequestDetailsObj.transportationYes_String_chooseReqParsedDetails forKey:kChooseReqDetails_transportnotes];
            [paramsDict setObject:chooseRequestDetailsObj.adminComments_String_chooseReqParsedDetails forKey:kChooseReqDetails_adminComments];
            [paramsDict setObject:chooseRequestDetailsObj.schedulerComments_String_chooseReqParsedDetails forKey:kChooseReqDetails_schedulerComments];
        }
        
        [paramsDict setObject:login_Obj.token_string forKey:kToken];
        
        [[GISServerManager sharedManager] saveUpdateRequestData:self withParams:paramsDict finishAction:@selector(successmethod_saveUpdateRequest:) failAction:@selector(failuremethod_saveUpdateRequest:)];
    }
    @catch (NSException *exception) {
        NSLog(@"EXCEPTION raised, reason was: %@", [exception reason]);
        
    }
}

-(void)successmethod_saveUpdateRequest:(GISJsonRequest *)response
{
    id json =response.responseJson;
    
    NSDictionary *saveUpdateDict;
    
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    if (![[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"400"]) {
        
        if ([json isKindOfClass:[NSDictionary class]]) {
            
            saveUpdateDict=response.responseJson;
            NSLog(@"successmethod_saveUpdateRequest Success---%@",response.responseJson);
            NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
            [userDefaults synchronize];
            [userDefaults setValue:[saveUpdateDict valueForKey:kDropDownValue] forKey:kDropDownValue];
            [userDefaults setValue:[saveUpdateDict valueForKey:kDropDownID] forKey:kDropDownID];
        } else if ([json isKindOfClass:[NSArray class]]) {
            
            NSArray *jsonData  = response.responseJson;
            saveUpdateDict=[jsonData objectAtIndex:0];
            NSLog(@"successmethod_saveUpdateRequest Success---%@",response.responseJson);
            NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
            [userDefaults synchronize];
            [userDefaults setValue:[saveUpdateDict valueForKey:kDropDownValue] forKey:kDropDownValue];
            [userDefaults setValue:[saveUpdateDict valueForKey:kDropDownID] forKey:kDropDownID];
            
        }
        
        if([saveUpdateDict count] > 0){
            
            NSArray *objectsArray1 = [NSArray arrayWithObjects:[saveUpdateDict valueForKey:kDropDownID],[saveUpdateDict valueForKey:kDropDownType],[saveUpdateDict valueForKey:kDropDownValue], nil];
            NSArray *keysArray1 = [NSArray arrayWithObjects: kDropDownID, kDropDownType,kDropDownValue, nil];
            NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
            
            [[GISDatabaseManager sharedDataManager] insertDropDownData:dic Query:[NSString stringWithFormat:@"INSERT INTO TBL_CHOOSE_REQUEST(ID,TYPE,VALUE) VALUES (?,?,?)"]];
            
            appDelegate.isFromContacts = YES;
            
            
            appDelegate.contact_billingObject = contactBilling_Object;
            
            
                GISEventDetailsViewController *eventViewController;
                
                if([login_Obj.userStatus_string isEqualToString:kInternal]){
                    
                    eventViewController =[[GISEventDetailsViewController alloc]initWithNibName:@"GISEventDetailsViewController" bundle:nil];
                }
                else{
                    eventViewController =[[GISEventDetailsViewController alloc]initWithNibName:@"GISEventDetailsViewController" bundle:nil];
                }
                
            
        }else{
            
            [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"please_check_details",TABLE, nil)];
        }
    }else{
        
        [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"please_check_details",TABLE, nil)];
    }
    
}
-(void)failuremethod_saveUpdateRequest:(GISJsonRequest *)response
{
    NSLog(@"Failure");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
