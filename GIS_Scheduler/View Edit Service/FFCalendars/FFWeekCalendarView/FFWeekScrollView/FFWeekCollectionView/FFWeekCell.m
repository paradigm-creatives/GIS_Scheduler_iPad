//
//  FFWeekCell.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/22/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFWeekCell.h"

#import "FFHourAndMinLabel.h"
#import "FFBlueButton.h"
#import "FFEventDetailPopoverController.h"
#import "FFEditEventPopoverController.h"
#import "FFImportantFilesForCalendar.h"
#import "GISPopOverController.h"
#import "GISAppDelegate.h"

@interface FFWeekCell () <FFEventDetailPopoverControllerProtocol, FFEditEventPopoverControllerProtocol, TestEventDetailPopoverControllerProtocol>
@property (nonatomic, strong) NSMutableArray *arrayLabelsHourAndMin;
@property (nonatomic, strong) NSMutableArray *arrayButtonsEvents;
@property (nonatomic, strong) FFEventDetailPopoverController *popoverControllerDetails;
@property (nonatomic, strong) GISPopOverController *testPopoverControllerDetails;
@property (nonatomic, strong) FFEditEventPopoverController *popoverControllerEditar;
@property (nonatomic, strong) FFBlueButton *button;
@end

@implementation FFWeekCell

@synthesize protocol;
@synthesize date;
@synthesize arrayLabelsHourAndMin;
@synthesize arrayButtonsEvents;
@synthesize popoverControllerDetails;
@synthesize popoverControllerEditar;
@synthesize button;
@synthesize testPopoverControllerDetails;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        arrayLabelsHourAndMin = [NSMutableArray new];
        arrayButtonsEvents = [NSMutableArray new];
        
        [self addLines];
    }
    return self;
}

- (void)showEvents:(NSArray *)array {
    
    [self addButtonsWithArray:array];
}

- (void)addLines {
    
    CGFloat y = 0;
    
    for (int hour=0; hour<=23; hour++) {
        
        for (int min=0; min<=45; min=min+MINUTES_PER_LABEL) {
            
            FFHourAndMinLabel *labelHourMin = [[FFHourAndMinLabel alloc] initWithFrame:CGRectMake(0, y, self.frame.size.width, HEIGHT_CELL_MIN) date:[NSDate dateWithHour:hour min:min]];
            [labelHourMin setTextColor:[UIColor grayColor]];
            if (min == 0) {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_CELL_MIN/2., self.frame.size.width, 1.)];
                [view setBackgroundColor:[UIColor lightGrayCustom]];
                [labelHourMin addSubview:view];
                [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
                [labelHourMin setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
            }
            [self addSubview:labelHourMin];
            [arrayLabelsHourAndMin addObject:labelHourMin];
            
            y += HEIGHT_CELL_MIN;
        }
    }
}

- (void)clean {
    
     [arrayButtonsEvents removeAllObjects];
    
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[FFBlueButton class]] || [subview isKindOfClass:[UIView class]] ||  [subview isKindOfClass:[UILabel class]]) {
            
            [subview removeFromSuperview];
        }
    }
}

