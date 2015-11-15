//
//  CheckInCloud.m
//  Example
//
//  Created by Toireasa Moley on 15/11/2015.
//  Copyright © 2015 jaalee. All rights reserved.
//

#import "CheckInCloud.h"
#import "Parse.h"




@implementation CheckInCloud
+(void)CheckIdInCloud
{
    NSLog(@"frig knows");
}
+(void)Check:(NSString *)check
{
 
    NSLog(check);
    
    @try {
        PFObject *testBeacon = [PFObject objectWithClassName:@"TouristLocations"];
        testBeacon[@"UUID"] = [temp.proximityUUID UUIDString];
        [testBeacon saveInBackground];
        
        
    }
    
    @catch ( NSException *e ) {
        
    }
    PFQuery *query = [PFQuery queryWithClassName:@"TouristLocations"];
    [query whereKey:@"UUID" equalTo:@"EBEFD083-70A2-47C8-9837-E7B5634DF524"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];

}
@end
