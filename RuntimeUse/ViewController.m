//
//  ViewController.m
//  RuntimeUse
//
//  Created by etiantian on 2019/11/4.
//  Copyright © 2019 etiantian. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize name = _name;

- (void)setName:(NSString *)name {
    _name = name;
} 

- (NSString *)name {
    return _name;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    NSLog(@"%p,%p",button,&button);
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonActionss) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
}


- (void)buttonAction {
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
        class_addMethod([self class], sel, (IMP)addNewMethod, "v@:");
        return true;
    }
    return [super resolveInstanceMethod:sel];
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    return [super resolveClassMethod:sel];
} 




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"走到这里");
}


@end
