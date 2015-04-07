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
@property (nonatomic,strong) NSMutableArray *selectedSonglist;
@property (nonatomic,strong) AVAudioPlayer *player;
@property (nonatomic,strong) NSDictionary *selectMusicDictionary;
@property (nonatomic,assign) BOOL selectedInMediaPicker;
@end

@implementation PickSoundVC
@synthesize soundTable, soundlist, defautlist, musiclist, player, selectedSound;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Sound";
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveItem;
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                                         initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    //AppDelegate *application = (AppDelegate*)[UIApplication sharedApplication].delegate;
    //self.navigationController.navigationBar.topItem.title = application.defaultBTServer.selectPeripheralInfo.name;
    //init device tableview
    UITableView *_table=[[UITableView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20,  self.view.frame.size.height) style:UITableViewStylePlain];
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
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    self.selectedSonglist = [[defaults objectForKey:@"selectedSonglist"] mutableCopy];

    if(self.selectedSonglist==nil)
        self.selectedSonglist = [[NSMutableArray alloc]init];
    
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
        return @"SONGS";
    }else if(0 == section){
        return @"IMIST SOUNDS";
    }else return @"None";
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

-(void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view
       forSection:(NSInteger)section
{
    if ([view isKindOfClass: [UITableViewHeaderFooterView class]])
    {
        UITableViewHeaderFooterView *castView = (UITableViewHeaderFooterView *) view;
        UIView *content = castView.contentView;
        UIColor *color = [UIColor colorWith256Red:222 green:222 blue:221]; // substitute your color here
        content.backgroundColor = color;
        [castView.textLabel setTextColor:[UIColor colorWith256Red:129 green:189 blue:82]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(0 == section){
        return [self.defautlist count];
    }else if(1 == section){
        return ([self.selectedSonglist count]+1);
    }else{
        return 1;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {

        if ( self.selectedSound && [self.selectedSound isEqualToString:[self.defautlist objectAtIndex:indexPath.row] ])
        {
            //self.selectedSound = @"";
            if(player.isPlaying){
                [player stop];
            }
            else{
                [self playSound:[self.defautlist objectAtIndex:indexPath.row]];
            }
        } else {
            self.selectedSound = [self.defautlist objectAtIndex:indexPath.row];
            self.selectedSoundName = self.selectedSound;
            [self playSound:[self.defautlist objectAtIndex:indexPath.row]];
        }
        
    }
    else if(1 == indexPath.section){
        if([self.selectedSonglist count] > 0 && indexPath.row < [self.selectedSonglist count]){
            NSMutableDictionary *musicDict = [self.selectedSonglist objectAtIndex:indexPath.row];
            
            if (self.selectedSound && [self.selectedSound isEqualToString:[musicDict objectForKey:@"url"]])
            {
                //self.selectedSound = @"";
                if(player.isPlaying){
                    [player stop];
                }
                else{
                    player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[musicDict objectForKey:@"url"]] error:nil];
                    [player play];
                }
            } else {
                self.selectedSound = [musicDict objectForKey:@"url"];
                self.selectedSoundName = [musicDict objectForKey:@"title"];
                player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[musicDict objectForKey:@"url"]] error:nil];
                [player play];
            }
        }
        else{
            MPMediaPickerController *picker = [[MPMediaPickerController alloc]init];
            picker.delegate = self;
            picker.allowsPickingMultipleItems = NO;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
    else{
//        SystemSoundID soundID;
//        AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)[self.soundlist objectAtIndex:indexPath.row],&soundID);
//        AudioServicesPlaySystemSound(soundID);
//        if ( self.selectedSound && [self.selectedSound isEqualToString:[[self.soundlist objectAtIndex:indexPath.row] lastPathComponent]])
//        {
//            self.selectedSound = @"";
//        } else {
//            self.selectedSound = [[self.soundlist objectAtIndex:indexPath.row] lastPathComponent];
//        }
        self.selectedSound = @"";
        self.selectedSoundName = @"";

    }
    [self.soundTable reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SoundCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_scancell_green.png"]];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
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
    }
    else if(1 == indexPath.section){
        if([self.selectedSonglist count]>0 && indexPath.row < [self.selectedSonglist count]){
            NSMutableDictionary *musicDict = [self.selectedSonglist objectAtIndex:indexPath.row];
            if ( [self.selectedSound isEqualToString:[musicDict objectForKey:@"url"]])
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            cell.textLabel.text = [musicDict valueForKey:@"title"];
        }
        else {
            cell.textLabel.text = @"Pick a song";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    else {
//        cell.textLabel.text = [[self.soundlist objectAtIndex:indexPath.row] lastPathComponent];
//        if ([self.selectedSound isEqualToString:[[self.soundlist objectAtIndex:indexPath.row] lastPathComponent]])
//        {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        }
//        else
//        {
//            cell.accessoryType = UITableViewCellAccessoryNone;
//        }
        cell.textLabel.text = @"None";
        if ( [self.selectedSound isEqualToString:@""]){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) collection {
    
    
    MPMediaItem *item = [[collection items] objectAtIndex:0];
    
    
    self.selectMusicDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[item valueForProperty:MPMediaItemPropertyTitle],@"title",
                                                                            [[item valueForProperty:MPMediaItemPropertyAssetURL] absoluteString] ,@"url", nil];
    
    NSURL *url = [item valueForProperty:MPMediaItemPropertyAssetURL];
    //Play the item using AVPlayer
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player play];
    self.selectedInMediaPicker = YES;
}

-(void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker{
    /*insert your code*/
    [self dismissModalViewControllerAnimated:YES];
    if(self.selectedInMediaPicker == YES){//selected some song
        self.selectedInMediaPicker = NO;
        [self.player stop];
        self.selectedSoundName = [self.selectMusicDictionary valueForKey:@"title"];
        self.selectedSound =  [self.selectMusicDictionary valueForKey:@"url"];
        if([self.selectedSonglist containsObject:self.selectMusicDictionary] == NO){
            [self.selectedSonglist addObject:self.selectMusicDictionary];
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.selectedSonglist forKey:@"selectedSonglist"];
            [defaults synchronize];
            [self.soundTable reloadData];
        }
        else{
            [self.soundTable reloadData];//update the checkmark
        }
    }

    NSArray * selectedCopy = [NSArray arrayWithArray:self.selectedSonglist];
    for(NSDictionary * musicDic in selectedCopy){
        if([musiclist containsObject:musicDic] == NO){
            [self.selectedSonglist removeObject:musicDic];
        }
    }
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
                [musicDict setValue: [[song valueForProperty:MPMediaItemPropertyAssetURL] absoluteString] forKey:@"url"];
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
        //[ProgressHUD showError:@"Please pick a sound for wakeup!"];
        //return;
    }
    if ([self.delegate respondsToSelector:@selector(saveSound:)]) {
        NSString *soundName = [NSString stringWithFormat:@"%@|%@",self.selectedSound ,self.selectedSoundName];
        [self.delegate saveSound:soundName];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
