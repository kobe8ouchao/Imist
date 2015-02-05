//
//  PickSoundVC.m
//  Imist
//
//  Created by chao.ou on 15/1/22.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import "PickSoundVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface PickSoundVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *soundTable;
@property (nonatomic,strong) NSMutableArray *soundlist;
@property (nonatomic,strong) NSMutableArray *musiclist;
@property AVAudioPlayer *audioPlayer;
@end

@implementation PickSoundVC

@synthesize soundTable, soundlist, musiclist;
- (void)viewDidLoad {
    [super viewDidLoad];
//    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
//    self.navigationItem.rightBarButtonItem = saveItem;
    self.navigationController.navigationBar.topItem.title = @"Select Days";
    //init device tableview
    UITableView *_table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height) style:UITableViewStylePlain];
    _table.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                               UIViewAutoresizingFlexibleHeight);
    _table.delegate = self;
    _table.dataSource = self;
    _table.showsVerticalScrollIndicator = NO;
    _table.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    _table.backgroundColor=[UIColor clearColor];
    
    self.soundTable=_table;
    [self.view addSubview:self.soundTable];
    soundlist = [[NSMutableArray alloc] initWithObjects:@"Bicker",@"Chirp",@"Hill stream",@"Rain",@"Wave",@"Zen", nil];
    musiclist = [[NSMutableArray alloc] init];
    
    [self loadSound];
}

- (void)playSound:(NSString*)name{
    
    NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:name ofType:@"mp3"];
    NSURL *audioFileURL = [NSURL fileURLWithPath:audioFilePath];
    NSError *error = nil;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileURL error:&error];
    [self.audioPlayer setDelegate:self];
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
    if (self.audioPlayer == nil)
        NSLog(@"Error playing sound. %@", [error description]);
    else
        [self.audioPlayer play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- table delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"System sound";
    }else {
        return @"Music sound";
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.soundlist count];
    }else {
        return [self.musiclist count];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        /*SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)[self.soundlist objectAtIndex:indexPath.row],&soundID);
        AudioServicesPlaySystemSound(soundID);*/
        [self playSound:[self.soundlist objectAtIndex:indexPath.row]];
        
        NSLog(@"File url: %@", [[self.soundlist objectAtIndex:indexPath.row] description]);
        if ([delegate respondsToSelector:@selector(saveSound:)]) {
            [delegate saveSound:[self.soundlist objectAtIndex:indexPath.row]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else {
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SoundCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = [[self.soundlist objectAtIndex:indexPath.row] lastPathComponent];
    }else {
        cell.textLabel.text = [self.musiclist objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)loadSound
{
    __block typeof(self) currentBlockSel_f = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MPMediaQuery *everything = [[MPMediaQuery alloc] init];
        NSLog(@"Logging items from a generic query...");
        NSArray *itemsFromGenericQuery = [everything items];
        for (MPMediaItem *song in itemsFromGenericQuery) {
            NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
            [currentBlockSel_f.musiclist addObject:songTitle];
        }
        
        /*NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSURL *directoryURL = [NSURL URLWithString:@"/System/Library/Audio/UISounds"];
        NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
        
        NSDirectoryEnumerator *enumerator = [fileManager
                                             enumeratorAtURL:directoryURL
                                             includingPropertiesForKeys:keys
                                             options:0
                                             errorHandler:^(NSURL *url, NSError *error) {
                                                 // Handle the error.
                                                 // Return YES if the enumeration should continue after the error.
                                                 return YES;
                                             }];
        
        for (NSURL *url in enumerator) {
            NSError *error;
            NSNumber *isDirectory = nil;
            if (![url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
                // handle error
            }
            else if (! [isDirectory boolValue]) {
                [currentBlockSel_f.soundlist addObject:url];
            }
        }*/

        dispatch_async(dispatch_get_main_queue(), ^{
            [currentBlockSel_f.soundTable reloadData];
        });
    
    });
    
    
}

-(void)save
{
    
}

@end
