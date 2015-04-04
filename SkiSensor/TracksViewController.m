//
//  TracksViewController.m
//  SkiSensor
//
//  Created by Enrique Acedo Dorado on 20/3/15.
//  Copyright (c) 2015 Enrique Acedo Dorado. All rights reserved.
//

#import "TracksViewController.h"

@interface TracksViewController ()

@property (nonatomic, strong) NSMutableArray *tableData;
    


@end

@implementation TracksViewController{
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize table data
//    tableData = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    _tableData = [NSMutableArray array];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"celda.png"];
    
    return cell;
}




@end