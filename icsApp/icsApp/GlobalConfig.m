//
//  GlobalConfig.h
//
//
//  Created by Jobelle Vallega on 5/30/2015.
//  Copyright (c) 2015 Jobelle Vallega. All rights reserved.
//


#import "GlobalConfig.h"


@implementation GlobalConfig

+ (GlobalConfig *)sharedInstance {
    static GlobalConfig *sharedInstance;
    if (sharedInstance == nil) {
        sharedInstance = [[GlobalConfig alloc] init];
    }
    return sharedInstance;
}

-(ArticleObj *)precessJSON:(id)JSON{
    
    NSDictionary *main = JSON;
    NSString *author = [main  objectForKey:_field_auther];
    NSString *body = [main objectForKey:_field_body];
    NSString *headline = [main objectForKey:_field_headline];
    NSArray *images = [main  objectForKey:_field_images];
    BOOL hasImages  = images.count > 0 ? YES : NO;
    NSString *publishDate = [main  objectForKey:_field_pubDate];
    NSString *teaser = [main  objectForKey:_field_teaser];
    
    ArticleObj *thisObj = [[ArticleObj alloc] initWithAuthor:author andBody:body andHeadline:headline andImages:images andPublishDate:publishDate andTeaser:teaser andHasImage:hasImages];
    
    return thisObj;
    
}
-(NSString *)processImageLink:(NSString *)oldLink
{
    NSMutableString *newString  = [NSMutableString stringWithString:oldLink];
    [newString replaceOccurrencesOfString:@"https://s3.amazonaws.com/jnswire_staging/jns-media/" withString:@"https://jnswire.s3.amazonaws.com/jns-media/" options:2 range:NSMakeRange(0, newString.length)];
  
    [newString replaceOccurrencesOfString:@"large_" withString:@"" options:2 range:NSMakeRange(0, newString.length)];
    return newString;
    
}
-(NSString *)appendImagetoHTML:(NSString *)html andImageLink:(NSString *)imageLink{

    NSString *image = [NSString  stringWithFormat:@"<img src='%@' style='width:300px;height:auto;'>", imageLink ];
    
    NSString *finalString =[NSString stringWithFormat:@"%@%@", image, html ];
    return finalString;
}

-(NSString *)getImageLinkFromJSON:(id)JSON{
    NSDictionary *response = JSON;
    NSArray *images = [response objectForKey:@"images"];
    if (images.count > 0) {
        return [images objectAtIndex:0];
    }
    else{
        return @"";
    }
}
-(NSDate *)processDateGivenString:(NSString *)stringDate{
   
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
   [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate* date = [formatter dateFromString:stringDate];
    return date;
 
}

-(NSString *)getStringGivenDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, yyyy-MM-dd"];
    NSString *stringDate = [formatter stringFromDate:date];
    return stringDate;
}
@end

