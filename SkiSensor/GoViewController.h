//
//  GoViewController.h
//  SkiSensor
//
//  Created by Enrique Acedo Dorado on 18/3/15.
//  Copyright (c) 2015 Enrique Acedo Dorado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>


@interface GoViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *goButton;

@property (strong, nonatomic) CMMotionManager *motionManager;


@property (strong, nonatomic) IBOutlet UILabel *pendiente;
@property (strong, nonatomic) IBOutlet UILabel *curva;

@property (strong, nonatomic) IBOutlet UITextView *panel;


@property (strong, nonatomic) IBOutlet UIButton *reset;



@property (strong, nonatomic) IBOutlet UILabel *puntuacion;

- (IBAction)resetMaxValues:(id)sender;

- (IBAction)start_stop:(id)sender;

@end

