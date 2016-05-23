//
//  VideoDetailsViewController.m
//  CustomTableView
//
//  Created by Aadi Yogakar on 23/05/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import "VideoDetailsViewController.h"

@interface VideoDetailsViewController ()

@end

@implementation VideoDetailsViewController

- (void)setVideo:(Video *)video
{
    _video = video;
    if (self.view.window) {
        [self updateUI];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI
{
    
}

@end
