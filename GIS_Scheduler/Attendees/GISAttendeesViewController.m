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
    for (int i=0; i<row_count; i++) {
        attendees_ListObject=[[GISAttendees_ListObject alloc]init];
        [attendeesObject.attendeesList_mutArray addObject:[self addEmptyData:attendees_ListObject]];
    }
    [self.attendees_tableView reloadData];
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
    [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+135, button.frame.origin.y+20, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}



-(void)sendTheSelectedPopOverData:(NSString *)id_str :(NSString *)value_str
{
    [popover dismissPopoverAnimated:YES];
    
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
