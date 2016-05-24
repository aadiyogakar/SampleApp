//
//  VideoViewController.m
//  CustomTableView
//
//  Created by Aadi Yogakar on 23/05/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import "VideoViewController.h"
#import "Video.h"
#import "VideoDetailsViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController {
    NSMutableArray *videos;
}

- (Video *)findVideoWithTitle:(NSString *)title
{
    for (Video *video in videos) {
        if ([video.title isEqualToString:title]) {
            return video;
            break;
        }
    }
    Video *v = nil;
    return v;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"details"]) {
        if ([segue.destinationViewController isKindOfClass:[VideoDetailsViewController class]]) {
            VideoDetailsViewController *vdvc = (VideoDetailsViewController *)segue.destinationViewController;
            UITableViewCell *cell = (UITableViewCell *)sender;
            UILabel *titleLabel = (UILabel *)[cell viewWithTag:101];
            NSString *title = titleLabel.text;
            Video *video = [self findVideoWithTitle:title];
            [vdvc setVideo:video];
        }
    }
}

- (void)getVideoDetailsFromJSONData: (NSData *)data
{
    int i;
    NSError *e;
    NSDictionary *response =[NSJSONSerialization JSONObjectWithData:data options:0 error:&e];
    NSArray *result = [response objectForKey:@"items"];
    if (!videos) {
        videos = [[NSMutableArray alloc] init];
    }
    Video *video = nil;
    NSDictionary *snippet;
    NSDictionary *thumbnails;
    NSDictionary *id;
    for (i = 0; i < 5 ;i++) {
        video = [Video new];
        snippet = [[result objectAtIndex:i] objectForKey:@"snippet"];
        id = [[result objectAtIndex:i] objectForKey:@"id"];
        video.videoId = [id objectForKey:@"videoId"];
        thumbnails =[snippet objectForKey:@"thumbnails"];
        video.imageURL = [[thumbnails objectForKey:@"default"] objectForKey:@"url"];
        video.imageURLHD = [[thumbnails objectForKey:@"high"] objectForKey:@"url"];
        video.title = [snippet objectForKey:@"title"];
        video.description = [snippet objectForKey:@"description"];
        [videos addObject:video];
        video = nil;
        snippet = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Video List";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:backButton];
    
    NSURL *url = [NSURL URLWithString:@"https://www.googleapis.com/youtube/v3/search?part=id%2Csnippet&maxResults=5&q=bayern&key=AIzaSyCkwJOFCAkQyr7tJHBbAxpJTQxywv516L8"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    [self getVideoDetailsFromJSONData:data];
    
    // Remove table cell separator
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableView.contentInset = inset;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return videos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Video *video = [videos objectAtIndex:indexPath.row];
    UILabel *videoTitleLabel = (UILabel *)[cell viewWithTag:101];
    videoTitleLabel.text = video.title;
    
    UIImageView *imageLabel = (UIImageView *)[cell viewWithTag:103];
    NSURL *imageURL = [NSURL URLWithString:video.imageURL];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    imageLabel.image = [UIImage imageWithData:imageData];
    
    
    return cell;
}


@end
