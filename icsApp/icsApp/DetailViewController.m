//
//  DetailViewController.m
//  icsApp
//
//  Created by Jobelle Vallega on 6/8/15.
//  Copyright (c) 2015 Jobelle Vallega. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (IBAction)backPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *dTtitle;
@property (weak, nonatomic) IBOutlet UILabel *dByLine;
@property (weak, nonatomic) IBOutlet UIImageView *dImage;
@property (weak, nonatomic) IBOutlet UIWebView *dWebView;
@property (weak, nonatomic) IBOutlet UILabel *storyTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *appName;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appName.text = [NSString stringWithFormat:@"%@ ::", _APP_NAME ];
    
    if (self.type == story_featured) {
        self.storyTypeLabel.text = @"Featured ::";
    }
    else{
        self.storyTypeLabel.text = @"Latest ::";
    }
    
    self.dTtitle.text = self.passedObj.headline;
    NSString *date = [[GlobalConfig sharedInstance] getStringGivenDate:self.passedObj.published_at];
    self.dByLine.text = [NSString stringWithFormat:@"By: %@ | %@", self.passedObj.author,date ];
    NSLog(@"passed image url %@", self.passedImageUrl);
    [self.dImage sd_setImageWithURL:[NSURL URLWithString:self.passedImageUrl] placeholderImage:[UIImage imageNamed:@"placeHolderBig.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    
    }];
    self.dWebView.opaque = NO;
    self.dWebView.backgroundColor = [UIColor clearColor];
    NSLog(@"PassedObj : %@", self.passedObj.body);
    NSString *html = [[GlobalConfig sharedInstance] appendImagetoHTML:self.passedObj.body andImageLink:self.passedImageUrl];
    [self.dWebView loadHTMLString:html baseURL:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
