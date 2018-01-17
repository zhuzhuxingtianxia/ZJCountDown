//
//  NSTimer+GCDTimer.m
//  ZJCountDown
//
//  Created by ZZJ on 2018/1/17.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "NSTimer+GCDTimer.h"
#import <objc/runtime.h>

@interface NSTimer (_GCDTimer)
@property(class,nonatomic,strong)NSMutableDictionary *timerContainer;

@end
@implementation NSTimer (_GCDTimer)

+(void)setTimerContainer:(NSMutableDictionary *)timerContainer{
    objc_setAssociatedObject(self, @selector(timerContainer), timerContainer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSMutableDictionary *)timerContainer{
    return objc_getAssociatedObject(self, @selector(timerContainer));
}

@end

@implementation NSTimer (GCDTimer)
//GCD定时器封装
+(void)scheduledDispatchTimerWithName:(NSString*)timerName timeInterval:(double)interval queue:(dispatch_queue_t)queue repeats:(BOOL)repeats action:(dispatch_block_t)action{
    
    if (timerName == nil) {
        return;
    }
    if (queue == nil) {
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    
    if (!self.timerContainer) {
        self.timerContainer = [NSMutableDictionary dictionary];
    }
    
    dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
    if (!timer) {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_resume(timer);
        
        [self.timerContainer setValue:timer forKey:timerName];
    }
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
    __weak typeof(self) weakself = self;
    
    dispatch_source_set_event_handler(timer, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            action();
            if (!repeats) {
                [weakself cancelTimerWithName:timerName];
            }
        });
        
    });
    
}

+(void)cancelTimerWithName:(NSString*)timerName{
    dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
    if (!timer) {
        return;
    }
    [self.timerContainer removeObjectForKey:timerName];
    
    dispatch_source_cancel(timer);
    timer = nil;
}

+(void)cancelAllTimer{
    if (self.timerContainer.count > 0) {
        for (NSString *key in self.timerContainer.allKeys) {
            [self cancelTimerWithName:key];
        }
    }
}

@end
