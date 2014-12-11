//
//  GISPopOverTableViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 21/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISPopOverTableViewController.h"
#import "GISDropDownsObject.h"
#import "GISConstants.h"
#import "GISServiceProviderObject.h"
#import "GISContactsInfoObject.h"
@interface GISPopOverTableViewController ()

@end

@implementation GISPopOverTableViewController

@synthesize popOverTableView;

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
    
    self.filteredArray = [[NSMutableArray alloc] init];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.preferredContentSize=popOverTableView.contentSize;
    popOverTableView.delegate = self;
    [super viewWillAppear:animated];
    
    dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MM/dd/yyyy"];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 325, 300)];
    datePicker.date = [NSDate date];
    
    if ([self.view_String isEqualToString:@"timesdates"])
    {
        datePicker.datePickerMode = UIDatePickerModeTime;
        
        [dateformatter setDateFormat:@"hh:mm a"];
        
        if ([self.dateTimeMoveUp_string length]) {
            NSDate *tempDate=[dateformatter dateFromString:self.dateTimeMoveUp_string];
            [datePicker setDate:tempDate];
        }
        else
        {
            datePicker.date=[NSDate date];
        }
        
    }
    else
    {
        datePicker.datePickerMode = UIDatePickerModeDate;

        if ([self.dateTimeMoveUp_string length]) {
            NSDate *date = [dateformatter dateFromString:self.dateTimeMoveUp_string];
            [datePicker setDate:date];
        }
        else
        {
            datePicker.date= [NSDate date];
        }
        
    }
    
    
    [datePicker addTarget:self
                   action:@selector(datePickerChange:)
         forControlEvents:UIControlEventValueChanged];
    
    if ([self.view_String isEqualToString:@"datestimes"]||[self.view_String isEqualToString:@"timesdates"]) {
        popOverTableView.scrollEnabled=NO;
        popOverSearchBar.hidden = YES;
        CGRect frame =  self.popOverView.frame;
        frame.origin.y = 0;
        frame.size.height = 210;
        self.popOverTableView.frame = frame;
        [self.popOverView addSubview:datePicker];
    }else{
        
        [datePicker removeFromSuperview];
    }
    if(!([[self.popOverArray lastObject] isKindOfClass:[GISDropDownsObject class]] || [[self.popOverArray lastObject] isKindOfClass:[GISContactsInfoObject class]] ||
       [[self.popOverArray lastObject] isKindOfClass:[GISServiceProviderObject class]]))
    {
        popOverSearchBar.hidden = YES;
        CGRect frame =  self.popOverView.frame;
        frame.origin.y = 0;
        frame.size.height = 90;
        self.popOverView.frame = frame;
        
    }
}

-(void)datePickerChange:(id)sender
{
    NSLog(@"Called DateTime-->%@",datePicker.date);
    [self.popOverDelegate sendTheSelectedPopOverData:@"" value:[dateformatter stringFromDate:datePicker.date]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.view_String isEqualToString:@"datestimes"]||[self.view_String isEqualToString:@"timesdates"]) {
        return 250;
    }
    return 35;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.filteredArray count];
    }
    
    if ([self.view_String isEqualToString:@"datestimes"]||[self.view_String isEqualToString:@"timesdates"]) {
        return 0;
    }
    return [self.popOverArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.view_String isEqualToString:@"datestimes"]||[self.view_String isEqualToString:@"timesdates"]) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"popOver"];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"popPver"];
        }
        [cell.contentView addSubview:datePicker];
        return cell;
    }
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"popOver"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"popPver"];
    }

    if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISDropDownsObject class]])
    {
        GISDropDownsObject *dropDownObj=[self.popOverArray objectAtIndex:indexPath.row];
        cell.textLabel.text=dropDownObj.value_String;
    }
    else if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISContactsInfoObject class]])
    {
        GISContactsInfoObject *dropDownObj=[self.popOverArray objectAtIndex:indexPath.row];
        cell.textLabel.text=dropDownObj.contactNo_String;
    }
    else if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISServiceProviderObject class]])
    {
        GISServiceProviderObject *spObj;
        
        if (tableView == self.searchDisplayController.searchResultsTableView)
        {
            spObj = [self.filteredArray objectAtIndex:[indexPath row]];
        }else{
            
            spObj=[self.popOverArray objectAtIndex:indexPath.row];
            
        }
        cell.textLabel.text=spObj.service_Provider_String;
    }
    else
    {
        cell.textLabel.text=[self.popOverArray objectAtIndex:indexPath.row];

        
        self.tableHeightConstraint.constant = 80;
        [popOverTableView needsUpdateConstraints];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISDropDownsObject class]])
    {
        GISDropDownsObject *dropDownObj=[self.popOverArray objectAtIndex:indexPath.row];
        [self.popOverDelegate sendTheSelectedPopOverData:dropDownObj.id_String value:dropDownObj.value_String];
    }
    else if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISContactsInfoObject class]])
    {
        GISContactsInfoObject *spObj=[self.popOverArray objectAtIndex:indexPath.row];
        [self.popOverDelegate sendTheSelectedPopOverData:spObj.contactTypeId_String value:spObj.contactNo_String];
    }
    else if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISServiceProviderObject class]])
    {
        GISServiceProviderObject *spObj=[self.popOverArray objectAtIndex:indexPath.row];
        [self.popOverDelegate sendTheSelectedPopOverData:spObj.id_String value:spObj.service_Provider_String];
    }else if(appDelegate.isNoofAttendees){
        
        [self.popOverDelegate sendTheSelectedPopOverData:[_noOfAttendeesIdArray objectAtIndex:indexPath.row] value:[self.popOverArray objectAtIndex:indexPath.row]];
    }
    else
    {
        [self.popOverDelegate sendTheSelectedPopOverData:@"" value:[self.popOverArray objectAtIndex:indexPath.row]];
    }
    
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self.filteredArray removeAllObjects];

	
    if([[self.popOverArray lastObject] isKindOfClass:[GISServiceProviderObject class]])
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"service_Provider_String contains[c] %@",searchText];
        NSArray *tempArray = [self.popOverArray filteredArrayUsingPredicate:predicate];
        
        self.filteredArray = [NSMutableArray arrayWithArray:tempArray];
    }
    if([[self.popOverArray lastObject] isKindOfClass:[GISDropDownsObject class]])
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"value4_String contains[c] %@",searchText];
        NSArray *tempArray = [self.popOverArray filteredArrayUsingPredicate:predicate];
        
        self.filteredArray = [NSMutableArray arrayWithArray:tempArray];

    }
    else if([[self.popOverArray lastObject] isKindOfClass:[GISContactsInfoObject class]])
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"contactNo_String contains[c] %@",searchText];
        NSArray *tempArray = [self.popOverArray filteredArrayUsingPredicate:predicate];
        
        self.filteredArray = [NSMutableArray arrayWithArray:tempArray];
    }

}


#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
