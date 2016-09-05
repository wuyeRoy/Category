//
//  UIViewController+Dealloc.m
//  HeadCanMoveDemo1
//
//  Created by WYRoy on 16/9/5.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "UIViewController+Dealloc.h"
#import <objc/runtime.h>

@implementation UIViewController (Dealloc)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method method1 = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
        Method method2 = class_getInstanceMethod(self, @selector(my_dealloc));
        method_exchangeImplementations(method1, method2);
    });
}

- (void)my_dealloc
{
    NSLog(@"%@ object is being destroyed!", self);
    [self my_dealloc];
}
@end
