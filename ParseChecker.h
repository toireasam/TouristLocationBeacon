//
//  Parse.h
//  Example
//
//  Created by Toireasa Moley on 15/11/2015.
//  Copyright © 2015 jaalee. All rights reserved.
//

#import <Parse/Parse.h>

@interface ParseChecker : PFObject
+(void)CheckIdInParse:(NSString *)uuid;
@end
