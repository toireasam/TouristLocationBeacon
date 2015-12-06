//
//  SettingsViewController.h
//  TouristLocationBeacon
//
//  Created by Toireasa Moley on 05/12/2015.
//  Copyright © 2015 jaalee. All rights reserved.
//

#import "ViewController.h"

@interface SettingsViewController : ViewController
@property (weak, nonatomic) NSUserDefaults *prefs;
-(void)setPrefs;
@end
