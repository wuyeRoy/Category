//
//  UIViewController+ViewDidLoad.m
//  Demo_runtime
//
//  Created by WYRoy on 16/7/18.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "UIViewController+ViewDidLoad.h"
#import <objc/runtime.h>
//typedef id (* _IMP)(id, SEL, ...);
typedef void (* _VIMP)(id, SEL, ...);
@implementation UIViewController (ViewDidLoad)

+ (void)load
{
    //保证交换只进行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //获取原有的方法
        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
        
        //第一种方法：
        //获取方法的实现
        _VIMP viewDidLoad_IMP = (_VIMP)method_getImplementation(viewDidLoad);
        
        
        method_setImplementation(viewDidLoad, imp_implementationWithBlock(^(id target,SEL action){
            
            //调用原有方法实现
            viewDidLoad_IMP(target,@selector(viewDidLoad));
            //新增 输出代码
            NSLog(@"----------------- %@ object is being created!",target);
            
        }));
        
        //第二种方法：
        
        //        Method viewDidLoaded = class_getClassMethod(self, @selector(viewDidLoaded));
        //        //实现两个方法的互换
        //        method_exchangeImplementations(viewDidLoad, viewDidLoaded);
    });
}
@end
