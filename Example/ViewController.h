//
//  ViewController.h
//  Example
//
//  Created by jaalee on 14-4-22.
//  Copyright (c) 2014年 jaalee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) NSUserDefaults *prefs;
-(void)setPrefs;
@end
