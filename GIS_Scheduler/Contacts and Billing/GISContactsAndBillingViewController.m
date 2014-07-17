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
    
    [nextButton setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    
    
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
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
