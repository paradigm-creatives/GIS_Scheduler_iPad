//
//  FFDayCell.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/23/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFDayCell.h"

#import "FFHourAndMinLabel.h"
#import "FFBlueButton.h"
#import "FFImportantFilesForCalendar.h"
#import "GISEventLabel.h"
#import "GISEeventShowBackgroundView.h"
#import "GISAppDelegate.h"
#import "GISFonts.h"

@interface FFDayCell ()
@property (nonatomic, strong) NSMutableArray *arrayLabelsHourAndMin;
@property (nonatomic, strong) NSMutableArray *arrayButtonsEvents;
@property (nonatomic, strong) FFBlueButton *button;
@property (nonatomic) CGFloat yCurrent;
@property (nonatomic, strong) UILabel *labelWithSameYOfCurrentHour;
@property (nonatomic, strong) UILabel *labelRed;
@property (nonatomic, strong) NSMutableArray *eventsArray;
@end

@implementation FFDayCell

@synthesize protocol;
@synthesize date;
@synthesize arrayLabelsHourAndMin;
@synthesize arrayButtonsEvents;
@synthesize button;
@synthesize yCurrent;
@synthesize labelWithSameYOfCurrentHour;
@synthesize labelRed;
@synthesize eventsArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        arrayLabelsHourAndMin = [NSMutableArray new];
        arrayButtonsEvents = [NSMutableArray new];
        eventsArray = [NSMutableArray new];
        
        [self addLines];
    }
    return self;
}

- (void)showEvents:(NSArray *)array {
    
    [self addButtonsWithArray:array];
}

- (void)addLines {
    
    CGFloat y = 0;
    
    NSDateComponents *compNow = [NSDate componentsOfCurrentDate];
    
    for (int hour=0; hour<=23; hour++) {
        
        for (int min=0; min<=45; min=min+MINUTES_PER_LABEL) {
            
            FFHourAndMinLabel *labelHourMin = [[FFHourAndMinLabel alloc] initWithFrame:CGRectMake(0, y, self.frame.size.width, HEIGHT_CELL_MIN) date:[NSDate dateWithHour:hour min:min]];
            [labelHourMin setTextColor:[UIColor grayColor]];
            if (min == 0) {
                [labelHourMin showText];
                CGFloat width = [labelHourMin widthThatWouldFit];
                
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(labelHourMin.frame.origin.x+width+10, HEIGHT_CELL_MIN/2., self.frame.size.width-labelHourMin.frame.origin.x-width-20, 1.)];
                [view setAutoresizingMask:AR_WIDTH_HEIGHT];
                [view setBackgroundColor:[UIColor lightGrayCustom]];
                [labelHourMin addSubview:view];
            }
            [self addSubview:labelHourMin];
            [arrayLabelsHourAndMin addObject:labelHourMin];
            
            NSDateComponents *compLabel = [NSDate componentsWithHour:hour min:min];
            if (compLabel.hour == compNow.hour && min <= compNow.minute && compNow.minute < min+MINUTES_PER_LABEL) {
                labelRed = [self labelWithCurrentHourWithWidth:labelHourMin.frame.size.width yCurrent:labelHourMin.frame.origin.y];
                [self addSubview:labelRed];
                [labelRed setAlpha:0];
                labelWithSameYOfCurrentHour = labelHourMin;
            }
            
            y += HEIGHT_CELL_MIN;
        }
    }
}

- (UILabel *)labelWithCurrentHourWithWidth:(CGFloat)_width yCurrent:(CGFloat)_yCurrent {
    
    FFHourAndMinLabel *label = [[FFHourAndMinLabel alloc] initWithFrame:CGRectMake(.0, _yCurrent, _width, HEIGHT_CELL_MIN) date:[NSDate date]];
    [label showText];
    [label setTextColor:[UIColor redColor]];
    CGFloat width = [label widthThatWouldFit];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(label.frame.origin.x+width+10., HEIGHT_CELL_MIN/2., _width-label.frame.origin.x-width-20., 1.)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [view setBackgroundColor:[UIColor redColor]];
    [label addSubview:view];
    
    return label;
}

