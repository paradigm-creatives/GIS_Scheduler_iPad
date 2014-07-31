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
    [_eventDetaislTabelView setContentSize:CGSizeMake(1024, 880)];
    
    
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
        
        if(broadCastSelected){
            cell.broadcastYesSelcted.text = _broadcastType_Str;
            [cell.recorded1 setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }else{
             [cell.recorded1 setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
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

        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        
        return cell;
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    
    return cell;
}

- (IBAction)previousVersionBtnTap:(id)sender{
    
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
        }

        
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
    }else if(btn_tag == 2){
        dresscodeData = value_str;
    }else if(btn_tag == 13){
        otherServicesdata = value_str;
    }else if(btn_tag == 14){
        captionData = value_str;
    }else if(btn_tag == 15){
        viewingTypeData = value_str;
    }
    
    if(_popover)
        [_popover dismissPopoverAnimated:YES];
    
    [_eventDetaislTabelView reloadData];
    
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
