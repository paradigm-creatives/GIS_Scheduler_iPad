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
    GISLocationDetailsCell *locationCell;
    
    if(indexPath.section == 0){
    
        locationCell=(GISLocationDetailsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
        return locationCell.frame.size.height;
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
    
    if(indexPath.section == 0){
    
        cell=(GISLocationDetailsCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISLocationDetailsCell" owner:self options:nil]objectAtIndex:0];
        }

        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    }else if(indexPath.section == 1){
        
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
