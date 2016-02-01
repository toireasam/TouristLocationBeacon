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
#import <PARSEUI/PFImageView.h>
#import <Parse/Parse.h>




static NSString * const kIdentifier = @"jaalee.Example";

@interface JLEDistance ()<JLEBeaconManagerDelegate>

@property (nonatomic, strong) JLEBeaconManager  *beaconManager;
@property (nonatomic, strong) JLEBeaconRegion  *beaconRegion;
@property (nonatomic, strong) PFFile  *file;



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
    
    [self.beaconManager startMonitoringForRegion:self.beaconRegion];
    
    [_beaconManager startRangingBeaconsInRegion:_beaconRegion];
    NSLog(@"the random string is");
    
    NSLog(hallPreference);
    



        [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]]; 

   
   
 
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
    if(uuid != NULL)
    {
    [self sendToParse:uuid];
    }
    
    
}

-(void)UpdateLabels
{
    if([categoryText isEqual:@"Museum"] && [hallPreference isEqual:@"off"])
    {
        // Don't populate with info
        self.touirstLocationNameLbl.text = @"you turned museum's off";
        self.furtherInformationTxt.text = @"";
        self.mProximityUUID.text = @"";
        self.imageHolderScreenTwo = NULL;
    }
    else
    {
  
   
        self.touirstLocationNameLbl.text = locationNameText;
        self.furtherInformationTxt.text = furtherInformationText;
        
        [self UpdateImage];
     
    }
    

}

-(void)UpdateImage
{
    // Don't populate with info
    PFQuery *query = [PFQuery queryWithClassName:@"TouristLocations"];
    [query whereKey:@"UUID" equalTo:@"EBEFD083-70A2-47C8-9837-E7B5634DF524"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
     {
         if(!error)
         {
             _file = [object objectForKey:@"LocationImage"];
             // file has not been downloaded yet, we just have a handle on this file
             // Tell the PFImageView about your file
             self.imageHolderScreenTwo.file = _file;
             
             // Now tell PFImageView to download the file asynchronously
             [self.imageHolderScreenTwo loadInBackground];
         }
     }];

}

-(void)sendToParse:(NSString *)uuid
{
  [ParseChecker CheckIdInParse:uuid];
  [self UpdateLabels];
}


- (void)beaconManager:(JLEBeaconManager *)manager didEnterRegion:(JLEBeaconRegion *)region
{
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"Ulster Museum is nearby!";
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)beaconManager:(JLEBeaconManager *)manager didExitRegion:(JLEBeaconRegion *)region
{
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"Exit region notification";
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

+(void)RecieveParseDetails:(NSString *)locationName FurtherInformation:(NSString *)furtherInformation andCategory:category
{
    locationNameText = locationName;
    furtherInformationText = furtherInformation;
    categoryText = category;
}

+(void)takeArray:(NSMutableArray *)array
{
    NSLog(@"array is from the correct place");
    NSLog(@"%@", array);
    
}
@end


