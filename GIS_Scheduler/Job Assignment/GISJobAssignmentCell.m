//
//  GISJobAssignmentCell.m
//  GIS_Scheduler
//
//  Created by Paradigm on 22/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISJobAssignmentCell.h"
#import "GISFonts.h"

@implementation GISJobAssignmentCell

- (void)awakeFromNib
{
    // Initialization code
    
    self.jobId_label.font=[GISFonts normal];
    self.jobDate_label.font=[GISFonts normal];
    self.startTime_label.font=[GISFonts normal];
    self.endTime_label.font=[GISFonts normal];
    self.serviceProvider_label.font=[GISFonts normal];
    self.serviceProviderType_label.font=[GISFonts normal];
    self.payType_label.font=[GISFonts normal];
    self.location_label.font=[GISFonts normal];
    self.account_label.font = [GISFonts normal];
    self.requestor_label.font=[GISFonts normal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
