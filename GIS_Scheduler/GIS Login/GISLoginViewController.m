//
//  GISLoginViewController.m
//  GIS_Scheduler
//
//  Created by Anand on 14/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISLoginViewController.h"
#import "GISConstants.h"
#import "GISFonts.h"
#import "GISAppDelegate.h"
#import "GISServerManager.h"
#import "GISJsonRequest.h"
#import "GISJSONProperties.h"
#import "GISLoadingView.h"
#import "PCLogger.h"
#import "GISUtility.h"
#import "GISStore.h"
#import "GISStoreManager.h"
#import "GISDatabaseManager.h"
#import "GISDatabaseConstants.h"
#import "GISNetworkUtility.h"


@interface GISLoginViewController ()

@end

@implementation GISLoginViewController

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
    
    _userNameView.layer.cornerRadius = 5.0f;
    _userNameView.clipsToBounds = YES;

    _passwordView.layer.cornerRadius = 5.0f;
    _passwordView.clipsToBounds = YES;
    
    _signINButton.layer.cornerRadius = 5.0f;
    _signINButton.clipsToBounds = YES;
    
    [_signINButton setTitle:NSLocalizedStringFromTable(@"login", TABLE, nil) forState:UIControlStateNormal];
    [_signINButton setTitleColor:UIColorFromRGB(0x00457c) forState:UIControlStateNormal];
    [_signINButton.titleLabel setFont:[GISFonts large]];
    
    [self addRightView:_userName_textfield];
    [self addRightView:_password_textfield];
    
    [_userName_textfield setPlaceholder:NSLocalizedStringFromTable(@"user_name", TABLE, nil)];
    [_password_textfield setPlaceholder:NSLocalizedStringFromTable(@"password", TABLE, nil)];
    
    [_userName_textfield setValue:[GISFonts large] forKeyPath:@"_placeholderLabel.font"];
    [_password_textfield setValue:[GISFonts large] forKeyPath:@"_placeholderLabel.font"];
    
    [_userName_textfield setValue:UIColorFromRGB(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    [_password_textfield setValue:UIColorFromRGB(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    
    [_userName_textfield setFont:[GISFonts large]];
    [_password_textfield setFont:[GISFonts large]];
    
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];

    
    viewUpHeight = 155;
    
    _userName_textfield.text=@"swamy.pilla@gmail.com";
    _password_textfield.text=@"admin";
}

-(void)addRightView:(UITextField *) textField{
    
    UIImageView *imgView;
    UIView *paddingView ;
    
    if(_userName_textfield == textField){
        imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_username.png"]];
        imgView.frame = CGRectMake(0.0, 0.0, imgView.image.size.width, imgView.image.size.height);
    }else{
        imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password.png"]];
        imgView.frame = CGRectMake(0.0, 0.0, imgView.image.size.width, imgView.image.size.height);
    }
    
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55.0, 40.0)];
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45.0, 40.0)];
    
    [imgView setCenter:CGPointMake(paddingView.frame.size.width / 2, paddingView.frame.size.height / 2)];
    [paddingView setBackgroundColor:UIColorFromRGB(0xdedede)];
    
    [paddingView addSubview:imgView];
    [mainView addSubview:paddingView];
    [textField setLeftViewMode:UITextFieldViewModeAlways];
    [textField setLeftView:mainView];

}

-(IBAction)signInClicked:(id)sender{
    
    if ([[GISNetworkUtility sharedManager] checkNetworkAvailability])
    {
        userName_String=_userName_textfield.text;
        password_String=_password_textfield.text;
        
        [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
        if(appDelegate.isLogout){
            [[GISDatabaseManager sharedDataManager] reloadTheDatabaseFile];
            appDelegate.isLogout = NO;
        }
        
        NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailReg];
        if (userName_String.length<1 || password_String.length<1)
        {
            [self removeLoadingView];
            UIAlertView *email_alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"gis_title", TABLE, nil) message:NSLocalizedStringFromTable(@"enter_username_password", TABLE, nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            [email_alert show];
            return;
        }
        else if ([emailTest evaluateWithObject:userName_String] != YES)
        {
            [self removeLoadingView];
            UIAlertView *email_alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"gis_title", TABLE, nil) message:NSLocalizedStringFromTable(@"enter_validEmail", TABLE, nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            [email_alert show];
            return;
        }
        else
        {
            NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
            [paramsDict setObject:userName_String forKey:@"email"];
            [paramsDict setObject:password_String forKey:@"password"];
            [[GISServerManager sharedManager] logininForTarget:self withParams:paramsDict finishAction:@selector(successmethod_login:) failAction:@selector(failuremethod_login:)];
        }
    }else{
        [self loginFailedWithNetworkError];
    }
}

