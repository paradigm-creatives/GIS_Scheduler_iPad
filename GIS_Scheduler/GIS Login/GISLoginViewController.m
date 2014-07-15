//
//  GISLoginViewController.m
//  GIS_Scheduler
//
//  Created by Anand on 14/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISLoginViewController.h"
#import "GISConstants.h"
#import "GISFonts.h"
#import "GISAppDelegate.h"

@interface GISLoginViewController ()

@end

@implementation GISLoginViewController

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
    
    _userNameView.layer.cornerRadius = 5.0f;
    _userNameView.clipsToBounds = YES;

    _passwordView.layer.cornerRadius = 5.0f;
    _passwordView.clipsToBounds = YES;
    
    _signINButton.layer.cornerRadius = 5.0f;
    _signINButton.clipsToBounds = YES;
    
    [_signINButton setTitle:@"Login" forState:UIControlStateNormal];
    [_signINButton setTitleColor:UIColorFromRGB(0x00457c) forState:UIControlStateNormal];
    [_signINButton.titleLabel setFont:[GISFonts large]];
    
    [self addRightView:_userName_textfield];
    [self addRightView:_password_textfield];
    
    [_userName_textfield setPlaceholder:@"User Name"];
    [_password_textfield setPlaceholder:@"Password"];
    
    [_userName_textfield setValue:[GISFonts large] forKeyPath:@"_placeholderLabel.font"];
    [_password_textfield setValue:[GISFonts large] forKeyPath:@"_placeholderLabel.font"];
    
    [_userName_textfield setValue:UIColorFromRGB(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    [_password_textfield setValue:UIColorFromRGB(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    
}

-(void)addRightView:(UITextField *) textField{
    
    UIImageView *imgView;
    UIView *paddingView ;
    
    if(_userName_textfield == textField){
        imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_username.png"]];
        imgView.frame = CGRectMake(0.0, 0.0, imgView.image.size.width, imgView.image.size.height);
    }else{
        imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password.png"]];
        imgView.frame = CGRectMake(0.0, 0.0, imgView.image.size.width, imgView.image.size.height);
    }
    
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55.0, 40.0)];
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45.0, 40.0)];
    
    [imgView setCenter:CGPointMake(paddingView.frame.size.width / 2, paddingView.frame.size.height / 2)];
    [paddingView setBackgroundColor:UIColorFromRGB(0xdedede)];
    
    [paddingView addSubview:imgView];
    [mainView addSubview:paddingView];
    [textField setLeftViewMode:UITextFieldViewModeAlways];
    [textField setLeftView:mainView];

}

-(IBAction)signInClicked:(id)sender{
    
    [self.view.window setRootViewController:appDelegate.spiltViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
