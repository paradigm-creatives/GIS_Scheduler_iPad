//
//  GISDashBoardSPCell.m
//  GIS_Scheduler
//
//  Created by Anand on 01/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISDashBoardSPCell.h"
#import "GISFonts.h"

@implementation GISDashBoardSPCell

- (void)awakeFromNib
{
    // Initialization code
    
    [_payType_btn.titleLabel setFont:[GISFonts normal]];
    [_response_status_btn.titleLabel setFont:[GISFonts normal]];
    [_endTime_Label setFont:[GISFonts normal]];
    [_startTime_Label setFont:[GISFonts normal]];
    [_jobdate_Label setFont:[GISFonts normal]];
    [_jobId_Label setFont:[GISFonts normal]];
    [_totalHours_Label setFont:[GISFonts normal]];
    [_eventType_Label setFont:[GISFonts normal]];
    [_serviceProviderName_Label setFont:[GISFonts normal]];
    [_requestedDate_Label setFont:[GISFonts normal]];
    
    [_payType_btn.titleLabel setFont:[GISFonts small]];
    [_response_status_btn.titleLabel setFont:[GISFonts small]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state


}

@end
