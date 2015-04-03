//
//  AddAlarmVC.m
//  Imist
//
//  Created by chao.ou on 15/1/21.
//  Copyright (c) 2015年 oc. All rights reserved.
//

#import "AddAlarmVC.h"
#import "PickDayVC.h"
#import "PickSoundVC.h"
#import "AlertSettingCell.h"
#import "RenameWakeup.h"

@interface AddAlarmVC ()<UIPickerViewDelegate,UIPickerViewDataSource,pickDayDelegate,pickSoundDelegate,pickWakeNameDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) NSArray *all;
@property (nonatomic,strong) NSArray *hours;
@property (nonatomic,strong) NSArray *minis;
@property (nonatomic,strong) UIPickerView *pickerview;
@property (nonatomic,strong) NSString *selectedHour;
@property (nonatomic,strong) NSString *selectedMinis;
@property (nonatomic,strong) NSString *ampm;
@property (nonatomic,strong) NSString *sound;
@property (nonatomic,strong) NSString *soundName;
@property (nonatomic,strong) NSString *days;
@property (nonatomic,assign) NSNumber *isAlarmOpen;
@property (nonatomic,strong) NSString *repeatString;
@property (nonatomic,strong) NSString *alarmName;
@property (nonatomic,strong) UITableView * wakeSettingTable;
@end

@implementation AddAlarmVC
@synthesize all,hours,minis,pickerview,selectedHour,selectedMinis,ampm,editAlert;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Set Wakeup";
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveItem;
    
    self.all = [NSArray arrayWithObjects:@"AM",@"PM",nil];
    self.hours = [NSArray arrayWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",nil];
    self.minis = [NSArray arrayWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",nil];
    UIPickerView * _pickerview = [[UIPickerView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200)/2, 40, 200, 200)];
    _pickerview.delegate=self;
    _pickerview.dataSource=self;
    if (self.editAlert) {
        NSString *strTime = [self.editAlert objectForKey:@"time"];
        NSArray *arrTime = [strTime componentsSeparatedByString:@":"];
        /*if ([[arrTime objectAtIndex:0] integerValue] >= 12) {
            [_pickerview selectRow:1 inComponent:0 animated:NO];
            [_pickerview selectRow:[[arrTime objectAtIndex:0] integerValue] - 12 inComponent:1 animated:NO];
        }else {
            [_pickerview selectRow:0 inComponent:0 animated:NO];
            [_pickerview selectRow:[[arrTime objectAtIndex:0] integerValue] inComponent:1 animated:NO];
        }*/
        [_pickerview selectRow:[[arrTime objectAtIndex:0] integerValue] inComponent:0 animated:NO];
        [_pickerview selectRow:[[arrTime objectAtIndex:1] integerValue] inComponent:1 animated:NO];
        self.days = [self.editAlert objectForKey:@"repeat"];
        self.sound = [self.editAlert objectForKey:@"sound"];
        self.isAlarmOpen = [self.editAlert objectForKey:@"isOpen"];
        self.alarmName = [self.editAlert objectForKey:@"alarmName"];
        self.soundName = [self.editAlert objectForKey:@"soundName"];
    }
    else{
        NSDate *now = [NSDate date];
        //NSLog(@"now date is: %@", now);
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];

        NSUInteger hour = [dateComponent hour];
        NSUInteger minute = [dateComponent minute];
        
        /*if (hour >= 12) {
            [_pickerview selectRow:1 inComponent:0 animated:NO];
            [_pickerview selectRow:(hour-12) inComponent:1 animated:NO];
        }else {
            [_pickerview selectRow:0 inComponent:0 animated:NO];
            [_pickerview selectRow:hour inComponent:1 animated:NO];
        }*/
        [_pickerview selectRow:hour inComponent:0 animated:NO];
        [_pickerview selectRow:minute inComponent:1 animated:NO];

    }
    self.pickerview = _pickerview;
    
    [self.view addSubview:self.pickerview];
    
    //    UIButton *repeatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [repeatBtn setTitle:@"Repeat" forState:UIControlStateNormal];
    //    [repeatBtn setBackgroundColor:[UIColor clearColor]];
    //    [repeatBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_green.png"] forState:UIControlStateNormal];
    //    repeatBtn.frame = CGRectMake((self.view.frame.size.width - 140)/2, 250, 140, 44);
    //    [repeatBtn addTarget:self action:@selector(repeatClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:repeatBtn];
    //
    //    UIButton *soundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [soundBtn setTitle:@"Sound" forState:UIControlStateNormal];
    //    [soundBtn setBackgroundColor:[UIColor clearColor]];
    //    [soundBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_green.png"] forState:UIControlStateNormal];
    //    soundBtn.frame = CGRectMake((self.view.frame.size.width - 140)/2, 300, 140, 44);
    //    [soundBtn addTarget:self action:@selector(soundClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:soundBtn];
    UITableView *_table=[[UITableView alloc] initWithFrame:CGRectMake(10, 260, self.view.frame.size.width-20,  self.view.frame.size.height-260) style:UITableViewStyleGrouped];
    _table.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                               UIViewAutoresizingFlexibleHeight);
    _table.delegate = self;
    _table.dataSource = self;
    _table.showsVerticalScrollIndicator = NO;
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    _table.backgroundColor=[UIColor clearColor];//[UIColor colorWith256Red:245 green:245 blue:250];
    _table.scrollEnabled = NO;
    
    self.wakeSettingTable=_table;
    [self.view addSubview:self.wakeSettingTable];
    
    if (!self.alarmName) {
        self.alarmName = @"Wakeup";
    }
    if (!self.sound) {
        self.sound = @"";
        self.soundName = @"";
    }
    if (!self.days) {
        self.days = @"1|2|3|4|5|6|7";
    }
    [self getRepeatString];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_scancell_green.png"]];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Repeat";
            cell.detailTextLabel.text = self.repeatString;
            break;
        case 1:
            cell.textLabel.text = @"Label";
            cell.detailTextLabel.text = self.alarmName;
            break;
        case 2:
            cell.textLabel.text = @"Sound";
            if([self.soundName isEqualToString:@""])
                cell.detailTextLabel.text = @"None";
            else
                cell.detailTextLabel.text = self.soundName;
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
        {
            PickDayVC *pick = [[PickDayVC alloc] init];
            if (self.editAlert){
                NSString *editDays = [self.editAlert objectForKey:@"repeat"];
                pick.editdays = editDays;
            }
            else{
                pick.editdays = self.days;
            }
            pick.delegate = self;
            [self.navigationController pushViewController:pick animated:YES];
            break;
        }
        case 1:
        {
            //[self changeAlarmName];
            renameWakeupVC *renameWake = [[renameWakeupVC alloc] init];
            renameWake.editName = self.alarmName;
            renameWake.delegate = self;
            [self.navigationController pushViewController:renameWake animated:YES];
            break;
        }
        case 2:
        {
            PickSoundVC *pickSound = [[PickSoundVC alloc] init];
            pickSound.delegate = self;
            pickSound.selectedSound = self.sound;
            pickSound.selectedSoundName = self.soundName;
            [self.navigationController pushViewController:pickSound animated:YES];
            break;
        }
        default:
            break;
    }
    
}

