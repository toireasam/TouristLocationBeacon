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


// Methods
+(void)RecieveParseDetails:(NSString *)locationName;
-(void)UpdateLabels;
@end
