//
//  AFSECustomMovieTableViewCell.h
//  TVMaze
//
//  Created by admin on 24/04/2018.
//  Copyright © 2018 Advantage FSE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFSECustomMovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end
