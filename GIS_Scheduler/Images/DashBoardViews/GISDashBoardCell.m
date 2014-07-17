//
//  GISDashBoardCell.m
//  GIS_Scheduler
//
//  Created by Paradigm on 11/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISDashBoardCell.h"

@implementation GISDashBoardCell
//
//@synthesize accountName_Label;
//@synthesize requestID_Label;
//@synthesize eventType_Label;
//@synthesize otherServices_Label;
//@synthesize earliestDate_Label;
//@synthesize approvalDate_Label;
//@synthesize approvedBy_Label;
//@synthesize status_Label;
//@synthesize scheduler_Label;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
