//
//  GISEventDetailsViewController.m
//  GIS_Scheduler
//
//  Created by Anand on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISEventDetailsViewController.h"
#import "GISEventDetailsCell.h"
#import "GISPreparationMaterialCell.h"
#import "GISDatabaseManager.h"
#import "GISUtility.h"
#import "GISConstants.h"
#import "GISFonts.h"
#import "GISNetworkUtility.h"
#import "GISLoginDetailsObject.h"
#import "GISJSONProperties.h"
#import "GISStoreManager.h"
#import "GISServerManager.h"
#import "PCLogger.h"
#import "GISJsonRequest.h"
#import "GISAttendeesViewController.h"
#import "GISLoadingView.h"

#define RECORDED_TYPE 9632
#define REENTER_TYPE 7632

@interface GISEventDetailsViewController ()

@end

@implementation GISEventDetailsViewController

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
    
    self.navigationItem.backBarButtonItem=nil;
    
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];

    [_eventDetaislTabelView setContentSize:CGSizeMake(1024, 880)];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    _eventdetails_unitIdStr = [userDefaults valueForKey:kunitid];
    
    
    NSString *eventCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_EVENT_TYPE;"];
    NSString *dressCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_DRESS_CODE;"];
    
    _eventTypeArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:eventCode_statement];
    _dresscodeArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:dressCode_statement];
    
    _otherServicesArray = [[NSArray alloc] initWithObjects:@"Captioning",@"VRI", nil];
    _viewingTypeArray = [[NSArray alloc] initWithObjects:@"Individuals", nil];
    _captionTypeArray = [[NSArray alloc] initWithObjects:@"Onsite", nil];
    
    eventTypedata = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    dresscodeData = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    otherServicesdata = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    captionData = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    viewingTypeData = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    
    otherTechStr = [[NSMutableArray alloc] init];
    _othertechvalueStr = [[NSMutableString alloc] init];
    _fields = [[NSMutableString alloc] init];
    
    _open_toPublicStr = @"";
     _outsideAgencyStr = @"";
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedChooseRequestNumber:) name:kselectedChooseReqNumber object:nil];
    
    if(appDelegate.isFromContacts && !appDelegate.isNewRequest){
        
        [self getEventDetailsdata];
        
    }else if(appDelegate.isFromContacts  && appDelegate.isNewRequest){
        
        UITextField *eventNameTextField=(UITextField *)[self.view viewWithTag:100];
        UITextView *descriptionTextView=(UITextView *)[self.view viewWithTag:102];
        
        if([eventNameTextField.text length] == 0 || [descriptionTextView.text length] == 0 || [_open_toPublicStr length] == 0 || [_dressCode_Id_string length] == 0 || [_eventTypeId_string length] == 0 || [_re_broadcastStr length] == 0 || [_on_goingStr length] == 0 || [_outsideAgencyStr length] == 0){
            _open_toPublicStr = @"";
            _dressCode_Id_string = @"";
            _eventTypeId_string = @"";
            _re_broadcastStr= @"";
            _on_goingStr = @"";
            _outsideAgencyStr = @"";
            
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISEventDetailsCell *eventCell;
    if(indexPath.section == 0){
        
        eventCell=(GISEventDetailsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return eventCell.frame.size.height;
    }
    if(indexPath.section == 1){
        
      GISPreparationMaterialCell * preparationMaterialCell=(GISPreparationMaterialCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return preparationMaterialCell.frame.size.height;

    }
    
    return eventCell.frame.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISEventDetailsCell *cell;
    if(indexPath.section == 0){
        cell=(GISEventDetailsCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISEventDetailsCell" owner:self options:nil]objectAtIndex:0];
        }
        
        [cell.opentoPublicbtn1 addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.opentoPublicbtn2 addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.recorded1 addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.recorded2 addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.onGoing1 addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.ongoing2 addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.fmSystembtn addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.microPhonebtn addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.phnConferencebtn addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.webinarbtn addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.eventTypebtn addTarget:self action:@selector(showPopoverDetails:) forControlEvents:UIControlEventTouchUpInside];
        [cell.dressCodebtn addTarget:self action:@selector(showPopoverDetails:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.eventTypebtn setTitle:eventTypedata forState:UIControlStateNormal];
        [cell.dressCodebtn setTitle:dresscodeData forState:UIControlStateNormal];
        [cell.eventName_textField setDelegate:self];
        [cell.course_textField setDelegate:self];
        
        cell.eventName_textField.text = evevntNamedata;
        cell.course_textField.text = courseIdData;
        
        [cell.eventTypebtn setTag:1];
        [cell.dressCodebtn setTag:2];
        
        [cell.opentoPublicbtn1 setTag:3];
        [cell.opentoPublicbtn2 setTag:4];
        [cell.recorded1 setTag:5];
        [cell.recorded2 setTag:6];
        [cell.onGoing1 setTag:7];
        [cell.ongoing2 setTag:8];
        [cell.fmSystembtn setTag:9];
        [cell.microPhonebtn setTag:10];
        [cell.phnConferencebtn setTag:11];
        [cell.webinarbtn setTag:12];
        [cell.broadcastYesSelcted  setTag:555];
        
        if([_open_toPublicStr isEqualToString:@"true"]){
            
            [cell.opentoPublicbtn1 setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }else if([_open_toPublicStr isEqualToString:@"false"]){
            [cell.opentoPublicbtn2 setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
        
        
        if([_re_broadcastStr isEqualToString:@"true"]){
            cell.broadcastYesSelcted.text = _broadcastType_Str;
            [cell.recorded1 setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }else if([_re_broadcastStr isEqualToString:@"false"]){
             cell.broadcastYesSelcted.text = @"";
             [cell.recorded2 setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
        
        if([_on_goingStr isEqualToString:@"true"]){
            
            [cell.onGoing1 setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }else if([_on_goingStr isEqualToString:@"false"]){
            [cell.ongoing2 setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
        
        if([otherTechStr count] >0){
            _otherTechArray = [[NSArray alloc] initWithArray:otherTechStr];
            
            
            for(int i=0 ;i<[_otherTechArray count];i++)
            {
                NSString *value = [_otherTechArray objectAtIndex:i];
                switch ([value intValue]) {
                    case 1:
                        [cell.fmSystembtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        break;
                    case 2:
                        [cell.microPhonebtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        break;
                    case 3:
                        [cell.phnConferencebtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        break;
                    case 4:
                        [cell.webinarbtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        break;
                    default:
                        break;
                }
            }
        }

    }
    
    if(indexPath.section == 1){
       GISPreparationMaterialCell *cell=(GISPreparationMaterialCell *)[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if(cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISPreparationMaterialCell" owner:self options:nil]objectAtIndex:0];
        }
        
        [cell.otherServicesbtn addTarget:self action:@selector(showPopoverDetails:) forControlEvents:UIControlEventTouchUpInside];
        [cell.captionTypebtn addTarget:self action:@selector(showPopoverDetails:) forControlEvents:UIControlEventTouchUpInside];
        [cell.viewingTypebtn addTarget:self action:@selector(showPopoverDetails:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.documentbtn addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.blackboardAccessbtn addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.websitebtn addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.othersbtn addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];

        
        [cell.otherServicesbtn setTitle:otherServicesdata forState:UIControlStateNormal];
        [cell.captionTypebtn setTitle:captionData forState:UIControlStateNormal];
        [cell.viewingTypebtn setTitle:viewingTypeData forState:UIControlStateNormal];
        
        [cell.documentbtn setTag:44];
        [cell.blackboardAccessbtn setTag:111];
        [cell.websitebtn setTag:22];
        [cell.othersbtn setTag:33];
        
        [cell.otherServicesbtn setTag:13];
        [cell.captionTypebtn setTag:14];
        [cell.viewingTypebtn setTag:15];
        
        [cell.descriptionTextView setDelegate:self];
        
        [cell.noOfUsersTextField setTag:666];
        [cell.noOfUsersTextField setDelegate:self];
        
        [cell.nextButton addTarget:self action:@selector(nextButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        
        return cell;
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    
    return cell;
}


- (IBAction)previousVersionBtnTap:(id)sender{
    
    int item_value;

    
    UIButton *btn=(UIButton*)sender;
    
    NSIndexPath *indexPath = [_eventDetaislTabelView indexPathForCell:(UITableViewCell *)[[[btn superview] superview] superview]];
    
    GISPreparationMaterialCell *preparationCell = (GISPreparationMaterialCell *)[_eventDetaislTabelView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
    
    if(btn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
        UILabel *broadcastSelectedLabel=(UILabel *)[self.view viewWithTag:555];

        
        if(btn.tag == 111){
            
            [preparationCell.blackboardAccessTextField setHidden:TRUE];
        }else if(btn.tag == 22){
            [preparationCell.websiteTextField setHidden:TRUE];
            
        }else if(btn.tag == 33){
            [preparationCell.othersTextField setHidden:TRUE];
        }
        
        if(btn.tag == 3){
            _open_toPublicStr = @" ";
        }else if(btn.tag == 4){
            _open_toPublicStr = @" ";
        }else if(btn.tag == 5){
            _re_broadcastStr = @" ";
            broadCastSelected = NO;
            [broadcastSelectedLabel setText:@""];
        }else if(btn.tag == 6){
            _re_broadcastStr = @" ";
            broadCastSelected = NO;
            [broadcastSelectedLabel setText:@""];
        }else if(btn.tag == 7){
            _on_goingStr = @" ";
        }else if(btn.tag == 8){
            _on_goingStr = @" ";
        }else if(btn.tag == 9){
            item_value = 1;
            if([otherTechStr count]>0)
            {
                [otherTechStr removeObject:[NSString stringWithFormat:@"%d",item_value]];
                
            }
        }else if(btn.tag == 10){
            item_value = 2;
            if([otherTechStr count]>0)
            {
                [otherTechStr removeObject:[NSString stringWithFormat:@"%d",item_value]];
                
            }
        }else if(btn.tag == 11){
            item_value = 3;
            if([otherTechStr count]>0)
            {
                [otherTechStr removeObject:[NSString stringWithFormat:@"%d",item_value]];
                
            }
        }else if(btn.tag == 12){
            item_value = 4;
            if([otherTechStr count]>0)
            {
                [otherTechStr removeObject:[NSString stringWithFormat:@"%d",item_value]];
                
            }
        }
        
        NSLog(@"other tech string valuee ----------- %@",otherTechStr);


        
    }
    else
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];

        if(btn.tag == 111){
            
            [preparationCell.blackboardAccessTextField setHidden:FALSE];
        }else if(btn.tag == 22){
            [preparationCell.websiteTextField setHidden:FALSE];
            
        }else if(btn.tag == 33){
            [preparationCell.othersTextField setHidden:FALSE];
        }
        else if(btn.tag == 3){
            _open_toPublicStr = @"true";
            UIButton *btnn=(UIButton *)[self.view viewWithTag:4];
            if(btnn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
            {
                [btnn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            }
            
        }else if(btn.tag == 4){
            _open_toPublicStr = @"false";
            UIButton *btnn=(UIButton *)[self.view viewWithTag:3];
            if(btnn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
            {
                [btnn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            }
        }else if(btn.tag == 5){
            _re_broadcastStr = @"true";
            UIButton *btnn=(UIButton *)[self.view viewWithTag:6];
            if(btnn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
            {
                [btnn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            }
            [self showBroadcastAlertView];
            
        }else if(btn.tag == 6){
            _re_broadcastStr = @"false";
            UIButton *btnn=(UIButton *)[self.view viewWithTag:5];
            if(btnn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
            {
                [btnn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            }
            
            UILabel *broadcastSelectedLabel=(UILabel *)[self.view viewWithTag:555];
            [broadcastSelectedLabel setText:@""];
            
            broadCastSelected = NO;
            
        }else if(btn.tag == 7){
            _on_goingStr = @"true";
            UIButton *btnn=(UIButton *)[self.view viewWithTag:8];
            if(btnn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
            {
                [btnn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            }
            
        }else if(btn.tag == 8){
            _on_goingStr = @"false";
            UIButton *btnn=(UIButton *)[self.view viewWithTag:7];
            if(btnn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
            {
                [btnn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            }
        }else if(btn.tag == 9){
            item_value = 1;
            [otherTechStr addObject:[NSString stringWithFormat:@"%d",item_value]];
        }else if(btn.tag == 10){
            item_value = 2;
            [otherTechStr addObject:[NSString stringWithFormat:@"%d",item_value]];
        }else if(btn.tag == 11){
            item_value = 3;
            [otherTechStr addObject:[NSString stringWithFormat:@"%d",item_value]];
        }else if(btn.tag == 12){
            item_value = 4;
            [otherTechStr addObject:[NSString stringWithFormat:@"%d",item_value]];
        }
    }
}

- (IBAction)showPopoverDetails:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    
    btn_tag = btn.tag;
    
    GISPopOverTableViewController *tableViewController = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    
    tableViewController.popOverDelegate = self;
    if(btn.tag == 1){
        _popover =   [GISUtility showPopOver:(NSMutableArray *)_eventTypeArray viewController:tableViewController];
    }else if(btn.tag == 2){
        _popover =   [GISUtility showPopOver:(NSMutableArray *)_dresscodeArray viewController:tableViewController];
    }else if(btn.tag == 13){
        _popover =   [GISUtility showPopOver:(NSMutableArray *)_otherServicesArray viewController:tableViewController];
        _popover.popoverContentSize = CGSizeMake(300, 80);
    }else if(btn.tag == 14){
        _popover =   [GISUtility showPopOver:(NSMutableArray *)_captionTypeArray viewController:tableViewController];
        _popover.popoverContentSize = CGSizeMake(300, 80);
    }else if(btn.tag == 15){
        _popover =   [GISUtility showPopOver:(NSMutableArray *)_viewingTypeArray viewController:tableViewController];
        _popover.popoverContentSize = CGSizeMake(300, 80);
    }
    
    _popover.delegate = self;

    
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }
    
    [_popover presentPopoverFromRect:CGRectMake(btn.frame.origin.x+btn.frame.size.width-15, btn.frame.origin.y+15, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown animated:YES];

}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    if(btn_tag == 1){
        eventTypedata= value_str;
        UIButton *eventTypeBtn=(UIButton *)[self.view viewWithTag:1];
        [eventTypeBtn setTitle:eventTypedata forState:UIControlStateNormal];
        _eventTypeId_string=id_str;
       
    }else if(btn_tag == 2){
        dresscodeData = value_str;
        UIButton *dressCodeBtn=(UIButton *)[self.view viewWithTag:2];
        [dressCodeBtn setTitle:dresscodeData forState:UIControlStateNormal];
        _dressCode_Id_string=id_str;
    }else if(btn_tag == 13){
        otherServicesdata = value_str;
        UIButton *otherServicesBtn=(UIButton *)[self.view viewWithTag:13];
        [otherServicesBtn setTitle:otherServicesdata forState:UIControlStateNormal];
        if([otherServicesdata isEqualToString:@"VRI"]){
            _otherServices_Str = @"2";
        }else{
            _otherServices_Str = @"1";
        }
        
    }else if(btn_tag == 14){
        captionData = value_str;
        UIButton *captionBtn=(UIButton *)[self.view viewWithTag:14];
        [captionBtn setTitle:captionData forState:UIControlStateNormal];
    }else if(btn_tag == 15){
        viewingTypeData = value_str;
        UIButton *viewTypeBtn=(UIButton *)[self.view viewWithTag:15];
        [viewTypeBtn setTitle:viewingTypeData forState:UIControlStateNormal];
    }
    
    if(_popover)
        [_popover dismissPopoverAnimated:YES];
    
   // [_eventDetaislTabelView reloadData];
    
}

- (void)showBroadcastAlertView{
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"type Of Record Broadcast?:", TABLE, nil) message:@"" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    _alertCustomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 210, 110)];
    
    UIButton *addButton = [[UIButton alloc] init];
    addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
    [addButton addTarget:self
                  action:@selector(previousVersionBtnTap:)
        forControlEvents:UIControlEventTouchUpInside];
    addButton.frame = CGRectMake(70.0, 5.0, 28.0, 28.0);
    addButton.tag = 16;
    [_alertCustomView addSubview:addButton];
    
    UILabel* headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(addButton.frame.origin.x+5, 10, 80, 15);
    headerLabel.textColor = UIColorFromRGB(0x666666);
    headerLabel.font = [GISFonts normal];
    headerLabel.text=@"Audio";
    [headerLabel setTextAlignment:NSTextAlignmentCenter];
    [_alertCustomView addSubview:headerLabel];
    
    UIButton *addButton1 = [[UIButton alloc] init];
    addButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton1 setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
    [addButton1 addTarget:self
                   action:@selector(previousVersionBtnTap:)
         forControlEvents:UIControlEventTouchUpInside];
    addButton1.frame = CGRectMake(70.0, 40.0, 28.0, 28.0);
    addButton1.tag = 17;
    [_alertCustomView addSubview:addButton1];
    
    UILabel* headerLabel1 = [[UILabel alloc] init];
    headerLabel1.frame = CGRectMake(addButton1.frame.origin.x+5, 45, 80, 15);
    headerLabel1.textColor = UIColorFromRGB(0x666666);
    headerLabel1.font = [GISFonts normal];
    headerLabel1.text=@"Video";
    [headerLabel1 setTextAlignment:NSTextAlignmentCenter];
    [_alertCustomView addSubview:headerLabel1];
    
    UIButton *addButton2 = [[UIButton alloc] init];
    addButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton2 setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
    [addButton2 addTarget:self
                   action:@selector(previousVersionBtnTap:)
         forControlEvents:UIControlEventTouchUpInside];
    addButton2.frame = CGRectMake(70.0, 75.0, 28.0, 28.0);
    addButton2.tag = 18;
    [_alertCustomView addSubview:addButton2];
    
    UILabel* headerLabel2 = [[UILabel alloc] init];
    headerLabel2.frame = CGRectMake(addButton2.frame.origin.x+5, 80, 80, 15);
    headerLabel2.textColor = UIColorFromRGB(0x666666);
    headerLabel2.font = [GISFonts normal];
    headerLabel2.text=@"Both";
    [headerLabel2 setTextAlignment:NSTextAlignmentCenter];
    [_alertCustomView addSubview:headerLabel2];
    
    [av setValue:_alertCustomView forKey:@"accessoryView"];
    av.delegate = self;
    av.tag = RECORDED_TYPE;
    [av show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == RECORDED_TYPE && buttonIndex == 1)
    {
        UIButton *btnn=(UIButton *)[_alertCustomView viewWithTag:16];
        UIButton *btnn1=(UIButton *)[_alertCustomView viewWithTag:17];
        UIButton *btnn2=(UIButton *)[_alertCustomView viewWithTag:18];
        
        broadCastSelected = YES;
        UILabel *broadcastSelectedLabel=(UILabel *)[self.view viewWithTag:555];
        
        if(btnn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
        {
            _broadcastType_Str = @"Audio";
            
        }else if(btnn1.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
        {
            _broadcastType_Str = @"Video";
            
        }else if(btnn2.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
        {
            _broadcastType_Str = @"Both";
        }else{
            
            broadCastSelected = NO;
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) message:NSLocalizedStringFromTable(@"please select one option", TABLE, nil) delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
            alert.tag = REENTER_TYPE;
            alert.delegate = self;
            [alert show];
        }
        
        [broadcastSelectedLabel setText:_broadcastType_Str];

        
    }else if(alertView.tag == RECORDED_TYPE && buttonIndex == 0)
    {
        broadCastSelected = NO;
    }else if(alertView.tag == 20 && buttonIndex == 1)
    {
        _blackboard_accessStr = [alertView textFieldAtIndex:0].text;
    }else if(alertView.tag == 21 && buttonIndex == 1)
    {
        _websiteStr = [alertView textFieldAtIndex:0].text;
    }else if(alertView.tag == 22 && buttonIndex == 1){
        
        _other_Str = [alertView textFieldAtIndex:0].text;
    }else if(alertView.tag == REENTER_TYPE && buttonIndex == 0){
        
        [self showBroadcastAlertView];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"textViewShouldBeginEditing:");
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"textViewDidBeginEditing:");
    NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"-120",@"yValue",nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:kMoveUp object:nil userInfo:infoDict];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSLog(@"textViewShouldEndEditing:");
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"textViewDidEndEditing:");
    NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"yValue",nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:kMoveUp object:nil userInfo:infoDict];
    
    [textView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    
    if (textView.text.length + text.length > 140){
        if (location != NSNotFound){
            [textView resignFirstResponder];
        }
        return NO;
    }
    else if (location != NSNotFound){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    // Get the cell in which the textfield is embedded
    if(textField.tag == 666){
        NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"-290",@"yValue",nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:kMoveUp object:nil userInfo:infoDict];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    // Get the cell in which the textfield is embedded
    if(textField.tag == 666){
        NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"yValue",nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:kMoveUp object:nil userInfo:infoDict];
    }
    
    if(textField.tag == 100)
        evevntNamedata = textField.text;
    if(textField.tag == 101)
        courseIdData = textField.text;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)nextButtonClicked:(id)sender{
    
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    
    if([appDelegate.chooseRequest_ID_String length]>0 && ![appDelegate.chooseRequest_ID_String isEqualToString:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil)]){
        [self saveEventDetailsData];
    }else{
        
        [self removeLoadingView];
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"select_choose_request", TABLE, nil)];
    }
    
}

-(void)saveEventDetailsData
{
    @try {
        
        if ([[GISNetworkUtility sharedManager] checkNetworkAvailability])
        {
            
            NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
            NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
            NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
            GISLoginDetailsObject *login_Obj=[requetId_array lastObject];
            
            UITextField *eventNameTextField=(UITextField *)[self.view viewWithTag:100];
            UITextField *courseTextField=(UITextField *)[self.view viewWithTag:101];
            UITextView *descriptionTextView=(UITextView *)[self.view viewWithTag:102];
            UIButton *viewingTypebtn=(UIButton *)[self.view viewWithTag:15];
            UIButton *captioningTypebtn=(UIButton *)[self.view viewWithTag:14];
            UITextField *ofUserstextField=(UITextField *)[self.view viewWithTag:666];
            
            
            if([eventNameTextField.text length] == 0 || [descriptionTextView.text length] == 0 || [_open_toPublicStr length] == 0 || [_dressCode_Id_string length] == 0 || [_eventTypeId_string length] == 0 || [_re_broadcastStr length] == 0)
            {
                if([_fields length]>0)
                    [_fields setString:@""];
                
                if([eventNameTextField.text length] == 0)
                    [_fields appendFormat:@"%@%@",@"EventName",@", \n"];
                if([descriptionTextView.text length] == 0)
                    [_fields appendFormat:@"%@%@",@"EventDescription",@", \n"];
                if([_open_toPublicStr length] == 0)
                    [_fields appendFormat:@"%@%@",@"OpenToPublic",@", \n"];
                if([_dressCode_Id_string length] == 0)
                    [_fields appendFormat:@"%@%@",@"Dresscode",@", \n"];
                if([_eventTypeId_string length] == 0)
                    [_fields appendFormat:@"%@%@",@"EventType",@", \n"];
                if([_re_broadcastStr length] == 0)
                    [_fields appendFormat:@"%@%@",@"Recorded/Broadcast",@","];
                
                if([login_Obj.userStatus_string isEqualToString:kInternal]){
                    if([_outsideAgencyStr length] == 0)
                        [_fields appendFormat:@"%@",@"Outside Agency"];
                }
                
                [self removeLoadingView];
                [GISUtility showAlertWithTitle:@"" andMessage:[NSString stringWithFormat:NSLocalizedStringFromTable(@"enter_valid_details",TABLE, nil),_fields]];
                return;
            }
            
            [_othertechvalueStr setString:@""];
            for(int i=0; i <[otherTechStr count];i++){
                //othertechvalueStr = [[otherTechStr objectAtIndex:i] componentsJoinedByString:@","];
                [_othertechvalueStr appendFormat:@"%@%@",[otherTechStr objectAtIndex:i],@","];
            }
            NSRange range = [_othertechvalueStr rangeOfString:@"," options:NSBackwardsSearch];
            if (range.location == NSNotFound) {
            } else {
                [_othertechvalueStr setString:[_othertechvalueStr substringToIndex:range.location]];
            }
            _eventdetails_viewOptions=viewingTypebtn.titleLabel.text;
            
            NSMutableArray *chooseReqDetailedArray=[[GISStoreManager sharedManager]getChooseRequestDetailsObjects];
            if (chooseReqDetailedArray.count>0) {
                chooseRequest_Detailed_DetailsObj=[chooseReqDetailedArray lastObject];
            }
            
            if([_eventdetails_statusStr length]== 0)
                _eventdetails_statusStr = @"6";
            
            
            NSLog(@"otherTech str --------- %@",_othertechvalueStr);
            
            
            [paramsDict setObject:appDelegate.chooseRequest_ID_String forKey:keventDetails_requestNo];
            [paramsDict setObject:login_Obj.requestorID_string forKey:keventDetails_requestID];
            [paramsDict setObject:_eventdetails_unitIdStr forKey:keventDetails_unitId];
            [paramsDict setObject:eventNameTextField.text forKey:keventDetails_eventName];
            [paramsDict setObject:_eventTypeId_string forKey:keventDetails_eventId];
            [paramsDict setObject:_open_toPublicStr forKey:keventDetails_eventPublic];
            [paramsDict setObject:_eventdetails_statusStr forKey:keventDetails_statusId];
            [paramsDict setObject:_dressCode_Id_string forKey:keventDetails_dresscodeId];
            [paramsDict setObject:_re_broadcastStr forKey:keventDetails_broadcast];
            [paramsDict setObject:_on_goingStr forKey:keventDetails_onGoing];
            [paramsDict setObject:_othertechvalueStr forKey:keventDetails_Othertech];
            [paramsDict setObject:courseTextField.text forKey:keventDetails_CourseId];
            [paramsDict setObject:descriptionTextView.text forKey:keventDetails_eventDesc];
            [paramsDict setObject:_outsideAgencyStr forKey:keventDetails_OutsideAgency];
            [paramsDict setObject:login_Obj.token_string forKey:keventDetails_token];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.reqLocation_Id_chooseReqParsedDetails] forKey:kChooseReqDetails_reqlocationid];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.generalLocation_String_chooseReqParsedDetails] forKey:kChooseReqDetails_generallocationid];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.building_Id_String_chooseReqParsedDetails] forKey:kChooseReqDetails_buildingid];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.RoomNunber_String_chooseReqParsedDetails] forKey:kChooseReqDetails_roomnunber];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.RoomName_String_chooseReqParsedDetails] forKey:kChooseReqDetails_roomname];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.other_String_chooseReqParsedDetails] forKey:kChooseReqDetails_other];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.offCamp_LocationName_String_chooseReqParsedDetails] forKey:kChooseReqDetails_offcamplocname];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.offCamp_address1_String_chooseReqParsedDetails] forKey:kChooseReqDetails_offcampaddress1];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.offCamp_address2_String_chooseReqParsedDetails] forKey:kChooseReqDetails_offcampaddress2];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.offCamp_state_String_chooseReqParsedDetails] forKey:kChooseReqDetails_offcampstate];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.offCamp_city_String_chooseReqParsedDetails] forKey:kChooseReqDetails_offcampcity];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.offCamp_zip_String_chooseReqParsedDetails] forKey:kChooseReqDetails_offcampzip];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.ClosestMetro_String_chooseReqParsedDetails] forKey:kChooseReqDetails_closestmetro];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.parking_String_chooseReqParsedDetails] forKey:kChooseReqDetails_parking];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.SpecialProtocol_String_chooseReqParsedDetails] forKey:kChooseReqDetails_specialprotocol];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.otherInfo_String_chooseReqParsedDetails] forKey:kChooseReqDetails_other_info];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.offLoc_ID_String_chooseReqParsedDetails] forKey:kChooseReqDetails_OffCampLocID];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.transportation_String_chooseReqParsedDetails] forKey:kChooseReqDetails_Transport];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.transportationYes_String_chooseReqParsedDetails] forKey:kChooseReqDetails_transportnotes];
            
            if([_otherServices_Str length]>0){
                [paramsDict setObject:_otherServices_Str forKey:keventDetails_otherServices];
                if(![_otherServices_Str isEqualToString:@"2"]){
                    
                    NSString *captionTypeStr = captioningTypebtn.titleLabel.text;
                    if([captionTypeStr length]>0)
                        [paramsDict setObject:captionTypeStr forKey:keventDetails_captiontype];
                    else
                        [paramsDict setObject:@"" forKey:keventDetails_captiontype];
                }
            }
            else{
                [paramsDict setObject:@"" forKey:keventDetails_otherServices];
                [paramsDict setObject:@"" forKey:keventDetails_captiontype];
            }
            if([_eventdetails_viewOptions length]>0){
                [paramsDict setObject:_eventdetails_viewOptions forKey:keventDetails_captionView];
            }
            else{
                [paramsDict setObject:@"" forKey:keventDetails_captionView];
            }
            
            
            [paramsDict setObject:ofUserstextField.text forKey:keventDetails_capnoofUsers];
            if([_broadcastType_Str length]>0)
                [paramsDict setObject:_broadcastType_Str forKey:keventDetails_recordBroadcastYes];
            else
                [paramsDict setObject:@"" forKey:keventDetails_recordBroadcastYes];
            
            if([_otherServices_Str length] > 0)
            {
                if([_otherServices_Str isEqualToString:@"2"]){
                    if([viewingTypebtn.titleLabel.text length] == 0 || [ofUserstextField.text length] == 0)
                    {
                        if([_fields length]>0)
                            [_fields setString:@""];
                        if([viewingTypebtn.titleLabel.text length] == 0)
                            [_fields appendFormat:@"%@%@",@"Viewing Type",@", \n"];
                        if([ofUserstextField.text length] == 0)
                            [_fields appendFormat:@"%@%@",@"No Of Users",@", \n"];
                        
                        [self removeLoadingView];
                        [GISUtility showAlertWithTitle:@"" andMessage:[NSString stringWithFormat:NSLocalizedStringFromTable(@"enter_valid_details",TABLE, nil),_fields]];
                    }else{
                        [[GISServerManager sharedManager] saveEventDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_eventDetailsRequest:) failAction:@selector(failuremethod_eventDetailsRequest:)];
                    }
                }else if([_otherServices_Str isEqualToString:@"1"]){
                    if([captioningTypebtn.titleLabel.text length] == 0 || [viewingTypebtn.titleLabel.text length] == 0 || [ofUserstextField.text length] == 0)
                    {
                        if([_fields length]>0)
                            [_fields setString:@""];
                        
                        if([viewingTypebtn.titleLabel.text length] == 0)
                            [_fields appendFormat:@"%@%@",@"Viewing Type",@", \n"];
                        if([ofUserstextField.text length] == 0)
                            [_fields appendFormat:@"%@%@",@"No Of Users",@", \n"];
                        if([captioningTypebtn.titleLabel.text length] == 0)
                            [_fields appendFormat:@"%@%@",@"Captioning Type",@","];
                        
                        [self removeLoadingView];
                        [GISUtility showAlertWithTitle:@"" andMessage:[NSString stringWithFormat:NSLocalizedStringFromTable(@"enter_valid_details",TABLE, nil),_fields]];
                    }else{
                        [[GISServerManager sharedManager] saveEventDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_eventDetailsRequest:) failAction:@selector(failuremethod_eventDetailsRequest:)];
                    }
                }
                
            }else{
                
                [[GISServerManager sharedManager] saveEventDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_eventDetailsRequest:) failAction:@selector(failuremethod_eventDetailsRequest:)];
            }
        }else{
            
            [self removeLoadingView];
            [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"network_connection",TABLE, nil)];
        }
    }
    @catch (NSException *exception)
    {
        [self removeLoadingView];
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in Event Details action %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
}


