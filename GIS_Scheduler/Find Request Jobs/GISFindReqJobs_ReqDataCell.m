//
//  FindReqJobs_ReqDataCell.m
//  GIS_Scheduler
//
//  Created by Paradigm on 05/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISFindReqJobs_ReqDataCell.h"
#import "GISConstants.h"
@implementation GISFindReqJobs_ReqDataCell

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
    _startDate_label.text=NSLocalizedStringFromTable(@"Start_Date", TABLE, nil);
    _endDate_label.text=NSLocalizedStringFromTable(@"End_Date", TABLE, nil);
    _startTime_label.text=NSLocalizedStringFromTable(@"Start_Time", TABLE, nil);
    _endTime_label.text=NSLocalizedStringFromTable(@"End_Time", TABLE, nil);
    _requestor_label.text=NSLocalizedStringFromTable(@"Requestor", TABLE, nil);
    _registeredConsumer_label.text=NSLocalizedStringFromTable(@"Registered_Consumer", TABLE, nil);
    _generalLocation_label.text=NSLocalizedStringFromTable(@"General_Location", TABLE, nil);
    _payLevel_label.text=NSLocalizedStringFromTable(@"Pay_Level", TABLE, nil);
    _primaryAudience_label.text=NSLocalizedStringFromTable(@"Primary_Audience", TABLE, nil);
    _model_label.text=NSLocalizedStringFromTable(@"Model", TABLE, nil);
    _openToPublic_label.text=NSLocalizedStringFromTable(@"Open_to_Public", TABLE, nil);
    _reqDataToSearch_label.text=NSLocalizedStringFromTable(@"Request_Data_to_Search", TABLE, nil);
    _jobDataToSearch_label.text=NSLocalizedStringFromTable(@"Job_Data_to_Search", TABLE, nil);
    _weekDays_Label.text=NSLocalizedStringFromTable(@"Choose_Weekdays", TABLE, nil);
    _monday_Label.text=NSLocalizedStringFromTable(@"monday", TABLE, nil);
    _tuesday_Label.text=NSLocalizedStringFromTable(@"tuesday", TABLE, nil);
    _wednesday_Label.text=NSLocalizedStringFromTable(@"wednesday", TABLE, nil);
    _thursday_Label.text=NSLocalizedStringFromTable(@"thursday", TABLE, nil);
    _friday_Label.text=NSLocalizedStringFromTable(@"friday", TABLE, nil);
    _saturday_Label.text=NSLocalizedStringFromTable(@"saturday", TABLE, nil);
    _sunday_Label.text=NSLocalizedStringFromTable(@"sunday", TABLE, nil);
     _serviceProviderType_label.text=NSLocalizedStringFromTable(@"Service_Provider_Type", TABLE, nil);
     _serviceProvider_label.text=NSLocalizedStringFromTable(@"Service_Provider", TABLE, nil);
     _filled_label.text=NSLocalizedStringFromTable(@"Filled", TABLE, nil);
     _payType_label.text=NSLocalizedStringFromTable(@"Pay_Type", TABLE, nil);
     _outOrAgency_label.text=NSLocalizedStringFromTable(@"OutORAgency", TABLE, nil);
     _createdBy_label.text=NSLocalizedStringFromTable(@"Created_By", TABLE, nil);
     _timely_label.text=NSLocalizedStringFromTable(@"Timely", TABLE, nil);
     _cancelled_label.text=NSLocalizedStringFromTable(@"Canceled", TABLE, nil);
     _timely_timely_label.text=NSLocalizedStringFromTable(@"Timely", TABLE, nil);
     _cancelDate_label.text=NSLocalizedStringFromTable(@"Cancel_Date", TABLE, nil);
    _billLevel_label.text=NSLocalizedStringFromTable(@"Bill_Level", TABLE, nil);
    _unTimely_Cancelled_label.text=NSLocalizedStringFromTable(@"untimely", TABLE, nil);
    _unTimely_timely_label.text=NSLocalizedStringFromTable(@"untimely", TABLE, nil);
    _timely_Cancelled_label.text=NSLocalizedStringFromTable(@"Timely", TABLE, nil);
    
}

@end
