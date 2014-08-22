//
//  GISContactsAndBillingViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISContactsAndBillingViewController : UIViewController
{
//    IBOutlet UILabel *_Label;
//    IBOutlet UILabel *_Answer_Label;
    
    IBOutlet UILabel *requestorDetails_Label;
    
    IBOutlet UILabel *unitOrDep_Label;
    IBOutlet UILabel *unitOrDep_Answer_Label;
    
    IBOutlet UILabel *firstName_Label;
    IBOutlet UILabel *firstName_Answer_Label;
    
    IBOutlet UILabel *lastName_Label;
    IBOutlet UILabel *lastName_Answer_Label;
    
    IBOutlet UILabel *email_Label;
    IBOutlet UILabel *email_Answer_Label;
    
    IBOutlet UILabel *contacts_Label;
    IBOutlet UILabel *contacts_Answer_Label;
    
    IBOutlet UILabel *billingDetails_Label;

    IBOutlet UILabel *accountName_Label;
    IBOutlet UILabel *accountName_Answer_Label;
    
    IBOutlet UILabel *department_Label;
    IBOutlet UILabel *department_Answer_Label;
    
    IBOutlet UILabel *buhFirstName_Label;
    IBOutlet UILabel *buhFirstName_Answer_Label;
    
    IBOutlet UILabel *buhLastName_Label;
    IBOutlet UILabel *buhLastName_Answer_Label;
    
    IBOutlet UILabel *buhEmail_Label;
    IBOutlet UILabel *buhEmail_Answer_Label;
    
    IBOutlet UILabel *buhAddress1_Label;
    IBOutlet UILabel *buhAddress2_Label;

    IBOutlet UITextView *buhAddress1_TextView;
    IBOutlet UITextView *buhAddress2_textView;
    
    IBOutlet UILabel *buhCity_Label;
    IBOutlet UILabel *buhCity_Answer_Label;
    
    IBOutlet UILabel *buhState_Label;
    IBOutlet UILabel *buhState_Answer_Label;
    
    IBOutlet UILabel *buhZip_Label;
    IBOutlet UILabel *buhZip_Answer_Label;
    
    IBOutlet UIButton *nextButton;
}
@end
