//
//  ViewController.m
//  RuntimeUse
//
//  Created by etiantian on 2019/11/4.
//  Copyright © 2019 etiantian. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+Forward.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *testArray;
@property (nonatomic, strong) NSMutableArray *mutableArray;

@end

@implementation ViewController
@synthesize name = _name;

- (void)setName:(NSString *)name {
    _name = name;
} 

- (NSString *)name {
    return _name;
}

- (NSMutableArray *)mutableArray {
    if (_mutableArray == nil) {
        _mutableArray = [NSMutableArray new];
    }
    return _mutableArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    NSLog(@"%p,%p",button,&button);
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    self.mutableArray = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
    self.testArray = self.mutableArray;
    
    NSLog(@"mutableArray:%@  testArray:%@",self.mutableArray,self.testArray);
}




- (void)buttonAction {
    [self.mutableArray addObject:@"3"];
    NSLog(@"mutableArray:%@  testArray:%@",self.mutableArray,self.testArray);
    
    self.name = @"张三女";
    NSLog(@"self->isa:%@",self->isa);
    NSLog(@"self class:%@",[self class]);
    [self.view setBackgroundColor:[UIColor orangeColor]];
    NSLog(@"self->isa:%@",self->isa);
    NSLog(@"self class:%@",[self class]);
}

/**
 * @description 动态方法解析, 如果没有添加没有实现的方法走这里
 * @author
 * @date 
 * @parameter 
 */
void addNewMethod(id obj, SEL _cmd)  {    
    NSLog(@"动态方法解析成功");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(buttonActionss)) {
        //class_addMethod([self class], sel, (IMP)addNewMethod, "v@:");
        return true;
    }
    return [super resolveInstanceMethod:sel];
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    return [super resolveClassMethod:sel];
} 

/**
 * @description 快速消息转发, 如果动态方法解析没有实现或者没有处理走这里
 * @author 
 * @date 
 * @parameter 
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    if (aSelector == @selector(buttonActionss)) {
        return self;
    }
    
    return [super forwardingTargetForSelector:aSelector];
}






- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"走到这里");
}


@end
