//
//  Show.m
//  TVMaze
//
//  Created by admin on 11/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

#import "Show.h"

@implementation Show

- (instancetype) initWithTitle:(NSString *) title
                     Summary:(NSString *) summary
                     Image:(NSString *) image
                     Rating: (NSString *) rating
{
    self = [super init];
    
    if(self){
        self.title = title;
        self.summary = summary;
        self.image = image;
        self.averageRating = rating;
    }
    
    return self;
}

@end
