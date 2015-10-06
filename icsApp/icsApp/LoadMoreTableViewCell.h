//
//  LoadMoreTableViewCell.h
//  icsApp
//
//  Created by Jobelle Vallega on 6/18/15.
//  Copyright (c) 2015 Jobelle Vallega. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol loadmoredelegate <NSObject>

-(void)didPressLoadMoreFromCell:(UITableViewCell *)thiscell;

@end


@interface LoadMoreTableViewCell : UITableViewCell


@property (nonatomic, strong) id <loadmoredelegate> delegate;
@end
