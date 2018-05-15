//
//  Show.m
//  TVMaze
//
//  Created by admin on 11/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

#import "Show.h"

#define IMAGE_URL @"https://image.tmdb.org/t/p/w500"

@implementation Show

- (instancetype) initWithTitle:(NSString *) title
                     Summary:(NSString *) summary
                     Image:(NSString *) image
                     Rating:(NSString *) rating
                     Type:(NSString *) type
                    ShowId:(NSNumber *) ShowId
                   GenreId:(NSNumber *) GenreId
{
    self = [super init];
    
    NSString *noSummaryAvailable = @"No Summary available";
    NSString *noTitleAvailble = @"No Ttile available";
    NSString *noRatingAvailable = @"No Rating available";
    NSString *noImageURL = @"http://static.tvmaze.com/images/no-img/no-img-portrait-text.png";
    NSString *noMediaTypeAvailable = @"No media type available";
    
    if(self){
        self.title = ([title isEqual:[NSNull null]] ? noTitleAvailble : title);
        self.summary = ([summary isEqual:[NSNull null]] ? noSummaryAvailable : summary);
        self.image = ([image isEqual:[NSNull null]] ? noImageURL : [IMAGE_URL stringByAppendingString:image]);
        self.averageRating = [rating isEqual:@"0.0"] || [rating isEqual:[NSNull null]] ? noRatingAvailable : rating;
        self.mediaType = ([type isEqual:[NSNull null]] ? noMediaTypeAvailable : type);
        self.ShowId = ShowId;
        self.GenreId = GenreId;
    }
    
    return self;
}

@end
