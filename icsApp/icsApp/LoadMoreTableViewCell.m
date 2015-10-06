//
//  LoadMoreTableViewCell.m
//  icsApp
//
//  Created by Jobelle Vallega on 6/18/15.
//  Copyright (c) 2015 Jobelle Vallega. All rights reserved.
//

#import "LoadMoreTableViewCell.h"

@implementation LoadMoreTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)loadMorePressed:(id)sender {
    
    [self.delegate didPressLoadMoreFromCell:self];
}

@end
