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

@interface AddAlarmVC ()<UIPickerViewDelegate,UIPickerViewDataSource,pickDayDelegate,pickSoundDelegate>
@property (nonatomic,strong) NSArray *all;
@property (nonatomic,strong) NSArray *hours;
@property (nonatomic,strong) NSArray *minis;
@property (nonatomic,strong) UIPickerView *pickerview;
@property (nonatomic,strong) NSString *selectedHour;
@property (nonatomic,strong) NSString *selectedMinis;
@property (nonatomic,strong) NSString *ampm;
@property (nonatomic,strong) NSString *sound;
@property (nonatomic,strong) NSString *days;
@end

@implementation AddAlarmVC
@synthesize all,hours,minis,pickerview,selectedHour,selectedMinis,ampm;
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveItem;
    
    self.all = [NSArray arrayWithObjects:@"AM",@"PM",nil];
    self.hours = [NSArray arrayWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",nil];
    self.minis = [NSArray arrayWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",nil];
    UIPickerView * _pickerview = [[UIPickerView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200)/2, 40, 200, 200)];
    _pickerview.delegate=self;
    _pickerview.dataSource=self;
//    [_pickerview selectRow:(1000/(2*[self.hours count]))*[self.hours count] inComponent:1 animated:NO];
//    [_pickerview selectRow:(1000/(2*[self.minis count]))*[self.minis count] inComponent:2 animated:NO];
    self.pickerview = _pickerview;
    
    [self.view addSubview:self.pickerview];
    
    UIButton *repeatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [repeatBtn setTitle:@"Repeat" forState:UIControlStateNormal];
    [repeatBtn setBackgroundColor:[UIColor clearColor]];
    [repeatBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_green.png"] forState:UIControlStateNormal];
    repeatBtn.frame = CGRectMake((self.view.frame.size.width - 140)/2, 250, 140, 44);
    [repeatBtn addTarget:self action:@selector(repeatClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:repeatBtn];
    
    UIButton *soundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [soundBtn setTitle:@"Sound" forState:UIControlStateNormal];
    [soundBtn setBackgroundColor:[UIColor clearColor]];
    [soundBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_green.png"] forState:UIControlStateNormal];
    soundBtn.frame = CGRectMake((self.view.frame.size.width - 140)/2, 300, 140, 44);
    [soundBtn addTarget:self action:@selector(soundClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:soundBtn];
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
    return 3;
}
/*return row number*/
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.all count];
    }else if(1 == component) {
        return [self.hours count];
    }else {
        return [self.minis count];
    }
    
}

/*return component row str*/
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.all objectAtIndex:row];
    }else if(1 == component) {
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
    if (blah == 1) {
        NSUInteger max = [self.hours count];
        NSUInteger base10 = (max/2)-(max/2)%[self.hours count];
        [self.pickerview selectRow:[self.pickerview selectedRowInComponent:blah]%12+base10 inComponent:0 animated:false];
    }else if(blah == 2) {
        NSUInteger max = [self.minis count];
        NSUInteger base10 = (max/2)-(max/2)%[self.minis count];
        [self.pickerview selectRow:[self.pickerview selectedRowInComponent:blah]%60+base10 inComponent:0 animated:false];
    }
}

-(void) save
{
    NSInteger row = [self.pickerview selectedRowInComponent:0];
    NSInteger hrow = [self.pickerview selectedRowInComponent:1];
    NSInteger mrow = [self.pickerview selectedRowInComponent:2];
    self.ampm = [all objectAtIndex:row];
    self.selectedHour = [self.hours objectAtIndex:hrow];
    self.selectedMinis = [self.minis objectAtIndex:mrow];
    if ([self.ampm isEqualToString:@"AM"]) {
        NSInteger hourss = [self.selectedHour integerValue] + 12;
        self.selectedHour = [NSString stringWithFormat:@"%d",hourss];
    }
    NSString *times = [NSString stringWithFormat:@"%@:%@",self.selectedHour,self.selectedMinis];
    NSDictionary * dictionary;
    if (!self.sound) {
        self.sound = @"nil";
    }
    if (!self.days) {
        self.days = @"1|2|3|4|5|6|7";
    }
    dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"time",times,@"sound",self.sound,@"repeat",self.days,nil];
    [self.appDelegate.defaultBTServer.selectPeripheralInfo.alert addObject:dictionary];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveSound:(NSString *)sound
{
    NSLog(@"sound====%@",sound);
    self.sound = sound;
}

-(void)saveDay:(NSArray *)days
{
    NSString * daysStr = [days componentsJoinedByString:@"|"];
    NSLog(@"days====%@",daysStr);
    self.days = daysStr;
}


@end
