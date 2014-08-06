//
//  GISLocationDetailsViewController.m
//  GIS_Scheduler
//
//  Created by Anand on 17/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISLocationDetailsViewController.h"
#import "GISLocationDetailsCell.h"
#import "GISLocationOnCampusCell.h"
#import "GISFonts.h"
#import "GISConstants.h"
#import "GISDatabaseManager.h"
#import "GISPopOverTableViewController.h"
#import "GISUtility.h"

@interface GISLocationDetailsViewController ()

@end

@implementation GISLocationDetailsViewController

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
        
        [_locationDetaislTabelView setContentSize:CGSizeMake(1024, 940)];
        
        NSString *generalLocation_statement = [[NSString alloc]initWithFormat:@"select * from TBL_GENERAL_LOCATION  ORDER BY ID DESC;"];
        _generalLocationArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:generalLocation_statement];
        
        NSString *closestMetro_statement = [[NSString alloc]initWithFormat:@"select * from TBL_CLOSEST_METRO  ORDER BY ID DESC;"];
        _closestMetroArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:closestMetro_statement];
        
        NSString *buildingName_statement = [[NSString alloc]initWithFormat:@"select * from TBL_BUILDING_NAME  ORDER BY ID DESC;"];
        _buildingNameArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:buildingName_statement];
    }


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 0;
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISLocationDetailsCell *locationCell;
    
    if(indexPath.section == 0){
        
        return 0;
    
       // locationCell=(GISLocationDetailsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
       // return locationCell.frame.size.height;
    }
    if(indexPath.section == 1){
        
        GISLocationOnCampusCell * onCampusCell=(GISLocationOnCampusCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return onCampusCell.frame.size.height;
    }
    
    return locationCell.frame.size.height;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISLocationDetailsCell *cell;
    
//    if(indexPath.section == 0){
//    
//        cell=(GISLocationDetailsCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
//        if(cell==nil)
//        {
//            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISLocationDetailsCell" owner:self options:nil]objectAtIndex:0];
//        }
//
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    
//    }
    if(indexPath.section == 1){
        
       GISLocationOnCampusCell *cell=(GISLocationOnCampusCell *)[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if(cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISLocationOnCampusCell" owner:self options:nil]objectAtIndex:0];
        }
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    
    return cell;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView;
    if(section == 0){
        headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
        UILabel *genralLocationLabel = [[UILabel alloc] init];
        genralLocationLabel.frame = CGRectMake(50.0, 20.0, 120.0, 27.0);
        [genralLocationLabel setFont:[GISFonts normal]];
        genralLocationLabel.textColor = UIColorFromRGB(0x666666);
        genralLocationLabel.text = NSLocalizedStringFromTable(@"general_location", TABLE, nil);
        [headerView addSubview:genralLocationLabel];
        
        UIButton *generalLocationBtn = [[UIButton alloc] init];
        generalLocationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [generalLocationBtn setBackgroundImage:[UIImage imageNamed:@"choose_request_bg.png"] forState:UIControlStateNormal];
        generalLocationBtn.frame = CGRectMake(175.0, 20.0, 150.0, 27.0);
        generalLocationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        generalLocationBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
        [generalLocationBtn.titleLabel setFont:[GISFonts small]];
        [generalLocationBtn setTitleColor:UIColorFromRGB(0x616161) forState:UIControlStateNormal];
        [generalLocationBtn setTitle:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil) forState:UIControlStateNormal];
        [generalLocationBtn setTag:121];
        [generalLocationBtn addTarget:self action:@selector(showPopoverDetails:) forControlEvents:UIControlEventTouchUpInside];
        
        [headerView addSubview:generalLocationBtn];
    }
    
    return headerView;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if(section == 0){
        return 50.0;
    }
    
    return 0;
}

- (IBAction)showPopoverDetails:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    GISPopOverTableViewController *tableViewController = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController.popOverDelegate = self;
    _popover =   [GISUtility showPopOver:(NSMutableArray *)_generalLocationArray viewController:tableViewController];
    _popover.delegate = self;
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }
    
    [_popover presentPopoverFromRect:CGRectMake(btn.frame.origin.x+btn.frame.size.width-15, btn.frame.origin.y+15, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown animated:YES];
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    generalLocationdata= value_str;
    UIButton *eventTypeBtn=(UIButton *)[self.view viewWithTag:121];
    [eventTypeBtn setTitle:generalLocationdata forState:UIControlStateNormal];
    if(_popover)
        [_popover dismissPopoverAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
