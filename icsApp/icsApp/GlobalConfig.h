//
//  GlobalConfig.h
//
//
//  Created by Jobelle Vallega on 5/30/2015.
//  Copyright (c) 2015 Jobelle Vallega. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GlobalConfig : NSObject

+ (GlobalConfig *)sharedInstance;

-(ArticleObj *)precessJSON:(id)JSON;
-(NSString *)processImageLink:(NSString *)oldLink;
-(NSString *)appendImagetoHTML:(NSString *)html andImageLink:(NSString *)imageLink;
-(NSString *)getImageLinkFromJSON:(id)JSON;
-(NSString *)getStringGivenDate:(NSDate *)date;
-(NSDate *)processDateGivenString:(NSString *)stringDate;

@end
