//
//  GISUtility.m
//  Gallaudet-Interpreting-Service
//
//  Created by Anand on 21/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISUtility.h"
#import "GISFonts.h"
#import "GISPopOverTableViewController.h"

@implementation GISUtility


+ (UIPickerView *)showDropdownPickerview:(UIActionSheet *)actionSheet sender:(id)sender viewController:(UIViewController *)controller{
    
    //Done Button
    UISegmentedControl *doneButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
    doneButton.momentary = YES;
    NSInteger deviceVersion = [[UIDevice currentDevice] systemVersion].integerValue;
    if(deviceVersion >7){
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [GISFonts normal], NSFontAttributeName,
                                    [UIColor whiteColor], NSForegroundColorAttributeName,
                                    nil];
        [doneButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
        NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        [doneButton setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
        
        //doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
        doneButton.tintColor = [UIColor colorWithRed:49.0 / 256.0 green:148.0 / 256.0 blue:208.0 / 256.0 alpha:1];
    }
    else{
        
        //doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
        doneButton.tintColor = [UIColor blackColor];
    }
    doneButton.tag=[sender tag];
    doneButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    [doneButton addTarget:controller action:@selector(doneButnPressed:) forControlEvents:UIControlEventValueChanged];
    //Done Button
    
    //Cancel Button
    UISegmentedControl *cancelButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Cancel"]];
    cancelButton.momentary = YES;
    if(deviceVersion >7){
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [GISFonts normal], NSFontAttributeName,
                                    [UIColor whiteColor], NSForegroundColorAttributeName,
                                    nil];
        [doneButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
        NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        [doneButton setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
        
        //doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
        doneButton.tintColor = [UIColor colorWithRed:49.0 / 256.0 green:148.0 / 256.0 blue:208.0 / 256.0 alpha:1];
    }
    else{
        //cancelButton.segmentedControlStyle = UISegmentedControlStyleBar;
        cancelButton.tintColor = [UIColor blackColor];
    }
    cancelButton.tag=[sender tag];
    [cancelButton addTarget:controller action:@selector(cancelButnPressed:) forControlEvents:UIControlEventValueChanged];
    cancelButton.frame = CGRectMake(195, 7.0f, 50.0f, 30.0f);
    //Cancel Button
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    actionSheet.tag=[sender tag];
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    [actionSheet addSubview:pickerView];
    [actionSheet addSubview:doneButton];
    [actionSheet addSubview:cancelButton];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 490)];
    
    return pickerView;
    
}


+(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

-(void)doneButnPressed:(id)sender{
    
}

-(void)cancelButnPressed:(id)sender{
    
}


+(void)moveemailView:(BOOL)ismove viewHeight:(int)viewUpHeight view:(UIView *)currentView
{
    
    if(ismove)
    {
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration:1.0];
        
        CGRect frame=currentView.frame;
        frame.origin.x=viewUpHeight;
        currentView.frame=frame;
        [UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration:0.2];
        CGRect frame=currentView.frame;
        frame.origin.x=0;
        currentView.frame=frame;
        
        [UIView commitAnimations];
    }
//    CGRect frame=currentView.frame;
//    if(ismove)
//    {
//        frame.origin.x-=viewUpHeight;
//    }
//    else
//    {
//        
//        frame.origin.x+=viewUpHeight;
//    }
//    [UIView animateWithDuration:0.3f
//                          delay:0.0f
//                        options:UIViewAnimationOptionCurveEaseIn
//                     animations:^{
//                         [currentView setFrame:frame];
//                     }
//                     completion:nil];
}

+(NSString *)returningstring:(id)string
{
    if ([string isKindOfClass:[NSNull class]] || string==nil)
    {
        return @" ";
    }
    else
    {
        if (![string isKindOfClass:[NSString class]])
        {
            NSString *str= [string stringValue];
            
            return str;
        }
        else
        {
            return string;
        }
    }
    
}

+(UIPopoverController *)showPopOver:(NSMutableArray *)localArray viewController:(GISPopOverTableViewController*)tableViewController{

    UIPopoverController *popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController];
    popover.popoverContentSize = CGSizeMake(300, 210);
    tableViewController.popOverArray=localArray;
   
    return popover;
}





@end
