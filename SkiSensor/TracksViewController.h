//
//  TracksViewController.h
//  SkiSensor
//
//  Created by Enrique Acedo Dorado on 20/3/15.
//  Copyright (c) 2015 Enrique Acedo Dorado. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TracksViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource> {
  
    IBOutlet UITableView *tableView;
    
    NSMutableArray *datos;
    
}
- (IBAction)addData:(id)sender;


@end
