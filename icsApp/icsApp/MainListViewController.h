//
//  MainListViewController.h
//  icsApp
//
//  Created by Jobelle Vallega on 6/8/15.
//  Copyright (c) 2015 Jobelle Vallega. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadMoreTableViewCell.h"

@interface MainListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, loadmoredelegate, UIActionSheetDelegate, UISearchBarDelegate>

@end
