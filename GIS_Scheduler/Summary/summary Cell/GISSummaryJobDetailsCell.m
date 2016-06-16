//
//  GISSummaryJobDetailsCell.m
//  GIS_Scheduler
//
//  Created by Anand on 29/10/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISSummaryJobDetailsCell.h"
#import "GISFonts.h"


@implementation GISSummaryJobDetailsCell

- (void)awakeFromNib
{
    // Initialization code
    
    [_jobIdLabel setFont:[GISFonts small]];
    [_jobDateLabel setFont:[GISFonts small]];
    [_startTime setFont:[GISFonts small]];
    [_endTimeLabel setFont:[GISFonts small]];
    [_typeOfServiceLabel setFont:[GISFonts small]];
    [_serviceProviderLabel setFont:[GISFonts small]];
    [_paytypeLabel setFont:[GISFonts small]];
    [_timelyLabel setFont:[GISFonts small]];
    [_billAmountLabel setFont:[GISFonts small]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

@end
