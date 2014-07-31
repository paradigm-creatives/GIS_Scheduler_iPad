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

-(void)sendTheSelectedPopOverData:(NSString *)id_str :(NSString *)value_str
{
    if (btnTag==111) {
        unitOrDep_Answer_Label.text=value_str;
        NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
        [paramsDict setObject:id_str forKey:kID];
        [paramsDict setObject:login_Obj.token_string forKey:kToken];
        [[GISServerManager sharedManager] getBillingsData:self withParams:paramsDict finishAction:@selector(successmethod_BillingsData:) failAction:@selector(failuremethod_BillingsData:)];
    }
    else
    {
        contacts_Answer_Label.text=value_str;
    }
    [popover dismissPopoverAnimated:YES];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
