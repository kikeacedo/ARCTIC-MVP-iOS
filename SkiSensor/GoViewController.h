//
//  GoViewController.h
//  SkiSensor
//
//  Created by Enrique Acedo Dorado on 18/3/15.
//  Copyright (c) 2015 Enrique Acedo Dorado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>


@interface GoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *goButton;

@property (strong, nonatomic) CMMotionManager *motionManager;

@property (strong, nonatomic) IBOutlet UILabel *accX;
@property (strong, nonatomic) IBOutlet UILabel *accY;
@property (strong, nonatomic) IBOutlet UILabel *accZ;


@property (strong, nonatomic) IBOutlet UILabel *rotX;
@property (strong, nonatomic) IBOutlet UILabel *rotY;
@property (strong, nonatomic) IBOutlet UILabel *rotZ;

- (IBAction)resetMaxValues:(id)sender;

- (IBAction)changeImage:(id)sender;

@end

