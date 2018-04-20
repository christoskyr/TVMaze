//
//  PickShowTypeVC.m
//  TVMaze
//
//  Created by admin on 18/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

#import "PickShowTypeVC.h"

@implementation PickShowTypeVC

- (IBAction)didSelecteMovie:(UIButton *)sender {
    [self.delegate pickShowVC:self didSelectButton:sender];
}
- (IBAction)didSelectTvShow:(UIButton *)sender {
    [self.delegate pickShowVC:self didSelectButton:sender];
}
@end
