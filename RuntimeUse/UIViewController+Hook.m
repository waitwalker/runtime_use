//
//  UIViewController+Hook.m
//  RuntimeUse
//
//  Created by etiantian on 2019/11/4.
//  Copyright © 2019 etiantian. All rights reserved.
//

#import "UIViewController+Hook.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UIViewController (Hook)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod];
    });
}

+ (void)swizzleMethod {
    Class cls = [self class];
    
    SEL originalSelector = @selector(viewWillAppear:);
    SEL swizzleSelector = @selector(swizzle_viewWillAppear:);
    
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzleMethod = class_getInstanceMethod(cls, swizzleSelector);
    
    // swizzle method 是否(已经添加过了)存在
    BOOL didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (didAddMethod) {
        class_replaceMethod(cls, swizzleSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
}


- (void)swizzle_viewWillAppear:(BOOL)animated {
    
    NSLog(@"当前类名:%@",NSStringFromClass([self class]));
    [self swizzle_viewWillAppear:animated];
}




@end
