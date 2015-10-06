//
//  MainListTableViewCell.h
//  icsApp
//
//  Created by Jobelle Vallega on 6/8/15.
//  Copyright (c) 2015 Jobelle Vallega. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *dImage;
@property (weak, nonatomic) IBOutlet UILabel *dTitle;
@property (weak, nonatomic) IBOutlet UILabel *dTeaser;
@property (weak, nonatomic) IBOutlet UIView *imageContainer;

@end
