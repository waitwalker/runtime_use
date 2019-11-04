//
//  ViewController.m
//  RuntimeUse
//
//  Created by etiantian on 2019/11/4.
//  Copyright © 2019 etiantian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"走到这里");
}


@end
