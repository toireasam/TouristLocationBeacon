//
//  JLEDistancesDemo.h
//  Example
//
//  Created by jaalee on 14-4-23.
//  Copyright (c) 2014年 jaalee. All rights reserved.
//

#import "ViewController.h"

@interface JLEDistance : ViewController
// Properties
@property (weak, nonatomic) IBOutlet UILabel *mProximityUUID;
@property (weak, nonatomic) IBOutlet UILabel *mMajorValue;
@property (weak, nonatomic) IBOutlet UILabel *mMinorValue;
@property (weak, nonatomic) IBOutlet UILabel *mAccValue;
@property (weak, nonatomic) IBOutlet UILabel *touirstLocationNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *furtherInformationLbl;
@property (nonatomic, strong) NSString *hallPreference;




// Methods
+(void)RecieveParseDetails:(NSString *)locationName FurtherInformation:(NSString *)furtherInformation andCategory:(NSString *)category;
-(void)UpdateLabels;
+(void)sendToParse:(NSString *)uuid;
@end
