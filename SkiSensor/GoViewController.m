//
//  GoViewController.m
//  SkiSensor
//
//  Created by Enrique Acedo Dorado on 18/3/15.
//  Copyright (c) 2015 Enrique Acedo Dorado. All rights reserved.
//

#import "GoViewController.h"
#import <CoreMotion/CoreMotion.h>
#import <MessageUI/MessageUI.h>


@interface GoViewController ()

@end

@implementation GoViewController

@synthesize goButton;
@synthesize reset;
@synthesize panel;
bool running;

NSMutableArray *valores_y_ac;
NSMutableArray *valores_z_ac;
NSMutableArray *valores_x_ac;

NSMutableArray *valores_x;
NSMutableArray *valores_y;
NSMutableArray *valores_z;



- (void)viewDidLoad {
    [super viewDidLoad];
    panel.delegate = self;
    reset.hidden = true;
    reset.layer.cornerRadius = 14;
    
    valores_x_ac = [[NSMutableArray alloc] init];
    valores_y_ac = [[NSMutableArray alloc] init];
    valores_z_ac = [[NSMutableArray alloc] init];
    valores_x = [[NSMutableArray alloc] init];
    valores_y = [[NSMutableArray alloc] init];
    valores_z = [[NSMutableArray alloc] init];
    
    
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .01;
    self.motionManager.gyroUpdateInterval = .01;
    
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

/**
 Cada vez que se presiona el boton de start/stop se ejecuta este metodo.
 - Si no se estaba ejecutando se empieza a ejecutar(guardar los valores en arrays)
 - Si se estaba ejecutando paro la ejecucion y calculo puntuación, pendiente y numero de giros
 **/
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
        [self calcularGiros];
        [self transformarArrays ];
        
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
        [valores_x addObject:[NSNumber numberWithDouble:rotation.x]];
        [valores_y addObject:[NSNumber numberWithDouble:rotation.y]];
        [valores_z addObject:[NSNumber numberWithDouble:rotation.z]];
    }
}

/**
 Elimina los datos de los arrays donde guardo los valores del giroscopio
 **/
- (IBAction)resetMaxValues:(id)sender {
    self.puntuacion.text = [NSString stringWithFormat:@" 0"];
    self.pendiente.text = [NSString stringWithFormat:@" 0"];
    self.curva.text = [NSString stringWithFormat:@" 0"];
    
    [valores_x_ac removeAllObjects];
    [valores_y_ac removeAllObjects];
    [valores_z_ac removeAllObjects];
    
    [valores_x removeAllObjects];
    [valores_y removeAllObjects];
    [valores_z removeAllObjects];
    
    reset.hidden = true;
}

/**
 Calcula la puntuacion de la bajada en funcion de la pendiente.
 - A mayor pendiente mayor necesidad de angulacion de los esquis
 **/
-(void)calcularPuntuacion:(double)pendiente{
    double angulacion_media = 0;
    double puntuacion = 0;
    for(NSNumber *i in valores_x_ac){
        angulacion_media += fabs([i doubleValue]);
    }
    
    angulacion_media = fabs(angulacion_media / valores_x_ac.count * 100);
    
    puntuacion = 100 - fabs(pendiente - angulacion_media);
    
    self.puntuacion.text = [NSString stringWithFormat:@"%.0f",puntuacion];
    
}//calcularPuntuacion

/**
 Calcula la pendiente media de la bajada
 **/
- (double)calcularPendiente{
    
    double pendiente_media = 0;
    double suma = 0;
    for(NSNumber *i in valores_y_ac){
        suma += fabs([i doubleValue]);
    }
    
    pendiente_media = suma / valores_y_ac.count * 100;
    self.pendiente.text = [NSString stringWithFormat:@"%.0f %%",pendiente_media];
    
    return pendiente_media;
    
}//calcularPendiente

/**
 Calcula el numero de giros de la bajada
 **/
-(void) calcularGiros{
    double giros = 0;
    double media_x;
    bool corte_1 = false;
    bool corte_2 = false;
    
    for(NSNumber *i in valores_x_ac){
        media_x += fabs([i doubleValue]);
    }
    media_x = media_x / valores_x_ac.count;
    
    for(int i = 1; i < valores_x_ac.count; i++){
        if([valores_x_ac[i] doubleValue] > 0){
            if(!corte_1){
                corte_1 = true;
            }
        }else{
            if(!corte_2){
                corte_2 = true;
            }
        }//if-else
        
        if(corte_1 && corte_2){
            giros++;
            corte_1 = false;
            corte_2 = false;
        }
    }//for
    
    self.curva.text = [NSString stringWithFormat:@"%.0f",giros];
    
}//calcularGiros


- (IBAction)transformarArrays {
    NSMutableString *emailBody_x;
    NSMutableString *emailBody_y;
    NSMutableString *emailBody_z;
    NSMutableString *emailBody_x_ac;
    NSMutableString *emailBody_y_ac;
    NSMutableString *emailBody_z_ac;
    
    emailBody_x =[valores_x componentsJoinedByString:@"\n"];
    emailBody_y =[valores_y componentsJoinedByString:@"\n"];
    emailBody_z =[valores_z componentsJoinedByString:@"\n"];
    emailBody_x_ac =[valores_x_ac componentsJoinedByString:@"\n"];
    emailBody_y_ac =[valores_y_ac componentsJoinedByString:@"\n"];
    emailBody_z_ac =[valores_z_ac componentsJoinedByString:@"\n"];
    
    NSString *emailBody;
    
    emailBody = [NSString stringWithFormat:(@"x:\n%@ \ny:\n%@ \nz:\n%@ \nx_ac:\n%@ \ny_ac:\n%@ \nz_ac:\n%@"),emailBody_x,emailBody_y,emailBody_z,emailBody_x_ac,emailBody_y_ac,emailBody_z_ac];
    
    self.panel.text = emailBody;
}

- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
}


@end

