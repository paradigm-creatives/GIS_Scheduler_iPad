//
//  GISEventDetailsViewController.m
//  GIS_Scheduler
//
//  Created by Anand on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISEventDetailsViewController.h"
#import "GISEventDetailsCell.h"
#import  "GISPreparationMaterialCell.h"
#import "GISDatabaseManager.h"
#import "GISUtility.h"

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
        
        
    }
    
    if(indexPath.section == 1){
       GISPreparationMaterialCell *cell=(GISPreparationMaterialCell *)[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if(cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISPreparationMaterialCell" owner:self options:nil]objectAtIndex:0];
        }
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        
        return cell;
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    
    return cell;
}

- (IBAction)previousVersionBtnTap:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    
    if(btn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
    }
    else
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)showPopoverDetails:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    if(btn.tag == 1){
        _popover =   [GISUtility showPopOver:(NSMutableArray *)_eventTypeArray];
    }else if(btn.tag == 2){
        _popover =   [GISUtility showPopOver:(NSMutableArray *)_dresscodeArray];
    }
    _popover.delegate = self;

    
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }
    
    [_popover presentPopoverFromRect:CGRectMake(btn.frame.origin.x+btn.frame.size.width-15, btn.frame.origin.y+15, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
