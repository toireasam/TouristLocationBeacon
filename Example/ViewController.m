//
//  ViewController.m
//  Example
//
//  Created by jaalee on 14-4-22.
//  Copyright (c) 2014年 jaalee. All rights reserved.
//

#import "ViewController.h"
#import "JLEDistance.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *myButton;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UITextField *myText;



@end

@implementation ViewController
@synthesize prefs;
NSString * text;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.mySwitch addTarget:self
                      action:@selector(stateChanged:) forControlEvents:UIControlEventValueChanged];
    
    PFQuery *query = [PFQuery queryWithClassName:@"TouristLocations"];
    [query whereKey:@"UUID" equalTo:@"EBEFD083-70A2-47C8-9837-E7B5634DF524"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
     {
         if(!error)
         {
             PFFile *file = [object objectForKey:@"LocationImage"];
             // file has not been downloaded yet, we just have a handle on this file
             
             // Tell the PFImageView about your file
             self.imageHolder.file = file;
             
             // Now tell PFImageView to download the file asynchronously
             [self.imageHolder loadInBackground];
         }
     }];
    
    
  

  prefs = [NSUserDefaults standardUserDefaults];
    
  NSString *myString = [prefs stringForKey:@"NewString"];
    NSLog(myString);
    NSLog(@"hi");
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(UIButton *)sender {
            if ([self.mySwitch isOn]) {
        self.myText.text = @"The Switch is Off";
        NSLog(@"Switch is off");
        // saving an NSString
        [self.mySwitch setOn:NO animated:YES];
                
    } else {
        self.myText.text = @"The Switch is On";
        [self.mySwitch setOn:YES animated:YES];
    }
}

- (void)stateChanged:(UISwitch *)switchState
{
    if ([switchState isOn]) {
        self.myText.text = @"The Switch is On";
        text = @"on";
    } else {
        self.myText.text = @"The Switch is Off";
        text = @"off";
        [self setPrefs];
    }
}

-(void)setPrefs
{
    prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setObject:@"Offhere" forKey:@"NewString"];
    [prefs synchronize];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"distance"]) {
        JLEDistance *nextVC = (JLEDistance *)[segue destinationViewController];
        nextVC.hallPreference = text;
        
     
    }
}


@end
