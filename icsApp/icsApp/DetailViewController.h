//
//  DetailViewController.h
//  icsApp
//
//  Created by Jobelle Vallega on 6/8/15.
//  Copyright (c) 2015 Jobelle Vallega. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, strong) ArticleModel *passedObj;
@property (nonatomic, strong) NSString *passedImageUrl;
@property (nonatomic) storyType type;

@end