-(void)loginFailedWithNetworkError
{
    //    [self showAlertWithTitle:@"Cellular Data is Turned Off" andMessage:@"Turn on cellular data or use Wi-Fi to access data."];
    
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"network_connection",TABLE, nil)];
}

-(void)successmethod_login:(GISJsonRequest *)response
{
        NSLog(@"Success---%@",response.responseJson);
        if ([response.responseJson isKindOfClass:[NSArray class]])
        {
            id array=response.responseJson;
            NSDictionary *dictHere=[array lastObject];
            if ([[dictHere objectForKey:kStatusCode] isEqualToString:@"200"]) {
                
                [self removeLoadingView];
                
                gisStore=[[GISStore alloc]initWithJsonDictionary:(NSDictionary *)response.responseJson];
                GISLoginDetailsObject *login_Obj;
                ///Parse GetDropDowns start
                NSMutableArray *loginArray=  [[GISStoreManager sharedManager]getLoginObjects];
                if (loginArray.count>0) {
                    login_Obj=[loginArray objectAtIndex:0];
                    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
                    [paramsDict setObject:login_Obj.requestorID_string forKey:@"id"];
                    [paramsDict setObject:login_Obj.token_string forKey:@"token"];
                    [[GISServerManager sharedManager] getDropDownData:self withParams:paramsDict finishAction:@selector(successmethod_dropDown:) failAction:@selector(failuremethod_dropDown:)];
                    
                    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
                    {
                        NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
                        [paramsDict setObject:login_Obj.requestorID_string forKey:KRequestorId];
                        [paramsDict setObject:login_Obj.token_string forKey:@"token"];
                        [[GISServerManager sharedManager] getMastersData_Schedulers:self withParams:paramsDict finishAction:@selector(successmethod_dropDown_schedulers:) failAction:@selector(failuremethod_dropDown_schedulers:)];
                    }
                    
                    
                    //LOGIN DB
                    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_LOGIN];
                    NSArray *objectsArray1 = [NSArray arrayWithObjects: login_Obj.requestorID_string,login_Obj.email_string,login_Obj.firstName_string,login_Obj.lastName_string,login_Obj.token_string,login_Obj.userStatus_string,login_Obj.roles_string,login_Obj.role_ID_string, nil];
                    NSArray *keysArray1 = [NSArray arrayWithObjects: kLoginRequestorID, kLoginEmail,kLoginFirstName,kLoginLastName,kLoginToken,kLoginUserStatus,kLoginRoles,kLoginRoleId, nil];
                    NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
                    [[GISDatabaseManager sharedDataManager] insertLoginData:dic];
                    ////LOGIN
                    
                    ///DROPDOWN
                    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_BUILDING_NAME];
                    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_DRESS_CODE];
                    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_EVENT_TYPE];
                    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_GENERAL_LOCATION];
                    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_UNIT_DEPARTMENT];
                    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_CLOSEST_METRO];
                    //
                    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_MODE_OF_COMMUNICATION];
                    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_SERVICE_PROV_GENDER_PREFERENCE];
                    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_SERVICE_NEEDED];
                    
                    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_SKILL_LEVEL];
                    
                    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_PAY_LEVEL];
                    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_SERVICE_TYPE_SERVICE_PROVIDER];
                    
                    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_REGISTERED_CONSUMERS];
                    
                    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_PRIMARY_AUDIENCE];
                    
                    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_PAY_TYPE];
                    
                    [[GISDatabaseManager sharedDataManager] executeCreateTableQuery:CREATE_TBL_TYPE_OF_SERVICE];
                }

                
                [self.view.window setRootViewController:appDelegate.spiltViewController];
                
            }
            if ([[dictHere objectForKey:kStatusCode] isEqualToString:@"400"]) {
                [self removeLoadingView];
                [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:NSLocalizedStringFromTable(@"login_requestFail",TABLE, nil)] ofType:PC_LOG_INFO];
                UIAlertView *email_alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"gis_title", TABLE, nil)  message:NSLocalizedStringFromTable(@"enter_valid_username_password", TABLE, nil) delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"alert_ok", TABLE, nil) otherButtonTitles:Nil, nil];
                [email_alert show];
                return;
            }
        }
}