-(void)successmethod_eventDetailsRequest:(GISJsonRequest *)response
{
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    NSLog(@"successmethod_saveUpdateRequest Success---%@",saveUpdateDict);
    
    GISAttendeesViewController *attendeesViewController;
    
    if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"200"]) {
        
        attendeesViewController =[[GISAttendeesViewController alloc]initWithNibName:@"GISAttendeesViewController" bundle:nil];
        
        [self removeLoadingView];
        
         NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"2",@"tabValue",nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:kTabSelected object:nil userInfo:infoDict];
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults setValue:appDelegate.chooseRequest_ID_String forKey:kDropDownValue];
  
      
    }else{
        
        [self removeLoadingView];
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
    }
    
    
    
}
-(void)failuremethod_eventDetailsRequest:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
}


-(NSString *)returningstring:(id)string
{
    if ([string length] == 0)
    {
        return @"";
    }
    else
    {
        if (![string isKindOfClass:[NSString class]])
        {
            NSString *str= [string stringValue];
            return str;
        }
        else
        {
            return string;
        }
    }
    
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

-(void)selectedChooseRequestNumber:(NSNotification*)notification
{
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    
    GISLoginDetailsObject *unitObj1=[requetId_array lastObject];
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    [paramsDict setObject:appDelegate.chooseRequest_ID_String forKey:kID];
    [paramsDict setObject:unitObj1.token_string forKey:kToken];
    
    [[GISServerManager sharedManager] getEventDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_getRequestDetails:) failAction:@selector(failuremethod_getRequestDetails:)];

}
-(void)successmethod_getRequestDetails:(GISJsonRequest *)response
{
    NSLog(@"successmethod_getRequestDetails Success---%@",response.responseJson);
    [[GISStoreManager sharedManager] removeChooseRequestDetailsObjects];
    chooseRequest_Detailed_DetailsObj=[[GISChooseRequestDetailsObject alloc]initWithStoreChooseRequestDetailsDictionary:response.responseJson];
    [[GISStoreManager sharedManager]addChooseRequestDetailsObject:chooseRequest_Detailed_DetailsObj];
    
    appDelegate.createdDateString = chooseRequest_Detailed_DetailsObj.createdDate_String_chooseReqParsedDetails;
    appDelegate.createdByString = chooseRequest_Detailed_DetailsObj.reqFirstName_String_chooseReqParsedDetails;
    appDelegate.statusString = chooseRequest_Detailed_DetailsObj.requestStatus_String_chooseReqParsedDetails;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kRequestInfo object:nil];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setValue:chooseRequest_Detailed_DetailsObj.unitID_String_chooseReqParsedDetails forKey:kunitid];
    [self getEventDetailsdata];
}

