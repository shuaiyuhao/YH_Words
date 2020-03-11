//
//  NSTimer+SFBlockSupport.m
//  Pods
//
//  Created by zhang on 16/6/12.
//
//

#import "NSTimer+SFBlockSupport.h"

@implementation NSTimer (SFBlockSupport)

+ (NSTimer *)sf_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)(void))block repeats:(BOOL)repeats{
    
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(sf_blockInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (NSTimer *)sf_timerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *))block repeats:(BOOL)repeats{
    
    return [self timerWithTimeInterval:seconds target:self selector:@selector(sf_blockInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)sf_blockInvoke:(NSTimer*)timer{
    
    if (timer.userInfo) {
        void(^block) (void) = timer.userInfo;
        block();
    }
}

@end
