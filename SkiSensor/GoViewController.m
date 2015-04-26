//
//  GoViewController.m
//  SkiSensor
//
//  Created by Enrique Acedo Dorado on 18/3/15.
//  Copyright (c) 2015 Enrique Acedo Dorado. All rights reserved.
//

#import "GoViewController.h"
#import <CoreMotion/CoreMotion.h>


@interface GoViewController ()

@end

@implementation GoViewController

@synthesize goButton;
@synthesize reset;
bool running;
double mi_puntuacion;


//double valores_x_ac[2000];
NSMutableArray *valores_y_ac;
NSMutableArray *valores_z_ac;
NSMutableArray *valores_x_ac;

NSMutableArray *valores_x;
NSMutableArray *valores_y;
NSMutableArray *valores_z;



- (void)viewDidLoad {
    [super viewDidLoad];
    mi_puntuacion = 0;
    reset.hidden = true;
    reset.layer.cornerRadius = 8;
    
    valores_x_ac = [[NSMutableArray alloc] init];
    valores_y_ac = [[NSMutableArray alloc] init];
    valores_z_ac = [[NSMutableArray alloc] init];
    valores_x = [[NSMutableArray alloc] init];
    valores_y = [[NSMutableArray alloc] init];
    valores_z = [[NSMutableArray alloc] init];
    
    
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .1;
    self.motionManager.gyroUpdateInterval = .1;
    
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

- (IBAction)start_stop:(id)sender {
    if(!running){
        UIImage* goButtonImg =[UIImage imageNamed:@"stop.png"];
        [goButton setImage:goButtonImg forState:UIControlStateNormal];
        running = true;
        reset.hidden = true;
        
        
    }else{
        UIImage* goButtonImg =[UIImage imageNamed:@"start.png"];
        [goButton setImage:goButtonImg forState:UIControlStateNormal];
        running = false;
        reset.hidden = false;
 
        [self calcularPuntuacion:[self calcularPendiente]];
        
    }
    
}

/**
 Voy guardando los datos de la aceleracion en diferentes arrays
 **/
-(void)outputAccelertionData:(CMAcceleration)acceleration{
    if(running){
        [valores_x_ac addObject:[NSNumber numberWithDouble:acceleration.x]];
        [valores_y_ac addObject:[NSNumber numberWithDouble:acceleration.y]];
        [valores_z_ac addObject:[NSNumber numberWithDouble:acceleration.z]];
    }
    
    
    
}
/**
 Voy guardando los datos de la rotacion en diferentes arrays
 **/
-(void)outputRotationData:(CMRotationRate)rotation{
    if(running){
        [valores_x addObject:[NSString stringWithFormat:@" %.2f",rotation.x]];
        [valores_y addObject:[NSString stringWithFormat:@" %.2f",rotation.y]];
        [valores_z addObject:[NSString stringWithFormat:@" %.2f",rotation.z]];
    }
}

- (IBAction)resetMaxValues:(id)sender {
    mi_puntuacion = 0.0;
    self.puntuacion.text = [NSString stringWithFormat:@" %.0f",mi_puntuacion];
    valores_x_ac.removeAllObjects;
    valores_y_ac.removeAllObjects;
    reset.hidden = true;
}

-(void)calcularPuntuacion:(double)pendiente{
    double angulacion_media = 0;
    double suma = 0;
    double puntuacion = 0;
    for(NSNumber *i in valores_x_ac){
        suma += fabs([i doubleValue]);
    }
    
    angulacion_media = fabs(suma / valores_x_ac.count * 100);
    
    puntuacion = 100 - fabs(pendiente - angulacion_media);
    
    self.puntuacion.text = [NSString stringWithFormat:@" %.0f",puntuacion];

}//calcularPuntuacion

- (double)calcularPendiente{
    
    double pendiente_media = 0;
    double suma = 0;
    for(NSNumber *i in valores_y_ac){
        suma += fabs([i doubleValue]);
    }
    
    pendiente_media = suma / valores_y_ac.count * 100;
    self.pendiente.text = [NSString stringWithFormat:@" %.0f %%",pendiente_media];
    
    return pendiente_media;
    
}//calcularPendiente


@end

