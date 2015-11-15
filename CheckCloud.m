//
//  CheckCloud.m
//  Example
//
//  Created by Toireasa Moley on 15/11/2015.
//  Copyright © 2015 jaalee. All rights reserved.
//

#import "CheckCloud.h"
#import "JLEDistancesDemo.h"

@implementation CheckCloud
+(void)CheckIdInCloud
{
    NSLog(@"frig knows");
}
+(void)Check:(NSString *)check
{
    
    NSLog(check);
    
   /* @try {
        PFObject *testBeacon = [PFObject objectWithClassName:@"TouristLocations"];
        testBeacon[@"UUID"] = check;
        [testBeacon saveInBackground];
        
        
    }
    
    @catch ( NSException *e ) {
        
    }*/
    PFQuery *query = [PFQuery queryWithClassName:@"TouristLocations"];
    [query whereKey:@"UUID" equalTo:check];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            if(objects.count == 0)
            {
                NSLog(@"testing none were found");
                [JLEDistancesDemo ResultFromParse:NULL andLocationName:NULL];
            }
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                NSLog(@"%@",object);
                NSString *TouristLocationName = object[@"TouristLocationName"];

                //lets send back the info
                [JLEDistancesDemo ResultFromParse:@"The id was found" andLocationName:TouristLocationName];
            
                
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        
        }
        
    }];
    
}

@end