- (void)addButtonsWithArray:(NSArray *)array {
    
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[FFBlueButton class]] || [subview isKindOfClass:[GISEventLabel class]] || [subview isKindOfClass:[GISEeventShowBackgroundView class]]) {
            [subview removeFromSuperview];
        }
    }
    
    if (protocol != nil && [protocol respondsToSelector:@selector(clearAllSubviews)]) {
        [protocol clearAllSubviews];
    }

    [arrayButtonsEvents removeAllObjects];
    
    BOOL boolIsToday = [NSDate isTheSameDateTheCompA:[NSDate componentsOfCurrentDate] compB:[NSDate componentsOfDate:date]];
    [labelRed setAlpha:boolIsToday];
    [labelWithSameYOfCurrentHour setAlpha:!boolIsToday];
    
    NSArray *arrayEvents = array;
    GISEeventShowBackgroundView *view;
    NSMutableArray *repeatedCountArray = [[NSMutableArray alloc] init];
    
    int i=0;
    int count=0;
    
    if (arrayEvents) {
        
        for (FFEvent *event in arrayEvents) {
            
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
            
            FFEvent *previousEvent;
            FFBlueButton *_labelbutton;
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dateTimeBegin == %@ AND dateTimeEnd == %@", event.dateTimeBegin, event.dateTimeEnd];
            NSArray *fileArray=[arrayEvents filteredArrayUsingPredicate:predicate];
            
            
            if([fileArray count]>0)
            {
                [repeatedCountArray addObjectsFromArray:(NSArray *)fileArray];
            }
            
            if(i == 0){
                
                FFBlueButton *_button = [[FFBlueButton alloc] initWithFrame:CGRectMake(70., yTimeBegin, self.frame.size.width-95., yTimeEnd-yTimeBegin)];
                [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                [_button setBackgroundColor:[UIColor colorWithRed:179./255. green:255./255. blue:255./255. alpha:0.5]];
                [_button.titleLabel setFont:[GISFonts small]];
                [_button setTitle:[NSString stringWithFormat:@"%@ %@",@"JobID", event.stringCustomerName] forState:UIControlStateNormal];

                [_button setEvent:event];
                [self addSubview:_button];
                
                view = [[GISEeventShowBackgroundView alloc] initWithFrame:CGRectMake(_button.frame.origin.x-2 , _button.frame.origin.y,  2.0f, _button.frame.size.height)];
                [view setBackgroundColor:[UIColor colorWithRed:49./255. green:181./255. blue:247./255. alpha:0.5]];
                
                [self addSubview:view];
                
                [arrayButtonsEvents addObject:_button];
                [eventsArray addObject:_button.event];
            }else{
                
                if([arrayEvents count])
                    previousEvent= [arrayEvents objectAtIndex:i-1];
                
                FFBlueButton *_button = [[FFBlueButton alloc] initWithFrame:CGRectMake(70., yTimeBegin, self.frame.size.width-95., yTimeEnd-yTimeBegin)];
                [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                [_button setBackgroundColor:[UIColor colorWithRed:179./255. green:255./255. blue:255./255. alpha:0.5]];
                [_button.titleLabel setFont:[GISFonts small]];
                [_button setTitle:[NSString stringWithFormat:@"%@ %@",@"JobID", event.stringCustomerName] forState:UIControlStateNormal];

                [_button setEvent:event];
                [self addSubview:_button];
                
                view = [[GISEeventShowBackgroundView alloc] initWithFrame:CGRectMake(_button.frame.origin.x-2 , _button.frame.origin.y,  2.0f, _button.frame.size.height)];
                [view setBackgroundColor:[UIColor colorWithRed:49./255. green:181./255. blue:247./255. alpha:0.5]];
                
                [self addSubview:view];
                
                _labelbutton = [[FFBlueButton alloc] initWithFrame:CGRectMake(_button.frame.size.width/2-30,_button.frame.size.height-25, 50, 15)];
                [_labelbutton setBackgroundColor:[UIColor redColor]];
                [_labelbutton.titleLabel setFont:[GISFonts largeBold]];
                [_labelbutton setEvent:event];
                [_button addSubview:_labelbutton];
                
                [arrayButtonsEvents addObject:_button];
                [eventsArray addObject:_button.event];
                
                if(previousEvent != nil){
                    
                    if(([[self getCorrectTimeformdate:event.dateTimeBegin] isEqualToString:[self getCorrectTimeformdate:previousEvent.dateTimeBegin]]) && ([[self getCorrectTimeformdate:event.dateTimeEnd] isEqualToString:[self getCorrectTimeformdate:previousEvent.dateTimeEnd]])){
                        
                        [_button setHidden:TRUE];
                        [view setHidden:TRUE];
                        [_labelbutton setHidden:FALSE];
                        
                        [_labelbutton setTitle:[NSString stringWithFormat:@"%d more",[repeatedCountArray count]-1] forState:UIControlStateNormal];
                    }
                    else{
                        
                        [_labelbutton setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
                        [_button setHidden:FALSE];
                        [view setHidden:FALSE];
                        [_labelbutton setHidden:TRUE];
                        
                        NSString *btnStartTime = [self getCorrectTimeformdate:event.dateTimeBegin];
                        NSString *btnEndTime = [self getCorrectTimeformdate:event.dateTimeEnd];
                        NSString *buttonStartTime = [self getCorrectTimeformdate:previousEvent.dateTimeBegin];
                        NSString *buttonEndTime = [self getCorrectTimeformdate:previousEvent.dateTimeEnd];
                        
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        [formatter setDateFormat:@"hh:mm a"];
                        
                        NSDate *startTime1= [formatter dateFromString:btnStartTime];
                        NSDate *startTime2 = [formatter dateFromString:buttonStartTime];
                        
                        NSDate *endTime1= [formatter dateFromString:btnEndTime];
                        NSDate *endTime2 = [formatter dateFromString:buttonEndTime];
                        
                        
                        NSComparisonResult startTimeresult = [startTime1 compare:startTime2];
                        NSComparisonResult endTimeresult = [endTime1 compare:endTime2];
                        if(startTimeresult == NSOrderedDescending || endTimeresult == NSOrderedDescending)
                        {
                            CGRect frame  = _button.frame;
                            frame.origin.x = _button.frame.origin.x+12;
                            _button.frame = frame;
                            
                            CGRect viewFrame  = view.frame;
                            viewFrame.origin.x = _button.frame.origin.x-2;
                            view.frame = viewFrame;
                            
                            [self bringSubviewToFront:_button];
                            
                        }
                        else if(startTimeresult == NSOrderedAscending || endTimeresult == NSOrderedAscending)
                        {
                            CGRect frame  = _button.frame;
                            frame.origin.x = _button.frame.origin.x+12;
                            _button.frame = frame;
                            
                            CGRect viewFrame  = view.frame;
                            viewFrame.origin.x = _button.frame.origin.x-2;
                            view.frame = viewFrame;
                            
                            [self bringSubviewToFront:_button];
                        }
                        else
                        {
                            
                        }
                    }
                }else{
                    count = 0;
                }
                
                
            }
            
            i++;
        }
    }
}

#pragma mark - Button Action

- (IBAction)buttonAction:(id)sender {
    
    button = (FFBlueButton *)sender;
    
    NSMutableArray *btnArray = [[NSMutableArray alloc] init];
    for(FFBlueButton *btn in arrayButtonsEvents)
    {
        if([[self eventDisplayFormat:btn.event.dateDay] isEqualToString:[self eventDisplayFormat:button.event.dateDay]]){
            
//            int btnStartTime = [self getTimeformdate:btn.event.dateTimeBegin].intValue;
//            int btnEndTime = [self getTimeformdate:btn.event.dateTimeEnd].intValue;
//            int buttonStartTime = [self getTimeformdate:button.event.dateTimeBegin].intValue;
//            int buttonEndTime = [self getTimeformdate:button.event.dateTimeEnd].intValue;

            
            //if(([[self getTimeformdate:btn.event.dateTimeBegin] isEqualToString:[self getTimeformdate:button.event.dateTimeBegin]]) || ([[self getTimeformdate:btn.event.dateTimeEnd] isEqualToString:[self getTimeformdate:button.event.dateTimeEnd]])){ //|| (btnStartTime > buttonStartTime && btnEndTime < buttonEndTime)){
             if(([[self getCorrectTimeformdate:btn.event.dateTimeBegin] isEqualToString:[self getCorrectTimeformdate:button.event.dateTimeBegin]]) && ([[self getCorrectTimeformdate:btn.event.dateTimeEnd] isEqualToString:[self getCorrectTimeformdate:button.event.dateTimeEnd]])){
                
                [btnArray addObject:btn];
                
            }
        }
    }

    
    GISAppDelegate *appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if (protocol != nil && [protocol respondsToSelector:@selector(showViewDetailsWithEvent:cell:)]) {
        if([appDelegate.jobEventsArray count] >0)
           [appDelegate.jobEventsArray removeAllObjects];
        
        [appDelegate.jobEventsArray addObjectsFromArray:(NSArray *)btnArray];
        [protocol showViewDetailsWithEvent:button.event cell:self];
        
    }
}

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

-(NSString *)getTimeformdate:(NSDate *)localdate{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *dateStr = [dateFormat stringFromDate:localdate];
    NSDate *myDate = [dateFormat dateFromString:dateStr];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"hh:mm a"];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSLocale *curentLocale = [NSLocale currentLocale];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[curentLocale localeIdentifier]]];
