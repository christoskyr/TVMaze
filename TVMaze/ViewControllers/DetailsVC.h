//
//  DetailsVC.h
//  TVMaze
//
//  Created by admin on 15/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Show.h"

@interface DetailsVC : UIViewController

@property (strong, nonatomic) Show *show;
@property (weak, nonatomic) IBOutlet UIImageView *imageDetails;
@property (weak, nonatomic) IBOutlet UILabel *titleDetails;
@property (weak, nonatomic) IBOutlet UILabel *summaryDetails;

@end
