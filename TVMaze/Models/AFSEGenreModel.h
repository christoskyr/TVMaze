//
//  AFSEGenreModel.h
//  TVMaze
//
//  Created by admin on 30/04/2018.
//  Copyright © 2018 Advantage FSE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFSEGenreModel : NSObject

@property(strong, nonatomic) NSNumber * _id;
@property(strong, nonatomic) NSString * name;

- (instancetype) initWithId:(NSNumber *) _id
                       Name:(NSString *) name;

@end
