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
#import "GISSummaryAttendeesCell.h"
#import "GISFonts.h"
#import "GISSummaryDatesAndTimesCell.h"
#import "GISSummaryDatesDetailViewCell.h"
#import "GISDatesAndTimesObject.h"

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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
        
    [_summary_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 2)
        return [appDelegate.attendeesArray count];
    else if(section == 4)
        return [appDelegate.datesArray count];
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISSummaryCell *summaryCell;
    if(indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 3) {
        
        summaryCell=(GISSummaryCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return summaryCell.frame.size.height;
        
    }else if(indexPath.section == 2){
        
        GISSummaryAttendeesCell *attendeesCell=(GISSummaryAttendeesCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return attendeesCell.frame.size.height;
    }else if(indexPath.section == 4){
        
        GISSummaryDatesDetailViewCell *datesDetailCell=(GISSummaryDatesDetailViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return datesDetailCell.frame.size.height;
    }
    
    return summaryCell.frame.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISSummaryCell *cell;
    if(indexPath.section == 0 || indexPath.section == 1  || indexPath.section == 3){
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
        
        NSMutableArray *chooseReqDetailedArray=[[GISStoreManager sharedManager]getChooseRequestDetailsObjects];
        if (chooseReqDetailedArray.count>0) {
            _chooseRequestDetailsObj=[chooseReqDetailedArray lastObject];
        }
        NSString *eventCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_EVENT_TYPE;"];
        NSString *dressCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_DRESS_CODE;"];
        
        _eventTypeArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:eventCode_statement];
        _dresscodeArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:dressCode_statement];
        
        for (GISDropDownsObject *dropDownObj in _eventTypeArray) {
            if ([dropDownObj.id_String isEqualToString:_chooseRequestDetailsObj.eventTypeID_String_chooseReqParsedDetails]) {
                cell.unitacNumber_ans_label.text = dropDownObj.value_String;
            }
        }
        
        for (GISDropDownsObject *dropDownObj in _dresscodeArray) {
            if ([dropDownObj.id_String isEqualToString:_chooseRequestDetailsObj.dressCodeID_String_chooseReqParsedDetails]) {
                cell.email_ans_label.text = dropDownObj.value_String;
            }
        }
        
        
        cell.requestor_ans_label.text = _chooseRequestDetailsObj.eventName_String_chooseReqParsedDetails;
        cell.zip_ans_label.text = _chooseRequestDetailsObj.recBroadcast_String_chooseReqParsedDetails;
        cell.city_ans_label.text = _chooseRequestDetailsObj.eventDescription_String_chooseReqParsedDetails;
        
    }else if(indexPath.section == 2){
        
        GISSummaryAttendeesCell *summarycell=(GISSummaryAttendeesCell *)[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if(summarycell==nil)
        {
            summarycell=[[[NSBundle mainBundle]loadNibNamed:@"GISSummaryAttendeesCell" owner:self options:nil]objectAtIndex:0];
        }

    
        GISAttendees_ListObject *attendeesObj;
        @try {
            attendeesObj = [appDelegate.attendeesArray objectAtIndex:indexPath.row];
        }
        @catch (NSException *exception) {
            [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in SummaryView CellForRowAtIndexPath section 3--> %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
        }
        //cell.requestor_label.text = [NSString stringWithFormat:@"%d",(int)indexPath.row +1];
        
        summarycell.firstName_label.text =  NSLocalizedStringFromTable(@"first_name", TABLE, nil);
        summarycell.lastName_label .text =  NSLocalizedStringFromTable(@"last_name", TABLE, nil);
        summarycell.modeOf_communication_label.text =  NSLocalizedStringFromTable(@"mode_of_communication", TABLE, nil);
        summarycell.directly_utilized_label.text =  NSLocalizedStringFromTable(@"directly_utilized_Services", TABLE, nil);
        summarycell.other_services_label.text =  NSLocalizedStringFromTable(@"service_Needed", TABLE, nil);
        
        summarycell.firstName_ans_label.text = attendeesObj.firstname_String;
        summarycell.lastName_ans_label.text = attendeesObj.lastname_String;
        summarycell.modeOf_communication_ans_label.text = attendeesObj.modeOf_String;
        summarycell.directly_utilized_ans_label.text = attendeesObj.directly_utilzed_String;
        summarycell.other_services_ans_label.text = attendeesObj.servicesNeeded_String;
        
        summarycell.attendee_count_label.text = [NSString stringWithFormat:@"%d" ,indexPath.row];
        
        summarycell.selectionStyle=UITableViewCellSelectionStyleNone;
     
        return summarycell;
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

    }else if(indexPath.section == 4){
        
        GISSummaryDatesDetailViewCell *summaryDatescell=(GISSummaryDatesDetailViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if(summaryDatescell==nil)
        {
            summaryDatescell=[[[NSBundle mainBundle]loadNibNamed:@"GISSummaryDatesDetailViewCell" owner:self options:nil]objectAtIndex:0];
        }
        
        
        GISDatesAndTimesObject *datesAndTimesObj;
        @try {
            datesAndTimesObj = [appDelegate.datesArray objectAtIndex:indexPath.row];
        }
        @catch (NSException *exception) {
            [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in SummaryView CellForRowAtIndexPath section 3--> %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
        }
        //cell.requestor_label.text = [NSString stringWithFormat:@"%d",(int)indexPath.row +1];
        
//        summarycell.firstName_label.text =  NSLocalizedStringFromTable(@"first_name", TABLE, nil);
//        summarycell.lastName_label .text =  NSLocalizedStringFromTable(@"last_name", TABLE, nil);
//        summarycell.modeOf_communication_label.text =  NSLocalizedStringFromTable(@"mode_of_communication", TABLE, nil);
//        summarycell.directly_utilized_label.text =  NSLocalizedStringFromTable(@"directly_utilized_Services", TABLE, nil);
//        summarycell.other_services_label.text =  NSLocalizedStringFromTable(@"service_Needed", TABLE, nil);
//        
        summaryDatescell.date_label.text = datesAndTimesObj.date_String;
        summaryDatescell.day_label.text = datesAndTimesObj.day_String;
        summaryDatescell.startTime_label.text = datesAndTimesObj.startTime_String;
        summaryDatescell.endTime_label.text = datesAndTimesObj.endTime_String;
        
        summaryDatescell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return summaryDatescell;

    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    UILabel* headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(8, 0, 320, 20);
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = UIColorFromRGB(0x00457c);
    headerLabel.font = [GISFonts large];
    [headerLabel setTextAlignment:NSTextAlignmentLeft];
    headerLabel.text = NSLocalizedStringFromTable(@"attendees", TABLE, nil);
    [headerView addSubview:headerLabel];
    
    UIView *leftLine_view=[[UIView alloc]init];
    
    leftLine_view.backgroundColor=UIColorFromRGB(0xDEDEDE);
    
    headerLabel.textColor = UIColorFromRGB(0x00457c);
    leftLine_view.frame=CGRectMake(8, headerLabel.frame.size.height+headerLabel.frame.origin.y+10, 693, 2);
    [headerView addSubview:leftLine_view];
    
    
    UIButton *infoButton = [[UIButton alloc] init];
    infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoButton setBackgroundImage:[UIImage imageNamed:@"summary_edit.png"] forState:UIControlStateNormal];
    infoButton.frame = CGRectMake(678, 0.0, 17.0, 17.0);
    
    [headerView addSubview:infoButton];

    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 2)
        return 35;
    
    return 0;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