- (void)addButtonsWithArray:(NSArray *)array {
    
    UIView *view;
    
    if (array) {
        
        for (FFEvent *event in array) {
            
            CGFloat yTimeBegin;
            CGFloat yTimeEnd;
            
            for (FFHourAndMinLabel *label in arrayLabelsHourAndMin) {
                NSDateComponents *compLabel = [NSDate componentsOfDate:label.dateHourAndMin];
                NSDateComponents *compEventBegin = [NSDate componentsOfDate:event.dateTimeBegin];
                NSDateComponents *compEventEnd = [NSDate componentsOfDate:event.dateTimeEnd];
                
                if (compLabel.hour == compEventBegin.hour && compLabel.minute <= compEventBegin.minute && compEventBegin.minute < compLabel.minute+MINUTES_PER_LABEL) {
                    yTimeBegin = label.frame.origin.y+label.frame.size.height/2.;
                }
                if (compLabel.hour == compEventEnd.hour && compLabel.minute <= compEventEnd.minute && compEventEnd.minute < compLabel.minute+MINUTES_PER_LABEL) {
                    yTimeEnd = label.frame.origin.y+label.frame.size.height;
                }
            }
            
            FFBlueButton *_button = [[FFBlueButton alloc] initWithFrame:CGRectMake(0, yTimeBegin, self.frame.size.width, yTimeEnd-yTimeBegin)];
            [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            //[_button setTitle:event.stringCustomerName forState:UIControlStateNormal];
            [_button setEvent:event];
            
            [arrayButtonsEvents addObject:_button];
            [self addSubview:_button];
            
            view = [[UIView alloc] initWithFrame:CGRectMake(0, _button.frame.origin.y, _button.frame.size.width-100.0f, _button.frame.size.height)];
           [view setBackgroundColor:[UIColor colorWithRed:49./255. green:181./255. blue:247./255. alpha:0.5]];
            
            [self addSubview:view];
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, _button.frame.origin.y, _button.frame.size.width, 20.0f)];
            label1.text = [NSString stringWithFormat:@"%@ %@",@"JobID", event.numCustomerID];
            [label1 setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
            [self addSubview:label1];
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(5, label1.frame.origin.y+25.0f, _button.frame.size.width, 20.0f)];
            label2.text = [NSString stringWithFormat:@"%@ to %@",[NSDate stringTimeOfDate:event.dateTimeBegin], [NSDate stringTimeOfDate:event.dateTimeEnd]];
            [label2 setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
            [self addSubview:label2];
            
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(3, label2.frame.origin.y+25.0f, _button.frame.size.width+10, 20.0f)];
            label3.text = [NSString stringWithFormat:@"Requested On %@",[self eventDisplayFormat:event.dateDay]];
            [label3 setFont:[UIFont fontWithName:@"Arial" size:10.0f]];
            [self addSubview:label3];
            
            [self bringSubviewToFront:_button];

            
        }
    }
}

#pragma mark - Button Action

- (IBAction)buttonAction:(id)sender {
    
    button = (FFBlueButton *)sender;
    
    GISAppDelegate *appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate.isWeekView = YES;
    
//    popoverControllerDetails = [[FFEventDetailPopoverController alloc] initWithEvent:button.event];
//    [popoverControllerDetails setProtocol:self];
//    
//    [popoverControllerDetails presentPopoverFromRect:button.frame
//                                              inView:self
//                            permittedArrowDirections:UIPopoverArrowDirectionLeft
//                                            animated:YES];
    
    testPopoverControllerDetails = [[GISPopOverController alloc] initWithEvent:button.event];
    [testPopoverControllerDetails setTestProtocol:self];
    
    [testPopoverControllerDetails presentPopoverFromRect:button.frame
                                              inView:self
                            permittedArrowDirections:UIPopoverArrowDirectionLeft
                                            animated:YES];
}

#pragma mark - FFEventDetailPopoverController Protocol

- (void)showPopoverEditWithEvent:(FFEvent *)_event {
    
    popoverControllerEditar = [[FFEditEventPopoverController alloc] initWithEvent:_event];
    [popoverControllerEditar setProtocol:self];
    
    [popoverControllerEditar presentPopoverFromRect:button.frame
                                             inView:self
                           permittedArrowDirections:UIPopoverArrowDirectionAny
                                           animated:YES];
}


#pragma mark - FFEditEventPopoverController Protocol

- (void)saveEditedEvent:(FFEvent *)eventNew {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(saveEditedEvent:ofCell:atIndex:)]) {
        [protocol saveEditedEvent:eventNew ofCell:self atIndex:[arrayButtonsEvents indexOfObject:button]];
    }
}

- (void)deleteEvent {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(deleteEventOfCell:atIndex:)]) {
        [protocol deleteEventOfCell:self atIndex:[arrayButtonsEvents indexOfObject:button]];
    }
}

#pragma mark - TestEventDetailPopoverController Protocol

- (void)showPopoverEventDetailWithEvent:(FFEvent *)_event{
    
    popoverControllerDetails = [[FFEventDetailPopoverController alloc] initWithEvent:_event];
    [popoverControllerDetails setProtocol:self];
    
    [popoverControllerDetails presentPopoverFromRect:button.frame
                                              inView:self
                            permittedArrowDirections:UIPopoverArrowDirectionLeft
                                            animated:YES];

}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (NSString *)eventDisplayFormat:(NSDate *)fromdate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *dateStr = [dateFormat stringFromDate:fromdate];
    NSDate *myDate = [dateFormat dateFromString:dateStr];
    
    NSDateComponents *components= [[NSDateComponents alloc] init];
    [components setDay:0];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *dateIncremented= [calendar dateByAddingComponents:components toDate:myDate options:0];
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *stringFromDate = [myDateFormatter stringFromDate:dateIncremented];
    
    return stringFromDate;
}

@end