-(void)failuremethod_login:(GISJsonRequest *)response
{
    NSLog(@"Failure");
}

-(void)successmethod_dropDown:(GISJsonRequest *)response
{
    NSLog(@"Success---%@",response.responseJson);
    
    [[GISStoreManager sharedManager] removeBuildingNameObjects];
    [[GISStoreManager sharedManager] removeDressCodeObjects];
    [[GISStoreManager sharedManager] removeLocationCodeObjects];
    [[GISStoreManager sharedManager] removeEventTypeObjects];
    [[GISStoreManager sharedManager] removeUnitOrDepartmentObjects];
    
    //// from here
    [[GISStoreManager sharedManager] removeModeOfCommunicationObjects];
    [[GISStoreManager sharedManager] removeServiceProvGenderPrefObjects];
    [[GISStoreManager sharedManager] removeServiceNeededObjects];
    [[GISStoreManager sharedManager] removeClosestmetroObjects];
    [[GISStoreManager sharedManager] removeSkillLevelObjects];
    [[GISStoreManager sharedManager] removePayLevelObjects];
    [[GISStoreManager sharedManager] removeServiceType_ServiceProviderObjects];
    [[GISStoreManager sharedManager] removeRegisteredConsumersObjects];
    [[GISStoreManager sharedManager] removePrimaryAudienceObjects];
    ///
    
    dropDownStore=[[GISDropDownStore alloc]initWithStoreDictionary:response.responseJson];
    
    NSMutableArray *buildingArray=[[GISStoreManager sharedManager] getBuildingNameObjects];
    NSMutableArray *locationCodesArray=[[GISStoreManager sharedManager] getLocationCodeObjects];
    NSMutableArray *eventTypesArray=[[GISStoreManager sharedManager] getEventTypeObjects];
    NSMutableArray *dressCodesArray=[[GISStoreManager sharedManager] getDressCodeObjects];
    NSMutableArray *unitOrDepartmentArray=[[GISStoreManager sharedManager] getUnitOrDepartmentObjects];
    NSMutableArray *closestMetroArray=[[GISStoreManager sharedManager] getClosestmetroObjects];
    
    //////
    NSMutableArray *modeOfCommunicationArray=[[GISStoreManager sharedManager] getModeOfCommunicationObjects];
    NSMutableArray *serviceProvGenderPrefArray=[[GISStoreManager sharedManager] getServiceProvGenderPrefObjects];
    NSMutableArray *serviceNeededArray=[[GISStoreManager sharedManager] getServiceNeededObjects];
    
    NSMutableArray *skillLevel_Array=[[GISStoreManager sharedManager] getSkillLevelObjects];
    NSMutableArray *payLevelArray=[[GISStoreManager sharedManager] getPayLevelObjects];
    
    NSMutableArray *serviceType_serviceProviderArray=[[GISStoreManager sharedManager] getServiceType_ServiceProviderObjects];
    
    NSMutableArray *registeredConsumersArray=[[GISStoreManager sharedManager] getRegisteredConsumersObjects];
    
    NSMutableArray *primaryAudienceArray=[[GISStoreManager sharedManager] getPrimaryAudienceObjects];
    
    for (int i=0; i<registeredConsumersArray.count; i++) {
        GISDropDownsObject *bObj=[registeredConsumersArray objectAtIndex:i];
        NSArray *objectsArray1 = [NSArray arrayWithObjects:bObj.id_String,bObj.type_String,bObj.value_String, nil];
        NSArray *keysArray1 = [NSArray arrayWithObjects: kDropDownID, kDropDownType,kDropDownValue, nil];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
        [[GISDatabaseManager sharedDataManager] insertDropDownData:dic Query:[NSString stringWithFormat:@"INSERT INTO TBL_REGISTERED_CONSUMERS(ID,TYPE,VALUE) VALUES (?,?,?)"]];
    }
    
    for (int i=0; i<primaryAudienceArray.count; i++) {
        GISDropDownsObject *bObj=[primaryAudienceArray objectAtIndex:i];
        NSArray *objectsArray1 = [NSArray arrayWithObjects:bObj.id_String,bObj.type_String,bObj.value_String, nil];
        NSArray *keysArray1 = [NSArray arrayWithObjects: kDropDownID, kDropDownType,kDropDownValue, nil];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
        [[GISDatabaseManager sharedDataManager] insertDropDownData:dic Query:[NSString stringWithFormat:@"INSERT INTO TBL_PRIMARY_AUDIENCE(ID,TYPE,VALUE) VALUES (?,?,?)"]];
    }
    
    for (int i=0; i<serviceType_serviceProviderArray.count; i++) {
        GISDropDownsObject *bObj=[serviceType_serviceProviderArray objectAtIndex:i];
        NSArray *objectsArray1 = [NSArray arrayWithObjects:bObj.id_String,bObj.type_String,bObj.value_String, nil];
        NSArray *keysArray1 = [NSArray arrayWithObjects: kDropDownID, kDropDownType,kDropDownValue, nil];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
        [[GISDatabaseManager sharedDataManager] insertDropDownData:dic Query:[NSString stringWithFormat:@"INSERT INTO TBL_SERVICE_TYPE_SERVICE_PROVIDER(ID,TYPE,VALUE) VALUES (?,?,?)"]];
    }
    
    for (int i=0; i<skillLevel_Array.count; i++) {
        GISDropDownsObject *bObj=[skillLevel_Array objectAtIndex:i];
        NSArray *objectsArray1 = [NSArray arrayWithObjects:bObj.id_String,bObj.type_String,bObj.value_String, nil];
        NSArray *keysArray1 = [NSArray arrayWithObjects: kDropDownID, kDropDownType,kDropDownValue, nil];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
        [[GISDatabaseManager sharedDataManager] insertDropDownData:dic Query:[NSString stringWithFormat:@"INSERT INTO TBL_SKILL_LEVEL(ID,TYPE,VALUE) VALUES (?,?,?)"]];
    }
    

    for (int i=0; i<payLevelArray.count; i++) {
        GISDropDownsObject *bObj=[payLevelArray objectAtIndex:i];
        NSArray *objectsArray1 = [NSArray arrayWithObjects:bObj.id_String,bObj.type_String,bObj.value_String, nil];
        NSArray *keysArray1 = [NSArray arrayWithObjects: kDropDownID, kDropDownType,kDropDownValue, nil];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
        [[GISDatabaseManager sharedDataManager] insertDropDownData:dic Query:[NSString stringWithFormat:@"INSERT INTO TBL_PAY_LEVEL(ID,TYPE,VALUE) VALUES (?,?,?)"]];
    }
    
    for (int i=0; i<buildingArray.count; i++) {
        GISDropDownsObject *bObj=[buildingArray objectAtIndex:i];
        NSArray *objectsArray1 = [NSArray arrayWithObjects:bObj.id_String,bObj.type_String,bObj.value_String, nil];
        NSArray *keysArray1 = [NSArray arrayWithObjects: kDropDownID, kDropDownType,kDropDownValue, nil];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
        [[GISDatabaseManager sharedDataManager] insertDropDownData:dic Query:[NSString stringWithFormat:@"INSERT INTO TBL_BUILDING_NAME(ID,TYPE,VALUE) VALUES (?,?,?)"]];
    }
    
    for (int i=0; i<locationCodesArray.count; i++) {
        GISDropDownsObject *bObj=[locationCodesArray objectAtIndex:i];
        NSArray *objectsArray1 = [NSArray arrayWithObjects:bObj.id_String,bObj.type_String,bObj.value_String, nil];
        NSArray *keysArray1 = [NSArray arrayWithObjects: kDropDownID, kDropDownType,kDropDownValue, nil];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
        [[GISDatabaseManager sharedDataManager] insertDropDownData:dic Query:[NSString stringWithFormat:@"INSERT INTO TBL_GENERAL_LOCATION(ID,TYPE,VALUE) VALUES (?,?,?)"]];
    }
    
    for (int i=0; i<eventTypesArray.count; i++) {
        GISDropDownsObject *bObj=[eventTypesArray objectAtIndex:i];
        NSArray *objectsArray1 = [NSArray arrayWithObjects:bObj.id_String,bObj.type_String,bObj.value_String, nil];
        NSArray *keysArray1 = [NSArray arrayWithObjects: kDropDownID, kDropDownType,kDropDownValue, nil];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
        [[GISDatabaseManager sharedDataManager] insertDropDownData:dic Query:[NSString stringWithFormat:@"INSERT INTO TBL_EVENT_TYPE(ID,TYPE,VALUE) VALUES (?,?,?)"]];
    }
    
    for (int i=0; i<dressCodesArray.count; i++) {
        GISDropDownsObject *bObj=[dressCodesArray objectAtIndex:i];
        NSArray *objectsArray1 = [NSArray arrayWithObjects:bObj.id_String,bObj.type_String,bObj.value_String, nil];
        NSArray *keysArray1 = [NSArray arrayWithObjects: kDropDownID, kDropDownType,kDropDownValue, nil];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
        [[GISDatabaseManager sharedDataManager] insertDropDownData:dic Query:[NSString stringWithFormat:@"INSERT INTO TBL_DRESS_CODE(ID,TYPE,VALUE) VALUES (?,?,?)"]];
    }
    
    for (int i=0; i<unitOrDepartmentArray.count; i++) {
        GISDropDownsObject *bObj=[unitOrDepartmentArray objectAtIndex:i];
        NSArray *objectsArray1 = [NSArray arrayWithObjects:bObj.id_String,bObj.type_String,bObj.value_String, nil];
        NSArray *keysArray1 = [NSArray arrayWithObjects: kDropDownID, kDropDownType,kDropDownValue, nil];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
        [[GISDatabaseManager sharedDataManager] insertDropDownData:dic Query:[NSString stringWithFormat:@"INSERT INTO TBL_UNIT_DEPARTMENT(ID,TYPE,VALUE) VALUES (?,?,?)"]];
    }
    
    for (int i=0; i<closestMetroArray.count; i++) {
        GISDropDownsObject *bObj=[closestMetroArray objectAtIndex:i];
        NSArray *objectsArray1 = [NSArray arrayWithObjects:bObj.id_String,bObj.type_String,bObj.value_String, nil];
        NSArray *keysArray1 = [NSArray arrayWithObjects: kDropDownID, kDropDownType,kDropDownValue, nil];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
        [[GISDatabaseManager sharedDataManager] insertDropDownData:dic Query:[NSString stringWithFormat:@"INSERT INTO TBL_CLOSEST_METRO(ID,TYPE,VALUE) VALUES (?,?,?)"]];
    }

    //
    for (int i=0; i<modeOfCommunicationArray.count; i++) {
        GISDropDownsObject *bObj=[modeOfCommunicationArray objectAtIndex:i];
        NSArray *objectsArray1 = [NSArray arrayWithObjects:bObj.id_String,bObj.type_String,bObj.value_String, nil];
        NSArray *keysArray1 = [NSArray arrayWithObjects: kDropDownID, kDropDownType,kDropDownValue, nil];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
        [[GISDatabaseManager sharedDataManager] insertDropDownData:dic Query:[NSString stringWithFormat:@"INSERT INTO TBL_MODE_OF_COMMUNICATION(ID,TYPE,VALUE) VALUES (?,?,?)"]];
    }
    
    for (int i=0; i<serviceProvGenderPrefArray.count; i++) {
        GISDropDownsObject *bObj=[serviceProvGenderPrefArray objectAtIndex:i];
        NSArray *objectsArray1 = [NSArray arrayWithObjects:bObj.id_String,bObj.type_String,bObj.value_String, nil];
        NSArray *keysArray1 = [NSArray arrayWithObjects: kDropDownID, kDropDownType,kDropDownValue, nil];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
        [[GISDatabaseManager sharedDataManager] insertDropDownData:dic Query:[NSString stringWithFormat:@"INSERT INTO TBL_SERVICE_PROV_GENDER_PREFERENCE(ID,TYPE,VALUE) VALUES (?,?,?)"]];
    }
    
    for (int i=0; i<serviceNeededArray.count; i++) {
        GISDropDownsObject *bObj=[serviceNeededArray objectAtIndex:i];
        NSArray *objectsArray1 = [NSArray arrayWithObjects:bObj.id_String,bObj.type_String,bObj.value_String, nil];
        NSArray *keysArray1 = [NSArray arrayWithObjects: kDropDownID, kDropDownType,kDropDownValue, nil];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
        [[GISDatabaseManager sharedDataManager] insertDropDownData:dic Query:[NSString stringWithFormat:@"INSERT INTO TBL_SERVICE_NEEDED(ID,TYPE,VALUE) VALUES (?,?,?)"]];
    }
        
    ///
//    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
//    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
//    GISLoginDetailsObject *unitObj1=[requetId_array lastObject];
//    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
//    [paramsDict setObject:unitObj1.requestorID_string forKey:kLocationrequestorid];
//    [paramsDict setObject:unitObj1.token_string forKey:kToken];
    
    //[[GISServerManager sharedManager] getviewSchedule:self withParams:paramsDict finishAction:@selector(successmethod_getRequestDetails:) failAction:@selector(failuremethod_getRequestDetails:)];
    
}

