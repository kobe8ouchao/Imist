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
#import "ProgressHUD.h"

@interface PickSoundVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *soundTable;
@property (nonatomic,strong) NSMutableArray *defautlist;
@property (nonatomic,strong) NSMutableArray *soundlist;
@property (nonatomic,strong) NSMutableArray *musiclist;
@property (nonatomic,strong) NSString *selectedSound;
@property (nonatomic,strong) NSString *selectedSoundName;
@property (nonatomic,strong) AVAudioPlayer *player;
@end

@implementation PickSoundVC
@synthesize soundTable, soundlist, defautlist, musiclist, player, selectedSound;
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveItem;
    self.navigationController.navigationBar.topItem.title = @"Select Sound";
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
    defautlist = [[NSMutableArray alloc] initWithObjects:@"Bicker",@"Chirp",@"Hill stream",@"Rain",@"Wave",@"Zen", nil];
//    soundlist = [[NSMutableArray alloc] init];
    musiclist = [[NSMutableArray alloc] init];
    [self loadSound];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playSound:(NSString*)name{
    
    NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:name ofType:@"mp3"];
    NSURL *audioFileURL = [NSURL fileURLWithPath:audioFilePath];
    NSError *error = nil;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileURL error:&error];
//    [self.player setDelegate:self];
    [self.player prepareToPlay];
    [self.player play];
    if (self.player == nil)
        NSLog(@"Error playing sound. %@", [error description]);
    else
        [self.player play];
}
#pragma mark -- table delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(1 == section){
        return @"Music sound";
    }else {
        return @"Imist sound";
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
    if(0 == section){
        return [self.defautlist count];
    }else {
        return [self.musiclist count];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [player stop];
    if (indexPath.section == 0) {
        [self playSound:[self.defautlist objectAtIndex:indexPath.row]];

        if ( self.selectedSound && [self.selectedSound isEqualToString:[self.defautlist objectAtIndex:indexPath.row] ])
        {
            self.selectedSound = @"";
        } else {
            self.selectedSound = [self.defautlist objectAtIndex:indexPath.row];
            self.selectedSoundName = self.selectedSound;
        }
        
    }else if(1 == indexPath.section){
        NSMutableDictionary *musicDict = [self.musiclist objectAtIndex:indexPath.row];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:[musicDict objectForKey:@"url"] error:nil];
        [player play];
        if (  self.selectedSound && [self.selectedSound isEqualToString:[[musicDict objectForKey:@"url"] absoluteString]])
        {
            self.selectedSound = @"";
        } else {
            self.selectedSound = [[musicDict objectForKey:@"url"] absoluteString];
            self.selectedSoundName = [musicDict objectForKey:@"title"];
        }
    }else{
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)[self.soundlist objectAtIndex:indexPath.row],&soundID);
        AudioServicesPlaySystemSound(soundID);
        if ( self.selectedSound && [self.selectedSound isEqualToString:[[self.soundlist objectAtIndex:indexPath.row] lastPathComponent]])
        {
            self.selectedSound = @"";
        } else {
            self.selectedSound = [[self.soundlist objectAtIndex:indexPath.row] lastPathComponent];
        }

    }
    [self.soundTable reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SoundCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = [self.defautlist objectAtIndex:indexPath.row];
        if ([self.selectedSound isEqualToString:[self.defautlist objectAtIndex:indexPath.row]])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else if(1 == indexPath.section){
        NSMutableDictionary *musicDict = [self.musiclist objectAtIndex:indexPath.row];
        if ( [self.selectedSound isEqualToString:[[musicDict objectForKey:@"url"]  absoluteString]])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = [musicDict valueForKey:@"title"];
    }else {
        cell.textLabel.text = [[self.soundlist objectAtIndex:indexPath.row] lastPathComponent];
        if ([self.selectedSound isEqualToString:[[self.soundlist objectAtIndex:indexPath.row] lastPathComponent]])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
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
            if ([song valueForProperty:  MPMediaItemPropertyAssetURL]) {
                 NSMutableDictionary *musicDict = [[NSMutableDictionary alloc] init];
                [musicDict setValue:[song valueForProperty:MPMediaItemPropertyTitle] forKey:@"title"];
                [musicDict setValue: [song valueForProperty:MPMediaItemPropertyAssetURL]forKey:@"url"];
                [currentBlockSel_f.musiclist addObject:musicDict];
            }
        }
        
//        NSFileManager *fileManager = [[NSFileManager alloc] init];
//        NSURL *directoryURL = [NSURL URLWithString:@"/System/Library/Audio/UISounds"];
//        NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
//        
//        NSDirectoryEnumerator *enumerator = [fileManager
//                                             enumeratorAtURL:directoryURL
//                                             includingPropertiesForKeys:keys
//                                             options:0
//                                             errorHandler:^(NSURL *url, NSError *error) {
//                                                 // Handle the error.
//                                                 // Return YES if the enumeration should continue after the error.
//                                                 return YES;
//                                             }];
//        
//        for (NSURL *url in enumerator) {
//            NSError *error;
//            NSNumber *isDirectory = nil;
//            if (![url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
//                // handle error
//            }
//            else if (! [isDirectory boolValue]) {
//                [currentBlockSel_f.soundlist addObject:url];
//            }
//        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [currentBlockSel_f.soundTable reloadData];
        });
    
    });
    
    
}

-(void)save
{
    if (!self.selectedSound || [selectedSound isEqualToString:@""]) {
        [ProgressHUD showError:@"Please pick a sound for wakeup!"];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(saveSound:)]) {
        NSString *soundName = [NSString stringWithFormat:@"%@|%@",self.selectedSound ,self.selectedSoundName];
        [self.delegate saveSound:soundName];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
