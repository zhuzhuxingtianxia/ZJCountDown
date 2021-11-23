//
//  CountDownView.m
//  ZJCountDown
//
//  Created by ZZJ on 2018/1/16.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "CountDownView.h"
#import "NSTimer+GCDTimer.h"
static NSInteger labelCout = 5;

const NSInteger timeVar = 60;

@interface CountDownView ()
//存储label的容器
@property(nonatomic,strong)NSMutableArray  *lableContainer;
//标记内存地址，用于区别不同的定时器
@property(nonatomic,copy)NSString  *addressId;
@end
@implementation CountDownView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

-(void)setup{
    //标记内存地址
    self.addressId = [NSString stringWithFormat:@"%@%p",NSStringFromClass([self class]),self];
    for (NSInteger k = 0; k < labelCout; k++) {
        UILabel *lable = [self countDownLabel:k + 900];
        if (k%2 == 0) {
            lable.textColor = [UIColor whiteColor];
            lable.backgroundColor = [UIColor blackColor];
            lable.text = @"00";
        }else{
            lable.textColor = [UIColor blackColor];
            lable.text = @":";
        }
        [self addSubview:lable];
        [self.lableContainer addObject:lable];
    }
    
    [self vfLayoutView];
}

///!!!:控件布局
-(void)vfLayoutView{
    UIView *lastView;
    for (NSInteger k = 0; k < self.lableContainer.count; k++){
        UILabel *label = self.lableContainer[k];
        if (!label.superview) {
            NSAssert(NO, @"not find a superview");
        }
        if (label.translatesAutoresizingMaskIntoConstraints) {
            label.translatesAutoresizingMaskIntoConstraints = NO;
        }
        if (lastView) {
            if (k == self.lableContainer.count - 1) {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lastView]-0-[label]-0-|" options:0 metrics:@{} views:@{@"lastView":lastView,@"label":label}]];
            }else {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lastView]-0-[label]" options:0 metrics:@{} views:@{@"lastView":lastView,@"label":label}]];
            }
            CGFloat multiplier = 0;
            if (k%2 == 1) {
                multiplier = 0.5;
            }else{
                multiplier = 2.0;
            }
            [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:lastView attribute:NSLayoutAttributeWidth multiplier:multiplier constant:0]];
            
        }else{
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[label]" options:0 metrics:@{} views:@{@"label":label}]];
            
        }
        
         [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label]-0-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:@{} views:@{@"label":label}]];
        
        lastView = label;
        
    }
}

#pragma mark -- setter
//设置圆角
-(void)setCornerRadius:(CGFloat)cornerRadius{
    if (cornerRadius > 0) {
        _cornerRadius = cornerRadius;
        for (NSInteger k = 0; k < self.lableContainer.count; k++){
            UILabel *label = self.lableContainer[k];
            if (k%2 == 0) {
                label.layer.cornerRadius = _cornerRadius;
                label.layer.masksToBounds = YES;
            }
        }
    }
}

//设置背景颜色
-(void)setTintColor:(UIColor *)tintColor{
    if (tintColor && _tintColor != tintColor) {
        _tintColor = tintColor;
        for (NSInteger k = 0; k < self.lableContainer.count; k++){
            UILabel *label = self.lableContainer[k];
            if (k%2 == 0) {
                label.backgroundColor = _tintColor;
                
            }else{
                label.textColor = _tintColor;
            }
        }
    }
}

-(void)setTextColor:(UIColor *)textColor{
    if (textColor && _textColor != textColor) {
        _textColor = textColor;
        for (NSInteger k = 0; k < self.lableContainer.count; k++){
            UILabel *label = self.lableContainer[k];
            if (k%2 == 0) {
                label.textColor = _textColor;
            }
        }
    }
}

-(void)setTextFont:(UIFont *)textFont{
    if (textFont && _textFont != textFont) {
        _textFont = textFont;
        for (NSInteger k = 0; k < self.lableContainer.count; k++){
            UILabel *label = self.lableContainer[k];
            label.font = _textFont;
        }
    }
}

-(void)countDownWithTimeInterval:(NSInteger)timeInterval completion:(void (^ __nullable)(BOOL finished))completion{
    if (timeInterval <= 0) {
        return;
    }
    
    [self displayTime:timeInterval];
    
    __block NSInteger time = timeInterval;
    [NSTimer scheduledTimerWithName:self.addressId timeInterval:1.0 queue:nil repeats:YES action:^{
        time--;
        [self displayTime:time];
        if (time <= 0) {
            [NSTimer cancelTimerWithName:self.addressId];
            completion(YES);
        }
        
    }];
    
}

-(void)displayTime:(NSInteger)time{
    
    NSInteger hour = time/timeVar /timeVar;
    NSInteger minute = time/timeVar %timeVar;
    NSInteger second = time%timeVar;
    
    UILabel *hourLabel = [self viewWithTag:900];
    hourLabel.text = [NSString stringWithFormat:@"%02ld", hour];
    
    UILabel *minuteLabel = [self viewWithTag:902];
    minuteLabel.text = [NSString stringWithFormat:@"%02ld", minute];
    
    UILabel *secondLabel = [self viewWithTag:904];
    secondLabel.text = [NSString stringWithFormat:@"%02ld", second];
}

-(void)cancelTimerCountDown{
    
    [NSTimer cancelTimerWithName:self.addressId];
}

#pragma mark -- Override
-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)dealloc{
    NSLog(@"dealloc - CountDownView");
}

#pragma mark -- getter
-(NSMutableArray *)lableContainer{
    if (!_lableContainer) {
        _lableContainer = [NSMutableArray arrayWithCapacity:labelCout];
    }
    return _lableContainer;
}
-(UILabel*)countDownLabel:(NSInteger)tag{
    UILabel *label = [UILabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.tag = tag;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

@end