-(void)changeAlarmName
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rename diffuser" message:nil delegate:nil cancelButtonTitle:InterNation(@"cancel") otherButtonTitles:InterNation(@"confirm") ,nil];
    alert.tag = 222;
    alert.delegate = self;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[alert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDefault];
    [alert show];
}


-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *tf=[alertView textFieldAtIndex:0];
    if (alertView.tag==222) {
        if (alertView.cancelButtonIndex != buttonIndex) {
            self.title = tf.text;
            self.alarmName = tf.text;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.wakeSettingTable reloadData];
            });
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)repeatClick:(id)sender
{
    PickDayVC *pick = [[PickDayVC alloc] init];
    pick.delegate = self;
    [self.navigationController pushViewController:pick animated:YES];
}

-(void)soundClick:(id)sender
{
    PickSoundVC *pickSound = [[PickSoundVC alloc] init];
    pickSound.delegate = self;
    [self.navigationController pushViewController:pickSound animated:YES];
}

#pragma mark pickerview function

/* return cor of pickerview*/
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
/*return row number*/
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    /*if (component == 0) {
        return [self.all count];
    }else if(1 == component) {
        return [self.hours count];
    }else {
        return [self.minis count];
    }*/
    if (component == 0) {
        return [self.hours count];
    }else{
        return [self.minis count];
    }
}

/*return component row str*/
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    /*if (component == 0) {
        return [self.all objectAtIndex:row];
    }else if(1 == component) {
        row = row % [self.hours count];
        return [self.hours objectAtIndex:row];
    }else {
        row = row % [self.minis count];
        return [self.minis objectAtIndex:row];
    }*/
    if(0 == component) {
        row = row % [self.hours count];
        return [self.hours objectAtIndex:row];
    }else {
        row = row % [self.minis count];
        return [self.minis objectAtIndex:row];
    }
}

