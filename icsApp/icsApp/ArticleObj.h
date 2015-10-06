//
//  ArticleObj.h
//  icsApp
//
//  Created by Jobelle Vallega on 6/8/15.
//  Copyright (c) 2015 Jobelle Vallega. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleObj : NSObject

@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *headLine;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSString *publishDate;
@property (nonatomic, strong) NSString *teaser;
@property (nonatomic) BOOL hasImage;

-(id)initWithAuthor:(NSString *)author
            andBody:(NSString *)body
        andHeadline:(NSString *)headlne
          andImages:(NSArray *)images
     andPublishDate:(NSString *)publishDate
          andTeaser:(NSString *)teaser
        andHasImage:(BOOL)hasImage;



@end
