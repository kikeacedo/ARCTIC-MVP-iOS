//
//  TracksViewController.m
//  SkiSensor
//
//  Created by Enrique Acedo Dorado on 20/3/15.
//  Copyright (c) 2015 Enrique Acedo Dorado. All rights reserved.
//

#import "TracksViewController.h"

@interface TracksViewController ()


@end

@implementation TracksViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    datos = [[NSMutableArray alloc]initWithObjects:
             
             @"http://www.Apprendemos.com",
             
             @"http://www.AhoraQuien.es",
             
             @"http://www.AndNowWho.com",
             
             @"http://www.Apple.com",
             
             nil];
    
}

// Método necesario para devolver el número de secciones de la tabla, por lo general será siempre 1..
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// Necesario para indicar el número de filas de la tabla, esto suele ir ligado al tamaño de un array de elementos a mostrar..
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [datos count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Normalmente recuperaremos del array, según la posicion de la fila..
    NSString *datoString = [datos objectAtIndex:indexPath.row];
    // Creamos la celda (o fila).
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    // Y le establecemos el texto de nuestro dato a una de las filas.
    cell.textLabel.text = datoString;
    
    // Y finalizamos devolviendo la celda
    return cell;
}

- (IBAction)addData:(id)sender {
   
}


@end