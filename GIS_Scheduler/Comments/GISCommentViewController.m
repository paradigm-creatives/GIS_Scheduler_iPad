//
//  GISCommentViewController.m
//  GIS_Scheduler
//
//  Created by Anand on 18/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISCommentViewController.h"
#import "GISCommentCell.h"
#import "GISConstants.h"

@interface GISCommentViewController ()

@end

@implementation GISCommentViewController

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
}
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISCommentCell *commentCell;
        
    commentCell=(GISCommentCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return commentCell.frame.size.height;
}
    
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        GISCommentCell *cell;
        
        cell=(GISCommentCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISCommentCell" owner:self options:nil]objectAtIndex:0];
        }
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        cell.commentTextView.delegate = self;
        cell.commentTextView.text = @"Add Comments";
        cell.commentTextView.textColor = UIColorFromRGB(0x00457c);
        
        
        return cell;
    }
    
- (void)textViewDidBeginEditing:(UITextView *)textView
    {
        if ([textView.text isEqualToString:@"Add Comments"]) {
            textView.text = @"";
            textView.textColor = [UIColor blackColor];
        }
        [textView becomeFirstResponder];
    }
    
- (void)textViewDidEndEditing:(UITextView *)textView
    {
        if ([textView.text isEqualToString:@""]) {
            textView.text = @"Add Comments";
            textView.textColor = UIColorFromRGB(0x00457c);
        }
        [textView resignFirstResponder];
    }
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
