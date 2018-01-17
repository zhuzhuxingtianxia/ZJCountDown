//
//  ViewController.m
//  ZJCountDown
//
//  Created by ZZJ on 2018/1/16.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
#import "CountDownView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CountDownView *countDownView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _countDownView.cornerRadius = 10.0;
    _countDownView.textFont = [UIFont boldSystemFontOfSize:20];
    [_countDownView countDownWithTimeInterval:15 completion:^(BOOL finished) {
        NextViewController *vc = [NextViewController new];
        
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}

- (IBAction)pushAction:(id)sender {
    NextViewController *vc = [NextViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
