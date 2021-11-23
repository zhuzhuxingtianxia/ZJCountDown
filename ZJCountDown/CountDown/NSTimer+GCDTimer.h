//
//  NSTimer+GCDTimer.h
//  ZJCountDown
//
//  Created by ZZJ on 2018/1/17.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (GCDTimer)

/**
 使用GCD的方式做一个定时器的封装

 @param timerName 给定时器设置一个名称，用于保存定时器
 @param interval 设置时间间隔
 @param queue 添加一个线程，若传入nil，则默认使用dispatch_get_global_queue。
 @param repeats 是否循环执行，默认NO
 @param action 执行回调
 */
+(void)scheduledTimerWithName:(NSString*)timerName timeInterval:(double)interval queue:(dispatch_queue_t)queue repeats:(BOOL)repeats action:(dispatch_block_t)action;

/**
 根据名称取消指定的定时器

 @param timerName 定时器名称
 */
+(void)cancelTimerWithName:(NSString*)timerName;

/**
 取消所有使用该分类创建的定时器
 */
+(void)cancelAllTimer;

@end
