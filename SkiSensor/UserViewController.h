//
//  UserViewController.h
//  SkiSensor
//
//  Created by Enrique Acedo Dorado on 18/3/15.
//  Copyright (c) 2015 Enrique Acedo Dorado. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;

-(IBAction)textFieldReturn:(id)sender;


@end

