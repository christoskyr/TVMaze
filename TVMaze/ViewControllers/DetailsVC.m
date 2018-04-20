//
//  DetailsVC.m
//  TVMaze
//
//  Created by admin on 15/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

#import "DetailsVC.h"
#import "NSString_stripHtml.h"

@interface DetailsVC ()

@end

@implementation DetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleDetails.text = self.show.title;
    self.summaryDetails.text = [self.show.summary stripHtml];

    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: self.show.image]];
    self.imageDetails.image = [UIImage imageWithData: imageData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
