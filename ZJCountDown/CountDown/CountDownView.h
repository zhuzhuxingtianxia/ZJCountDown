//
//  CountDownView.h
//  ZJCountDown
//
//  Created by ZZJ on 2018/1/16.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CountDownView : UIView

/**
 字体颜色 默认白色
 */
@property(nonatomic,strong)UIColor  *textColor;
/**
 背景颜色 默认黑色
 */
@property(nonatomic,strong)UIColor  *tintColor;
/**
 字体大小
 */
@property(nonatomic,strong)UIFont   *textFont;
/**
 圆角大小
 */
@property(nonatomic,assign)CGFloat  cornerRadius;

/**
 ⚠️ 在列表重用时，用于标示每一个cell。
    否则会显示错误，或无法取消定时器
 */
@property(nonatomic,copy)NSIndexPath  *itemPath;

/**
 用于倒计时

 @param timeInterval 倒计时时间戳
 @param completion 倒计时结束时的回调
 */
-(void)countDownWithTimeInterval:(NSInteger)timeInterval completion:(void (^ __nullable)(BOOL finished))completion;

/**
 取消倒计时
 */
-(void)cancelTimerCountDown;

@end

NS_ASSUME_NONNULL_END