/** The folowing method calls when the login success, we are calling the Drop Drowns data, this is the failure response */
-(void)failuremethod_dropDown:(GISJsonRequest *)response
{
    NSLog(@"Failure");
}

-(void)successmethod_dropDown_schedulers:(GISJsonRequest *)response
{
    NSLog(@"Success---%@",response.responseJson);
    
    [[GISStoreManager sharedManager] removePayTypeObjects];
    [[GISStoreManager sharedManager] removeTypeOfServiceObjects];
    dropDownStore=[[GISDropDownStore alloc]initWithStoreDictionary:response.responseJson];
    NSMutableArray *payTypeArray=[[GISStoreManager sharedManager] getPayTypeObjects];
    NSMutableArray *typeOfServiceArray=[[GISStoreManager sharedManager] getTypeOfServiceObjects];
    for (int i=0; i<payTypeArray.count; i++) {
        GISDropDownsObject *bObj=[payTypeArray objectAtIndex:i];
        NSArray *objectsArray1 = [NSArray arrayWithObjects:bObj.id_String,bObj.type_String,bObj.value_String, nil];
        NSArray *keysArray1 = [NSArray arrayWithObjects: kDropDownID, kDropDownType,kDropDownValue, nil];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
        [[GISDatabaseManager sharedDataManager] insertDropDownData:dic Query:[NSString stringWithFormat:@"INSERT INTO TBL_PAY_TYPE(ID,TYPE,VALUE) VALUES (?,?,?)"]];
    }
    
    for (int i=0; i<typeOfServiceArray.count; i++) {
        GISDropDownsObject *bObj=[typeOfServiceArray objectAtIndex:i];
        NSArray *objectsArray1 = [NSArray arrayWithObjects:bObj.id_String,bObj.type_String,bObj.value_String, nil];
        NSArray *keysArray1 = [NSArray arrayWithObjects: kDropDownID, kDropDownType,kDropDownValue, nil];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:objectsArray1 forKeys:keysArray1];
        [[GISDatabaseManager sharedDataManager] insertDropDownData:dic Query:[NSString stringWithFormat:@"INSERT INTO TBL_TYPE_OF_SERVICE(ID,TYPE,VALUE) VALUES (?,?,?)"]];
    }
}

-(void)failuremethod_dropDown_schedulers:(GISJsonRequest *)response
{
    NSLog(@"Failure");
}
-(void)successmethod_getRequestDetails:(GISJsonRequest *)response
{
    NSLog(@"successmethod_getViewSchedule Success---%@",response.responseJson);
    @try {
        if ([response.responseJson isKindOfClass:[NSArray class]])
        {
            
            id array=response.responseJson;
            NSDictionary *dictHere=[array lastObject];
            if ([[dictHere objectForKey:kStatusCode] isEqualToString:@"200"]) {
                [self removeLoadingView];
//                GISEditScheduleStore *store;
//                [[GISStoreManager sharedManager]removeViewSchedule_Objects];
//                store =[[GISEditScheduleStore alloc]initWithStoreDictionary:response.responseJson];
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
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in getRequest Details %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
}

-(void)failuremethod_getRequestDetails:(GISJsonRequest *)response
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

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //®[GISUtility moveemailView:YES viewHeight:-120 view:self.view];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [GISUtility moveemailView:NO viewHeight:0 view:self.view];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
