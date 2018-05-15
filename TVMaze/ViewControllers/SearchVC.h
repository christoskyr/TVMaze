//
//  SearchVC.h
//  TVMaze
//
//  Created by admin on 15/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickShowTypeVC.h"
#import "CustomTableViewCell.h"
#import "Show.h"

@interface SearchVC : UIViewController <PickShowTypeVCDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableOfShows;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)didClickMe:(id)sender;


@end