//    
//    NSString *timeString = [dateFormatter stringFromDate:myDate];
    
    dateFormatter.dateFormat = @"HH:mm";
    NSString *pmamDateString = [dateFormatter stringFromDate:myDate];
    
    NSString *hourString;
    
    NSRange newRange = [pmamDateString rangeOfString:@":"];
    if(newRange.location != NSNotFound) {
        hourString = [pmamDateString substringToIndex:newRange.location];
    }


    
    return hourString;
}

-(NSString *)getCorrectTimeformdate:(NSDate *)localdate{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *dateStr = [dateFormat stringFromDate:localdate];
    NSDate *myDate = [dateFormat dateFromString:dateStr];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"hh:mm a"];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSLocale *curentLocale = [NSLocale currentLocale];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[curentLocale localeIdentifier]]];
    
    //NSString *timeString = [dateFormatter stringFromDate:myDate];
    
    dateFormatter.dateFormat = @"hh:mm a";
    NSString *timeString = [dateFormatter stringFromDate:myDate];
    
    return timeString;
}

//#pragma mark - FFEventDetailPopoverController Protocol
//
//- (void)showPopoverEditWithEvent:(Event *)_event {
//    
//    popoverControllerEditar = [[FFEditEventPopoverController alloc] initWithEvent:_event];
//    [popoverControllerEditar setProtocol:self];
//    
//    [popoverControllerEditar presentPopoverFromRect:button.frame
//                                             inView:self
//                           permittedArrowDirections:UIPopoverArrowDirectionAny
//                                           animated:YES];
//}
//
//#pragma mark - FFEditEventPopoverController Protocol
//
//- (void)saveEditedEvent:(Event *)eventNew {
//    
//    if (protocol != nil && [protocol respondsToSelector:@selector(saveEditedEvent:ofCell:atIndex:)]) {
//        [protocol saveEditedEvent:eventNew ofCell:self atIndex:[arrayButtonsEvents indexOfObject:button]];
//    }
//}
//
//- (void)deleteEvent {
//
//    if (protocol != nil && [protocol respondsToSelector:@selector(deleteEventOfCell:atIndex:)]) {
//        [protocol deleteEventOfCell:self atIndex:[arrayButtonsEvents indexOfObject:button]];
//    }
//}

@end
