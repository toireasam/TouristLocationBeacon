//
//  CheckCloud.h
//  Example
//
//  Created by Toireasa Moley on 15/11/2015.
//  Copyright © 2015 jaalee. All rights reserved.
//

#import <Parse/Parse.h>

@interface CheckCloud : PFObject
+ (void)CheckIdInCloud;
+(void)Check:(NSString *)check;
@end
