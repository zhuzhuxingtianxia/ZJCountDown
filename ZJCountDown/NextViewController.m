//
//  NextViewController.m
//  ZJCountDown
//
//  Created by ZZJ on 2018/1/17.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "NextViewController.h"
#import "UIViewController+BackButtonHandler.h"
#import "CountDownView.h"
@interface NextViewController ()
@property(nonatomic,strong)CountDownView *countDownView;
@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _countDownView = [[CountDownView alloc] init];
    _countDownView.frame = CGRectMake(100, 200, 200, 40);
    _countDownView.cornerRadius = 5.0;
    _countDownView.textColor = [UIColor whiteColor];
    _countDownView.tintColor = [UIColor redColor];
    _countDownView.textFont = [UIFont boldSystemFontOfSize:18];
    
    [_countDownView countDownWithTimeInterval:3665 completion:^(BOOL finished) {
        NSLog(@"完成");
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:_countDownView];
}

-(BOOL)navigationShouldPopOnBackButton{
    [_countDownView cancelTimerCountDown];
    return YES;
}

-(void)dealloc{
    NSLog(@"安全释放");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
