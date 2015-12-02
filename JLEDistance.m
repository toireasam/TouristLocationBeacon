//
//  JLEDistancesDemo.m
//  Example
//
//  Created by jaalee on 14-4-23.
//  Copyright (c) 2014年 jaalee. All rights reserved.
//

#import "JLEDistance.h"
#import <JAALEEBeaconSDK/JAALEEBeaconIOSSDK.h>
#import "ParseChecker.h"



static NSString * const kIdentifier = @"jaalee.Example";

@interface JLEDistance ()<JLEBeaconManagerDelegate>

@property (nonatomic, strong) JLEBeaconManager  *beaconManager;
@property (nonatomic, strong) JLEBeaconRegion  *beaconRegion;

@end

@implementation JLEDistance
@synthesize hallPreference;
NSString *locationNameText;
NSString *furtherInformationText;
NSString *categoryText;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _beaconManager = [[JLEBeaconManager alloc] init];
    _beaconManager.delegate = self;
    
    _beaconRegion = [[JLEBeaconRegion alloc] initWithProximityUUID:JAALEE_PROXIMITY_UUID identifier:kIdentifier];
    
    [_beaconManager startRangingBeaconsInRegion:_beaconRegion];
    NSLog(@"the random string is");
    
    NSLog(hallPreference);
  
 
        
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - JLEBeaconManager delegate

- (void)beaconManager:(JLEBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(JLEBeaconRegion *)region
{
    JLEBeacon *temp = [beacons firstObject];
    self.mProximityUUID.text = [temp.proximityUUID UUIDString];
    self.mMajorValue.text = [NSString stringWithFormat:@"%d", [temp.major intValue]];
    self.mMinorValue.text = [NSString stringWithFormat:@"%d", [temp.major intValue]];
    self.mAccValue.text = [NSString stringWithFormat:@"%.2f", temp.accuracy];
    
    // Go to parse and check if UUID is there
    NSString *uuid = [temp.proximityUUID UUIDString];
    [self sendToParse:uuid];
    
}

-(void)UpdateLabels
{
    if([categoryText isEqual:@"Museum"] && [hallPreference isEqual:@"off"])
    {
        // Don't populate with info
        self.touirstLocationNameLbl.text = @"check preferences";
        self.furtherInformationLbl.text = @"check preferences";
        self.mProximityUUID.text = @"check preferences";
    }
    else
    {
        // Don't populate with info
        self.touirstLocationNameLbl.text = locationNameText;
        self.furtherInformationLbl.text = furtherInformationText;
        
    }
}

-(void)sendToParse:(NSString *)uuid
{
  [ParseChecker CheckIdInParse:uuid];
  [self UpdateLabels];
}

+(void)RecieveParseDetails:(NSString *)locationName FurtherInformation:(NSString *)furtherInformation andCategory:category
{
    locationNameText = locationName;
    furtherInformationText = furtherInformation;
    categoryText = category;
}


@end


