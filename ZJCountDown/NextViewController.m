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
@interface NextViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CountDownView *countDownView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self buildView];
    self.dataArray = [NSMutableArray array];
    for (NSInteger k = 0; k < 20; k++) {
        [self.dataArray addObject:@(arc4random()%100)];
    }
    [self.tableView reloadData];
}

-(void)buildView{
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(20, 260, 60, 40);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"距结束";
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
    /*
    _countDownView = [[CountDownView alloc] init];
    _countDownView.frame = CGRectMake(100, 260, 200, 40);
    _countDownView.cornerRadius = 5.0;
    _countDownView.textColor = [UIColor whiteColor];
    _countDownView.tintColor = [UIColor redColor];
    _countDownView.textFont = [UIFont boldSystemFontOfSize:18];
    
    [_countDownView countDownWithTimeInterval:3665 completion:^(BOOL finished) {
        NSLog(@"完成");
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:_countDownView];
    */
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 350, self.view.bounds.size.width, 300) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

#pragma mark -- UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
       CountDownView *downView = [[CountDownView alloc] init];
        downView.frame = CGRectMake(100, 0, 200, 40);
        downView.cornerRadius = 5.0;
        downView.textColor = [UIColor whiteColor];
        downView.textFont = [UIFont boldSystemFontOfSize:18];
        downView.tag = 1000;
        [cell.contentView addSubview:downView];
        
    }
    CountDownView *downView = [cell.contentView viewWithTag:1000];
    if (indexPath.row%2 == 0) {
        downView.tintColor = [UIColor redColor];
    }else{
         downView.tintColor = [UIColor blackColor];
    }
    NSNumber *number = self.dataArray[indexPath.row];
    [downView countDownWithTimeInterval:[number integerValue] completion:^(BOOL finished) {
        
    }];
    
    return cell;
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