-(void)failuremethod_getRequestDetails:(GISJsonRequest *)response
{
    NSLog(@"Failure");
}


-(void)getEventDetailsdata
{
    
    UIButton *eventTypeBtn=(UIButton *)[self.view viewWithTag:1];
    UIButton *dressCodeBtn=(UIButton *)[self.view viewWithTag:2];
    UIButton *openPublic1=(UIButton *)[self.view viewWithTag:3];
    UIButton *openPublic2=(UIButton *)[self.view viewWithTag:4];
    UIButton *recorded1=(UIButton *)[self.view viewWithTag:5];
    UIButton *recorded2=(UIButton *)[self.view viewWithTag:6];
    UIButton *onGoing1=(UIButton *)[self.view viewWithTag:7];
    UIButton *onGoing2=(UIButton *)[self.view viewWithTag:8];
    UIButton *fmSystembtn=(UIButton *)[self.view viewWithTag:9];
    UIButton *microphoneBtn=(UIButton *)[self.view viewWithTag:10];
    UIButton *phoneConferencingBtn=(UIButton *)[self.view viewWithTag:11];
    UIButton *webInarBtn=(UIButton *)[self.view viewWithTag:12];
    UIButton *otherServicesBtn=(UIButton *)[self.view viewWithTag:13];
    UIButton *captionBtn=(UIButton *)[self.view viewWithTag:14];
    UIButton *viewTypeBtn=(UIButton *)[self.view viewWithTag:15];
    
    UITextField *eventNameTextField=(UITextField *)[self.view viewWithTag:100];
    UITextField *courseTextField=(UITextField *)[self.view viewWithTag:101];
    UITextView *descriptionTextView=(UITextView *)[self.view viewWithTag:102];
    UITextField *ofUserstextField=(UITextField *)[self.view viewWithTag:666];
    UILabel *recordSelected=(UILabel *)[self.view viewWithTag:110];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSMutableArray *chooseReqDetailedArray=[[GISStoreManager sharedManager]getChooseRequestDetailsObjects];
    if (chooseReqDetailedArray.count>0) {
        chooseRequest_Detailed_DetailsObj=[chooseReqDetailedArray lastObject];
        NSLog(@"----now--%@",chooseRequest_Detailed_DetailsObj.inCompleteTab_String_chooseReqParsedDetails);
        
        [eventTypeBtn setTitle:@" " forState:UIControlStateNormal];
        [dressCodeBtn setTitle:@" " forState:UIControlStateNormal];
        
        
        for (GISDropDownsObject *dropDownObj in _eventTypeArray) {
            if ([dropDownObj.id_String isEqualToString:chooseRequest_Detailed_DetailsObj.eventTypeID_String_chooseReqParsedDetails]) {
                [eventTypeBtn setTitle:dropDownObj.value_String forState:UIControlStateNormal];
                eventTypedata = dropDownObj.value_String;
            }
        }
        
        for (GISDropDownsObject *dropDownObj in _dresscodeArray) {
            if ([dropDownObj.id_String isEqualToString:chooseRequest_Detailed_DetailsObj.dressCodeID_String_chooseReqParsedDetails]) {
                [dressCodeBtn setTitle:dropDownObj.value_String forState:UIControlStateNormal];
                dresscodeData = dropDownObj.value_String;
            }
        }
        
        [eventNameTextField setText:[self returningstring:chooseRequest_Detailed_DetailsObj.eventName_String_chooseReqParsedDetails]];
        evevntNamedata = eventNameTextField.text;
        _eventTypeId_string = [self returningstring:chooseRequest_Detailed_DetailsObj.eventTypeID_String_chooseReqParsedDetails];
        _open_toPublicStr = [self returningstring:chooseRequest_Detailed_DetailsObj.openToPublic_String_chooseReqParsedDetails];
        _dressCode_Id_string = [self returningstring:chooseRequest_Detailed_DetailsObj.dressCodeID_String_chooseReqParsedDetails];
        _re_broadcastStr = [self returningstring:chooseRequest_Detailed_DetailsObj.recBroadcast_String_chooseReqParsedDetails];
        _on_goingStr = [self returningstring:chooseRequest_Detailed_DetailsObj.onGoing_String_chooseReqParsedDetails];
        _outsideAgencyStr = [self returningstring:chooseRequest_Detailed_DetailsObj.outsideAgency_String_chooseReqParsedDetails];
        [_othertechvalueStr setString:[self returningstring:chooseRequest_Detailed_DetailsObj.otherTechnologies_String_chooseReqParsedDetails]];
        [courseTextField setText:[self returningstring:chooseRequest_Detailed_DetailsObj.courseID_String_chooseReqParsedDetails]];
        courseIdData = courseTextField.text;
        [descriptionTextView setText:[self returningstring:chooseRequest_Detailed_DetailsObj.eventDescription_String_chooseReqParsedDetails]];
        _otherServices_Str = [self returningstring:chooseRequest_Detailed_DetailsObj.OtherServiceID_String_chooseReqParsedDetails];
        [captionBtn setTitle:[self returningstring:chooseRequest_Detailed_DetailsObj.CaptionTypeID_String_chooseReqParsedDetails] forState:UIControlStateNormal];
        _broadcastType_Str = [self returningstring:chooseRequest_Detailed_DetailsObj.recBroadcastYes_String_chooseReqParsedDetails];
        [ofUserstextField setText:[self returningstring:chooseRequest_Detailed_DetailsObj.CapNoOfUsers_String_chooseReqParsedDetails]];
        _eventdetails_viewOptions = [self returningstring:chooseRequest_Detailed_DetailsObj.CapViewOptions_String_chooseReqParsedDetails];
        _eventdetails_unitIdStr = [userDefaults valueForKey:kunitid];
        _eventdetails_statusStr = [self returningstring:chooseRequest_Detailed_DetailsObj.statusID_String_chooseReqParsedDetails];
        
        if([_open_toPublicStr isEqualToString:@"true"])
        {
            [openPublic1  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            [openPublic2  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
        }else if([_open_toPublicStr isEqualToString:@"false"])
        {
            [openPublic1  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [openPublic2  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }else{
            [openPublic1  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [openPublic2  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
        }
        
        if([_on_goingStr isEqualToString:@"true"])
        {
            [onGoing1  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            [onGoing2  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
        }else if([_on_goingStr isEqualToString:@"false"])
        {
            [onGoing1  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [onGoing2  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }else{
            [onGoing2  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [onGoing1  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
        }
        
        
        if([_re_broadcastStr isEqualToString:@"true"])
        {
            [recorded1  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            recordSelected.text = _broadcastType_Str;
            
        }else if([_re_broadcastStr isEqualToString:@"false"])
        {
            [recorded2  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            recordSelected.text = @"";
        }else{
            [recorded1  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [recorded2  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
        }
        
//        if([_outsideAgencyStr isEqualToString:@"true"])
//        {
//            [_outsideagency1  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
//            [_outsideagency2  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
//        }else if([_outsideAgencyStr isEqualToString:@"false"])
//        {
//            [_outsideagency1  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
//            [_outsideagency2  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
//        }else{
//            [_outsideagency1  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
//            [_outsideagency2  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
//        }
        
        if([_otherServices_Str isEqualToString:@"1"]){
            [otherServicesBtn setTitle:@"Captioning" forState:UIControlStateNormal];
            captionBtn.enabled = TRUE;
        }else if([_otherServices_Str isEqualToString:@"2"]){
            [otherServicesBtn setTitle:@"VRI" forState:UIControlStateNormal];
            captionBtn.enabled = FALSE;
        }else{
            [otherServicesBtn setTitle:@"" forState:UIControlStateNormal];
            captionBtn.enabled = TRUE;
            
        }
        
        [viewTypeBtn setTitle:_eventdetails_viewOptions forState:UIControlStateNormal];
        
        if([_othertechvalueStr length] >0){
            _otherTechArray = [[NSArray alloc] initWithArray:[_othertechvalueStr componentsSeparatedByString:@","]];
            
            if([otherTechStr count]>0)
                [otherTechStr removeAllObjects];
            
            for(int i=0 ;i<[_otherTechArray count];i++)
            {
                NSString *value = [_otherTechArray objectAtIndex:i];
                switch ([value intValue]) {
                    case 1:
                        [fmSystembtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        [otherTechStr addObject:value];
                        break;
                    case 2:
                        [microphoneBtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        [otherTechStr addObject:value];
                        break;
                    case 3:
                        [phoneConferencingBtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        [otherTechStr addObject:value];
                        break;
                    case 4:
                        [webInarBtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        [otherTechStr addObject:value];
                        break;
                    default:
                        break;
                }
            }
        }else{
            
            [fmSystembtn setBackgroundImage: [UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [microphoneBtn setBackgroundImage: [UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [phoneConferencingBtn setBackgroundImage: [UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [webInarBtn setBackgroundImage: [UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
        }
        
    }
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kselectedChooseReqNumber object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
