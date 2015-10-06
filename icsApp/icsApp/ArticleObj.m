//
//  ArticleObj.m
//  icsApp
//
//  Created by Jobelle Vallega on 6/8/15.
//  Copyright (c) 2015 Jobelle Vallega. All rights reserved.
//

#import "ArticleObj.h"

@implementation ArticleObj

-(id)initWithAuthor:(NSString *)author
            andBody:(NSString *)body
        andHeadline:(NSString *)headlne
          andImages:(NSArray *)images
     andPublishDate:(NSString *)publishDate
          andTeaser:(NSString *)teaser
        andHasImage:(BOOL)hasImage{
    
    
    self = [super init];
    self.author = author;
    self.body = body;
    self.headLine = headlne;
    self.images = [images mutableCopy];
    self.publishDate = publishDate;
    self.hasImage = hasImage;
    self.teaser = teaser;
    
    
    return self;
}

@end
