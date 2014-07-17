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
    [_eventDetaislTabelView setContentSize:CGSizeMake(1024, 768)];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
