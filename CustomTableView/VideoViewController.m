//
//  VideoViewController.m
//  CustomTableView
//
//  Created by Aadi Yogakar on 23/05/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import "VideoViewController.h"
#import "Video.h"

@interface VideoViewController ()

@end

@implementation VideoViewController {
    NSMutableArray *videos;
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
    for (i = 0; i < 5 ;i++) {
        video = [Video new];
        snippet = [[result objectAtIndex:i] objectForKey:@"snippet"];
        thumbnails =[snippet objectForKey:@"thumbnails"];
        video.imageURL = [[thumbnails objectForKey:@"default"] objectForKey:@"url"];
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
    
    NSURL *url = [NSURL URLWithString:@"https://www.googleapis.com/youtube/v3/search?part=id%2Csnippet&maxResults=5&q=flipkart&key=AIzaSyCkwJOFCAkQyr7tJHBbAxpJTQxywv516L8"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    [self getVideoDetailsFromJSONData:data];
    
    Video * video1 = [Video new];
    video1.title = @"one";
    video1.description = @"fsd";
    
    [videos addObject:video1];
    
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
