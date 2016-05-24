//
//  VideoDetailsViewController.h
//  CustomTableView
//
//  Created by Aadi Yogakar on 23/05/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import "VideoViewController.h"
#import "Video.h"

@interface VideoDetailsViewController : UIViewController

@property (strong, nonatomic) Video *video;

- (void) updateUI;

@end
