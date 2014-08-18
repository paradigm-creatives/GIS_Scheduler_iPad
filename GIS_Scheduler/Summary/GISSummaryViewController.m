//
//  GISSummaryViewController.m
//  GIS_Scheduler
//
//  Created by Anand on 18/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISSummaryViewController.h"
#import "GISSummaryCell.h"
#import "GISConstants.h"
#import "GISLoginDetailsObject.h"
#import "GISDatabaseManager.h"
#import "GISDropDownsObject.h"
#import "GISStoreManager.h"
#import "PCLogger.h"

@interface GISSummaryViewController ()

@end

@implementation GISSummaryViewController

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
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 2)
        return [appDelegate.attendeesArray count];
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISSummaryCell *summaryCell;
    if(indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 3) {
        
        summaryCell=(GISSummaryCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return summaryCell.frame.size.height;
    }else if(indexPath.section == 2){
        
        summaryCell=(GISSummaryCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return summaryCell.frame.size.height-50.0;
    }
    
    return summaryCell.frame.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISSummaryCell *cell;
    if(indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3){
        cell=(GISSummaryCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISSummaryCell" owner:self options:nil]objectAtIndex:0];
        }
    }
    if(indexPath.section == 0){
        
        cell.section_label.text =  NSLocalizedStringFromTable(@"contact_billing_info", TABLE, nil);
        
        NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
        NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
        GISLoginDetailsObject *unitObj1=[requetId_array lastObject];
        
        NSMutableArray *chooseReqDetailedArray=[[GISStoreManager sharedManager]getChooseRequestDetailsObjects];
        if (chooseReqDetailedArray.count>0) {
            _chooseRequestDetailsObj=[chooseReqDetailedArray lastObject];
        }
        
        NSString *unitIDorDep_statement = [[NSString alloc]initWithFormat:@"select * from TBL_UNIT_DEPARTMENT ;"];
        NSArray *department_mut_array = [[GISDatabaseManager sharedDataManager] getDropDownArray:unitIDorDep_statement] ;
        
        for (GISDropDownsObject *dropDownObj in department_mut_array) {
            if ([dropDownObj.id_String isEqualToString:_chooseRequestDetailsObj.unitID_String_chooseReqParsedDetails]) {
               // cell.unitacNumber_label .text =  dropDownObj.value_String;
            }
        }
        
        
        cell.unitacNumber_ans_label .text = _chooseRequestDetailsObj.unitID_String_chooseReqParsedDetails;
        cell.firstName_ans_label.text = unitObj1.firstName_string;
        cell.lastName_ans_label.text = unitObj1.lastName_string;
        cell.email_ans_label.text = unitObj1.email_string;
        
    }else if(indexPath.section == 1){
        
        cell.section_label.text =  NSLocalizedStringFromTable(@"event_details", TABLE, nil);
        cell.requestor_label.text =  NSLocalizedStringFromTable(@"event_name", TABLE, nil);
        cell.unitacNumber_label.text =  NSLocalizedStringFromTable(@"event_type", TABLE, nil);
        cell.firstName_label.text =  NSLocalizedStringFromTable(@"open_toPublic", TABLE, nil);
        cell.lastName_label.text =  NSLocalizedStringFromTable(@"course_id", TABLE, nil);
        cell.email_label.text =  NSLocalizedStringFromTable(@"dress_Code", TABLE, nil);
        cell.zip_label.text =  NSLocalizedStringFromTable(@"recorede_braoadcast", TABLE, nil);
        cell.address1_label.text =  NSLocalizedStringFromTable(@"other_technologies", TABLE, nil);
        cell.address2_label.text =  NSLocalizedStringFromTable(@"other_services", TABLE, nil);
        cell.city_label.text =  NSLocalizedStringFromTable(@"description", TABLE, nil);
        cell.state_label.hidden = YES;
        
    }else if(indexPath.section == 2){
    
        GISAttendees_ListObject *attendeesObj;
        @try {
            attendeesObj = [appDelegate.attendeesArray objectAtIndex:indexPath.row];
        }
        @catch (NSException *exception) {
            [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in SummaryView CellForRowAtIndexPath section 3--> %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
        }
        //cell.requestor_label.text = [NSString stringWithFormat:@"%d",(int)indexPath.row +1];
        
        cell.requestor_label.text =  NSLocalizedStringFromTable(@"first_name", TABLE, nil);
        cell.unitacNumber_label.text =  NSLocalizedStringFromTable(@"last_name", TABLE, nil);
        cell.firstName_label.text =  NSLocalizedStringFromTable(@"email", TABLE, nil);
        cell.lastName_label.text =  NSLocalizedStringFromTable(@"mode_of_communication", TABLE, nil);
        cell.email_label.text =  NSLocalizedStringFromTable(@"directly_utilized", TABLE, nil);
        cell.zip_label.text =  NSLocalizedStringFromTable(@"service_Needed", TABLE, nil);
        cell.section_label.text =  NSLocalizedStringFromTable(@"attendees", TABLE, nil);
        
        cell.requestor_ans_label.text = attendeesObj.firstname_String;
        cell.unitacNumber_ans_label.text = attendeesObj.lastname_String;
        cell.firstName_ans_label.text = attendeesObj.email_String;
        cell.lastName_ans_label.text = attendeesObj.modeOf_String;
        cell.email_ans_label.text = attendeesObj.directly_utilzed_String;
        cell.zip_ans_label.text = attendeesObj.servicesNeeded_String;
        cell.address1_label.hidden = YES;
        cell.address2_label.hidden = YES;
        cell.city_label.hidden = YES;
        cell.state_label.hidden = YES;
        
    }else if(indexPath.section == 3){
        
        NSMutableArray *chooseReqDetailedArray=[[GISStoreManager sharedManager]getChooseRequestDetailsObjects];
        if (chooseReqDetailedArray.count>0) {
            _chooseRequestDetailsObj=[chooseReqDetailedArray lastObject];
        }
        
        NSString *buildingName_statement = [[NSString alloc]initWithFormat:@"select * from TBL_BUILDING_NAME  ORDER BY ID DESC;"];
        _buildingNameArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:buildingName_statement];
        
        for (GISDropDownsObject *dropDownObj in _buildingNameArray) {
            if ([dropDownObj.id_String isEqualToString:_chooseRequestDetailsObj.building_Id_String_chooseReqParsedDetails]) {
                _buildingNameString =  dropDownObj.value_String;
            }
        }
        NSString *generalLocation_statement = [[NSString alloc]initWithFormat:@"select * from TBL_GENERAL_LOCATION  ORDER BY ID DESC;"];
        _generalLocationArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:generalLocation_statement];
        
        for (GISDropDownsObject *dropDownObj in _generalLocationArray) {
            if ([dropDownObj.id_String isEqualToString:_chooseRequestDetailsObj.generalLocation_String_chooseReqParsedDetails]) {
                _generalLocationId_string=dropDownObj.id_String;
                _generalLocationValue_string = dropDownObj.value_String;
            }
        }
        
        cell.section_label.text =  NSLocalizedStringFromTable(@"location_Details", TABLE, nil);
        
        if ([_generalLocationId_string isEqualToString:@"1"]) {
            
            cell.requestor_label.text = @"Room Number :";
            cell.unitacNumber_label.text = @"Building Name :";
            cell.firstName_label.text = @"General Location :";
            cell.lastName_label.text = @"Room Name :";
            cell.email_label.text = @"Other :";
            [cell.requestor_label sizeToFit];
            [cell.unitacNumber_label sizeToFit];
            [cell.firstName_label sizeToFit];
            [cell.lastName_label sizeToFit];
            [cell.email_label sizeToFit];
            
            cell.requestor_ans_label.text = _chooseRequestDetailsObj.RoomNunber_String_chooseReqParsedDetails;
            cell.unitacNumber_ans_label.text = _buildingNameString;
            cell.firstName_ans_label.text = _generalLocationValue_string;
            cell.lastName_ans_label.text = _chooseRequestDetailsObj.RoomName_String_chooseReqParsedDetails;
            cell.email_ans_label.text = _chooseRequestDetailsObj.other_String_chooseReqParsedDetails;
            
            cell.address1_label.hidden = YES;
            cell.address2_label.hidden = YES;
            cell.city_label.hidden = YES;
            cell.state_label.hidden = YES;
            cell.zip_label.hidden = YES;
            
            
        }else{
            
     
            
            cell.requestor_label.text = @"Store Location :";
            cell.unitacNumber_label.text = @"General Location :";
            cell.firstName_label.text = @"Address1 :";
            cell.lastName_label.text = @"City :";
            cell.email_label.text = @"State :";
            cell.address1_label.text = @"Zip :";
            
            cell.requestor_ans_label.text = _chooseRequestDetailsObj.offCamp_LocationName_String_chooseReqParsedDetails;
            cell.unitacNumber_ans_label.text = _generalLocationValue_string;
            cell.firstName_ans_label.text = _chooseRequestDetailsObj.offCamp_address1_String_chooseReqParsedDetails;
            cell.lastName_ans_label.text = _chooseRequestDetailsObj.offCamp_city_String_chooseReqParsedDetails;
            cell.email_ans_label.text = _chooseRequestDetailsObj.offCamp_state_String_chooseReqParsedDetails;
            cell.address1_ans_label.text = _chooseRequestDetailsObj.offCamp_zip_String_chooseReqParsedDetails;
            
            cell.address2_label.hidden = YES;
            cell.city_label.hidden = YES;
            cell.state_label.hidden = YES;
            cell.zip_label.hidden = YES;

            
        }

    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
