//
//  PickShowTypeVC.h
//  TVMaze
//
//  Created by admin on 18/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickShowTypeVC;
@protocol PickShowTypeVCDelegate

//When making a delegate, it is a good pattern to pass as first argument, the id of who calls you (caller of delegate)
- (void) pickShowVC:(PickShowTypeVC *)pickShowTypeVC
        didSelectButton:(UIButton *)whoCLickedMe;

@end

@interface PickShowTypeVC : UIViewController

//the delegate property
@property (weak, nonatomic) id<PickShowTypeVCDelegate> delegate;


/**
 <#Description#>

 @param sender <#sender description#>
 */
- (IBAction)didSelectTvShow:(UIButton *)sender;

/**
 <#Description#>

 @param sender <#sender description#>
 */
- (IBAction)didSelecteMovie:(UIButton *)sender;



@end
