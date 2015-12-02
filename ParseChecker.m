//
//  CheckCloud.m
//  Example
//
//  Created by Toireasa Moley on 15/11/2015.
//  Copyright © 2015 jaalee. All rights reserved.
//

#import "ParseChecker.h"
#import "JLEDistance.h"

@implementation ParseChecker

+(void)CheckIdInParse:(NSString *)check
{
    
    PFQuery *query = [PFQuery queryWithClassName:@"TouristLocations"];
    [query whereKey:@"UUID" equalTo:check];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            if(objects.count == 0)
            {
                // No beacons were found
                
            }
            for (PFObject *object in objects)
            {
                
                NSLog(@"%@", object.objectId);
                NSLog(@"%@",object);
                NSString *touristLocationName = object[@"TouristLocationName"];
                NSString *furtherInformation= object[@"Information"];
                NSString *category = object[@"Category"];
                
                // Lets send back the info
                [JLEDistance RecieveParseDetails:touristLocationName FurtherInformation:furtherInformation andCategory:category];
                
            }
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            
        }
        
    }];
    
}

@end
