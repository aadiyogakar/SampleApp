//
//  VideoDetailsViewController.m
//  CustomTableView
//
//  Created by Aadi Yogakar on 23/05/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import "VideoDetailsViewController.h"

@interface VideoDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UILabel *details;
@end

@implementation VideoDetailsViewController

- (void)setVideo:(Video *)video
{
    _video = video;
    [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI
{
    self.headline.text = _video.title;
    self.details.text = _video.description;
    NSURL *imageURL = [NSURL URLWithString:_video.imageURLHD];
    NSData *imageData =[NSData dataWithContentsOfURL:imageURL];
    self.videoImage.image = [UIImage imageWithData:imageData];
}

@end
