//
//  AboutVC.m
//  Imist
//
//  Created by chao.ou on 14/12/30.
//  Copyright (c) 2014年 oc. All rights reserved.
//

#import "RenameWakeup.h"

@interface renameWakeupVC ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *label;
@end

@implementation renameWakeupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // setup navigationBar
    self.title = @"Label";
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveName)];
    self.navigationItem.leftBarButtonItem = saveItem;
    
    //self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationController.navigationBar.translucent=NO;
    //[self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.label = [[UITextField alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width,40)];
    self.label.borderStyle = UITextBorderStyleRoundedRect;
    self.label.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.label.returnKeyType =UIReturnKeyDone;
    [self.label addTarget:self action:@selector(saveName) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.label addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.label.text = self.editName;
    self.label.delegate = self;
    [self.view addSubview:self.label];
    NSLog(@"%f %f",self.view.frame.size.width,self.view.frame.size.height);
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//textField正在编辑
-(void)textFieldDidChange:(id)sender{
    UITextField * textField =(UITextField*)sender;
    self.editName = textField.text;
}

- (void) saveName
{
    
    if ([self.delegate respondsToSelector:@selector(saveWakeName:)]) {

        [self.delegate saveWakeName:self.editName];
        [self.navigationController popViewControllerAnimated:YES];
    }
}



@end
