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
@property (nonatomic, strong) NSMutableArray *cars;
@property(nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;



@end

@implementation JLEDistance
@synthesize hallPreference;
NSString *locationNameText;
NSString *furtherInformationText;
NSString *categoryText;
NSString *testText;
NSArray *recipes;





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
    
//    
//    self.cars = [NSMutableArray arrayWithObjects:@"1",@"car2",@"car3",nil];
    _tableData = [NSMutableArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
    


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
        self.testTextLbl.text = testText;
        self.furtherInformationTxt.text = furtherInformationText;
        
        
//        [self.cars addObject:testText];
//        NSString *new = @"new";
////        [_tableData addObject:ne];
//           NSLog(@"%@", _tableData);
//  [self.tableView reloadData];
        NSString *testText2;
        if(testText == NULL)
        {
            testText2 = @"null";
            
        }
        else

        {
        
        BOOL isTheObjectThere = [_tableData containsObject: testText];
            if(isTheObjectThere == false)
            {
        testText2 = testText;
            }
            else
                testText2=@"null";
        }
        
        if(testText2 == @"null")
        {
            // nothing
        }
        else
        {
        [_tableData addObject:testText2];
        NSLog(@"%@", _tableData);
                       NSLog(@"%@", _tableData);
            NSLog(@"%@", _tableData);
        [self.tableView reloadData];
        }
        
        if(tmpString != NULL)
        {
            [_tableData addObject:tmpString];
         

        }
        else if(tmpString2 != NULL)
        {
               [_tableData addObject:tmpString2];
        }
        else{
            //nothing
        }
        
        
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
NSString *tmpString;
NSString *tmpString2;

+(void)takeArray:(NSMutableArray *)array andSecond:(NSMutableArray *)information
{
    NSLog(@"array is from the correct place");
    NSLog(@"%@", array);
  
    NSString *str = [array componentsJoinedByString:@" "];
    testText = str;
    if(array <= 2)
    {
    tmpString = [array objectAtIndex:0];
    NSLog(tmpString);
    }
    else {
    tmpString2 = [array objectAtIndex:1];
    NSLog(tmpString2);
    }
  
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [_tableData objectAtIndex:indexPath.row];
    return cell;
}
@end


