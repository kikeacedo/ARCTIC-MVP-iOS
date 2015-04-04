//
//  UserViewController.m
//  SkiSensor
//
//  Created by Enrique Acedo Dorado on 18/3/15.
//  Copyright (c) 2015 Enrique Acedo Dorado. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

@synthesize name;
@synthesize age;
NSInteger level;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    age.keyboardType = UIKeyboardTypeNumberPad;
    

}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    
    name.text = name.text;
    age.text = age.text;
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Guardado con exito" message: [NSString stringWithFormat:@"Name: %@\nAge: %@\nLevel: %ld",name.text, age.text, (long)level] delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];

    [alert show];
}

- (IBAction)nivelEsqui:(UISegmentedControl *)sender {
    
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    level = segmentedControl.selectedSegmentIndex;
    
    //level = &selectedSegment;
    
}



@end
