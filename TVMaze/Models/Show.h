//
//  Show.h
//  TVMaze
//
//  Created by admin on 11/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Show : NSObject

@property(strong, nonatomic) NSString * title;
@property(strong, nonatomic) NSString * summary;
@property(strong, nonatomic) NSString * image;
@property(strong, nonatomic) NSString * averageRating;

- (instancetype) initWithTitle:(NSString *) title
                   Summary:(NSString *) summary
                   Image:(NSString *) image
                   Rating: (NSString *) rating;
@end
