//
//  GISContactsAndBillingViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISContactsAndBillingViewController.h"
#import "GISFonts.h"
#import "GISConstants.h"
#import "GISPopOverTableViewController.h"

@interface GISContactsAndBillingViewController ()

@end

@implementation GISContactsAndBillingViewController

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
    
    requestorDetails_Label.textColor=UIColorFromRGB(0x666666);
    
    unitOrDep_Label.textColor=UIColorFromRGB(0x666666);
    unitOrDep_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    firstName_Label.textColor=UIColorFromRGB(0x666666);
    firstName_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    lastName_Label.textColor=UIColorFromRGB(0x666666);
    lastName_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    email_Label.textColor=UIColorFromRGB(0x666666);
    email_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    contacts_Label.textColor=UIColorFromRGB(0x666666);
    contacts_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    billingDetails_Label.textColor=UIColorFromRGB(0x666666);
    
    accountName_Label.textColor=UIColorFromRGB(0x666666);
    accountName_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    department_Label.textColor=UIColorFromRGB(0x666666);
    department_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    buhFirstName_Label.textColor=UIColorFromRGB(0x666666);
    buhFirstName_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    buhLastName_Label.textColor=UIColorFromRGB(0x666666);
    buhLastName_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    buhEmail_Label.textColor=UIColorFromRGB(0x666666);
    buhEmail_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    buhAddress1_Label.textColor=UIColorFromRGB(0x666666);
    buhAddress2_Label.textColor=UIColorFromRGB(0x666666);
    
    buhAddress1_TextView.textColor=UIColorFromRGB(0x666666);
    buhAddress2_textView.textColor=UIColorFromRGB(0x666666);
    
    buhCity_Label.textColor=UIColorFromRGB(0x666666);
    buhCity_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    buhState_Label.textColor=UIColorFromRGB(0x666666);
    buhState_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    buhZip_Label.textColor=UIColorFromRGB(0x666666);
    buhZip_Answer_Label.textColor=UIColorFromRGB(0x666666);
    
    
    nextButton.backgroundColor=UIColorFromRGB(0x00457c);
    [nextButton setTitleColor:UIColorFromRGB(0xe8d4a2) forState:UIControlStateNormal];
    nextButton.titleLabel.font=[GISFonts larger];
    [nextButton.layer setCornerRadius:3.0f];
    /////
    requestorDetails_Label.font=[GISFonts large];
    
    unitOrDep_Label.font=[GISFonts normal];
    unitOrDep_Answer_Label.font=[GISFonts small];
    
    firstName_Label.font=[GISFonts normal];
    firstName_Answer_Label.font=[GISFonts small];
    
    lastName_Label.font=[GISFonts normal];
    lastName_Answer_Label.font=[GISFonts small];
    
    email_Label.font=[GISFonts normal];
    email_Answer_Label.font=[GISFonts small];
    
    contacts_Label.font=[GISFonts normal];
    contacts_Answer_Label.font=[GISFonts small];
    
    billingDetails_Label.font=[GISFonts large];
    
    accountName_Label.font=[GISFonts normal];
    accountName_Answer_Label.font=[GISFonts small];
    
    department_Label.font=[GISFonts normal];
    department_Answer_Label.font=[GISFonts small];
    
    buhFirstName_Label.font=[GISFonts normal];
    buhFirstName_Answer_Label.font=[GISFonts small];
    
    buhLastName_Label.font=[GISFonts normal];
    buhLastName_Answer_Label.font=[GISFonts small];
    
    buhEmail_Label.font=[GISFonts normal];
    buhEmail_Answer_Label.font=[GISFonts small];
    
    buhAddress1_Label.font=[GISFonts normal];
    buhAddress2_Label.font=[GISFonts normal];
    
    buhAddress1_TextView.font=[GISFonts small];
    buhAddress2_textView.font=[GISFonts small];
    
    buhCity_Label.font=[GISFonts normal];
    buhCity_Answer_Label.font=[GISFonts small];
    
    buhState_Label.font=[GISFonts normal];
    buhState_Answer_Label.font=[GISFonts small];
    
    buhZip_Label.font=[GISFonts normal];
    buhZip_Answer_Label.font=[GISFonts small];
    
    
    [buhAddress1_TextView.layer setBorderWidth:0.2];
    [buhAddress1_TextView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [buhAddress1_TextView.layer setCornerRadius:5.0f];
    
    [buhAddress2_textView.layer setBorderWidth:0.2];
    [buhAddress2_textView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [buhAddress2_textView.layer setCornerRadius:5.0f];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
}

- (IBAction)chooseRequestDropDown:(id)sender{
    UIButton *button = (UIButton*)sender;
    
    GISPopOverTableViewController *tableViewController = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    
    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:@"Test",@"Test 1",@"Test 2", nil];
    tableViewController.popOverArray=array;

    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController];
    popover.delegate = self;
    popover.popoverContentSize = CGSizeMake(230, 150);
    [popover presentPopoverFromRect:CGRectMake(button.frame.size.width*2+10, button.frame.size.height / 1+50, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
