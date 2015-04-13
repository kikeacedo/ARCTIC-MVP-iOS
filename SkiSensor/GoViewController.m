//
//  GoViewController.m
//  SkiSensor
//
//  Created by Enrique Acedo Dorado on 18/3/15.
//  Copyright (c) 2015 Enrique Acedo Dorado. All rights reserved.
//

#import "GoViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "TracksViewController.h"


@interface GoViewController ()

@end

@implementation GoViewController

@synthesize goButton;
bool running;
double mi_puntuacion;
double lado;


- (void)viewDidLoad {
    [super viewDidLoad];
    mi_puntuacion = 50;
    self.puntuacion.text = [NSString stringWithFormat:@" %.0f",mi_puntuacion];
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .2;
    self.motionManager.gyroUpdateInterval = .2;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self outputAccelertionData:accelerometerData.acceleration];
                                                 if(error){
                                                     
                                                     NSLog(@"%@", error);
                                                 }
                                             }];
    
    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue]
                                    withHandler:^(CMGyroData *gyroData, NSError *error) {
                                        [self outputRotationData:gyroData.rotationRate];
                                    }];
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeImage:(id)sender {
    if(!running){
        UIImage* goButtonImg =[UIImage imageNamed:@"stop.png"];
        [goButton setImage:goButtonImg forState:UIControlStateNormal];
        running = true;
        
    }else{
        UIImage* goButtonImg =[UIImage imageNamed:@"start.png"];
        [goButton setImage:goButtonImg forState:UIControlStateNormal];
        running = false;
    }
    lado = self.segmentedControl.selectedSegmentIndex;
    self.puntuacion.text = [NSString stringWithFormat:@" %.0f",lado];

}

-(void)outputAccelertionData:(CMAcceleration)acceleration{
    if(running){
        
        self.accX.text = [NSString stringWithFormat:@" %.2fg",acceleration.x];
        self.accY.text = [NSString stringWithFormat:@" %.2fg",acceleration.y];
        self.accZ.text = [NSString stringWithFormat:@" %.2fg",acceleration.z];
        
        self.puntuacion.text = [NSString stringWithFormat:@" %.0f",mi_puntuacion];
        
    }
    
    
    
}
-(void)outputRotationData:(CMRotationRate)rotation{
    if(running){
        
        self.rotX.text = [NSString stringWithFormat:@" %.2fr/s",rotation.x];
        self.rotY.text = [NSString stringWithFormat:@" %.2fr/s",rotation.y];
        self.rotZ.text = [NSString stringWithFormat:@" %.2fr/s",rotation.z];
        self.puntuacion.text = [NSString stringWithFormat:@" %.0f",mi_puntuacion];

    }
    
}

- (IBAction)resetMaxValues:(id)sender {
    self.rotX.text= @"0";
    self.rotY.text= @"0";
    self.rotZ.text= @"0";
    
    self.accX.text= @"0";
    self.accY.text= @"0";
    self.accZ.text= @"0";
}


@end

