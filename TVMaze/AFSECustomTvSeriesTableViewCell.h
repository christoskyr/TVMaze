//
//  AFSECustomTvSeriesTableViewCell.h
//  TVMaze
//
//  Created by admin on 24/04/2018.
//  Copyright © 2018 Advantage FSE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFSECustomTvSeriesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *tvSeriesImage;
@property (weak, nonatomic) IBOutlet UILabel *tvSeriesTitle;
@property (weak, nonatomic) IBOutlet UILabel *tvSeriesRating;

@end
