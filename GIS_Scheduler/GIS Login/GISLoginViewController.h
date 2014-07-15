//
//  GISLoginViewController.h
//  GIS_Scheduler
//
//  Created by Anand on 14/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISAppDelegate.h"

@interface GISLoginViewController : UIViewController
{
    GISAppDelegate *appDelegate;
}

@property (nonatomic,strong) IBOutlet UITextField *userName_textfield;
@property (nonatomic,strong) IBOutlet UITextField *password_textfield;
@property (nonatomic,strong) IBOutlet UIButton *signINButton;

@property (nonatomic,strong) IBOutlet UIView *userNameView;
@property (nonatomic,strong) IBOutlet UIView *passwordView;


-(IBAction)signInClicked:(id)sender;



@end
