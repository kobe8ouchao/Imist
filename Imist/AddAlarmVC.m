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

@interface AddAlarmVC ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) NSArray *all;
@property (nonatomic,strong) NSArray *hours;
@property (nonatomic,strong) NSArray *minis;
@property (nonatomic,strong) UIPickerView *pickerview;
@end

@implementation AddAlarmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveItem;
    
    self.all = [NSArray arrayWithObjects:@"AM",@"PM",nil];
    self.hours = [NSArray arrayWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",nil];
    self.minis = [NSArray arrayWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",nil];
    UIPickerView * pickerview = [[UIPickerView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200)/2, 40, 200, 200)];
    pickerview.delegate=self;
    pickerview.dataSource=self;
    [pickerview selectRow:(1000/(2*[self.hours count]))*[self.hours count] inComponent:1 animated:NO];
    [pickerview selectRow:(1000/(2*[self.minis count]))*[self.minis count] inComponent:2 animated:NO];
    self.pickerview = pickerview;
    
    [self.view addSubview:pickerview];
    
    UIButton *repeatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [repeatBtn setTitle:@"Repeat" forState:UIControlStateNormal];
    [repeatBtn setBackgroundColor:[UIColor blueColor]];
    repeatBtn.frame = CGRectMake((self.view.frame.size.width - 100)/2, 250, 100, 40);
    [repeatBtn addTarget:self action:@selector(repeatClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:repeatBtn];
    
    UIButton *soundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [soundBtn setTitle:@"Sound" forState:UIControlStateNormal];
    [soundBtn setBackgroundColor:[UIColor blueColor]];
    soundBtn.frame = CGRectMake((self.view.frame.size.width - 100)/2, 300, 100, 40);
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
    [self.navigationController pushViewController:pick animated:YES];
}

-(void)soundClick:(id)sender
{
    PickSoundVC *pickSound = [[PickSoundVC alloc] init];
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
        return 1000;//[self.hours count];
    }else {
        return 1000;//[self.minis count];
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
    
}

@end