/*choose com is component,row's function*/
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //    [self pickerViewLoaded:component];
}

-(void)pickerViewLoaded: (NSInteger)blah {
    if (blah == 0) {
        NSUInteger max = [self.hours count];
        NSUInteger base10 = (max/2)-(max/2)%[self.hours count];
        [self.pickerview selectRow:[self.pickerview selectedRowInComponent:blah]%24+base10 inComponent:0 animated:false];
    }else if(blah == 1) {
        NSUInteger max = [self.minis count];
        NSUInteger base10 = (max/2)-(max/2)%[self.minis count];
        [self.pickerview selectRow:[self.pickerview selectedRowInComponent:blah]%60+base10 inComponent:0 animated:false];
    }
}

-(void) save
{
    //NSInteger row = [self.pickerview selectedRowInComponent:0];
    NSInteger hrow = [self.pickerview selectedRowInComponent:0];
    NSInteger mrow = [self.pickerview selectedRowInComponent:1];
    //self.ampm = [all objectAtIndex:row];
    self.selectedHour = [self.hours objectAtIndex:hrow];
    self.selectedMinis = [self.minis objectAtIndex:mrow];
    /*if ([self.ampm isEqualToString:@"PM"]) {
        NSInteger hourss = [self.selectedHour integerValue] + 12;
        self.selectedHour = [NSString stringWithFormat:@"%ld",(long)hourss];
    }*/
    NSString *times = [NSString stringWithFormat:@"%@:%@",self.selectedHour,self.selectedMinis];
    NSMutableDictionary * dictionary;
    
    dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:times,@"time",self.sound,@"sound",self.soundName,@"soundName",self.days,@"repeat", @"1", @"isOpen", self.alarmName,@"alarmName", nil];
    if (self.editAlert) {
        [dictionary setObject:self.isAlarmOpen forKey:@"isOpen"];
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.alert removeObject:self.editAlert];
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.alert addObject:dictionary];
    }else {
        if (!self.appDelegate.defaultBTServer.selectPeripheralInfo.alert ) {
            self.appDelegate.defaultBTServer.selectPeripheralInfo.alert = [[NSMutableArray alloc] init];
        }
        [self.appDelegate.defaultBTServer.selectPeripheralInfo.alert addObject:dictionary];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.appDelegate.defaultBTServer.selectPeripheralInfo];
    [defaults setObject:encodedObject forKey:self.appDelegate.defaultBTServer.selectPeripheralInfo.uuid];
    [defaults synchronize];
    
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];

    for(NSDictionary *alertItem in self.appDelegate.defaultBTServer.selectPeripheralInfo.alert)
    {
        if([[alertItem objectForKey:@"isOpen"] boolValue] == YES){
            [self.appDelegate scheduleNotification:alertItem];
        }
    }

    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveSound:(NSString *)sound
{
    NSLog(@"sound====%@",sound);
    NSArray *sounds = [sound componentsSeparatedByString:@"|"];
    self.sound = [sounds objectAtIndex:0];
    self.soundName = [sounds objectAtIndex:1];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.wakeSettingTable reloadData];
    });
}

-(void)saveDay:(NSArray *)days
{
    NSString * daysStr = [days componentsJoinedByString:@"|"];
    NSLog(@"days====%@",daysStr);
    self.days = daysStr;
    [self getRepeatString];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.wakeSettingTable reloadData];
    });

}

-(void)saveWakeName:(NSString *)wakeName
{
    self.alarmName = wakeName;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.wakeSettingTable reloadData];
    });
}

- (void)getRepeatString{
    if([self.days isEqualToString:@"1|2|3|4|5|6|7"])
        self.repeatString = @"Everyday";
    else if([self.days isEqualToString:@""]){
        self.repeatString = @"Never";
    }
    else{
        NSArray *daymask = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",nil];
        NSArray *weekday = [NSArray arrayWithObjects:@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat",nil];
        NSMutableArray *repeatDay = [[NSMutableArray alloc]init];
        NSArray *arrSelDay = [self.days componentsSeparatedByString:@"|"];
        for (NSString *d in daymask) {
            if ([arrSelDay containsObject:d]) {
                NSInteger index = [d integerValue]-1;
                [repeatDay addObject: weekday[index]];
            }
        }
        self.repeatString = [repeatDay componentsJoinedByString:@" "];
    }
}




@end
