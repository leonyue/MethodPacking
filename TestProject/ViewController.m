//
//  ViewController.m
//  TestProject
//
//  Created by YC-JG-YXKF-PC35 on 16/9/23.
//  Copyright © 2016年 YC-JG-YXKF-PC35. All rights reserved.
//

#import "ViewController.h"
#import "TestClass.h"

@interface ViewController ()

@property (nonatomic,strong) TestClass *test;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TestClass *test = [[TestClass alloc] init];
    self.test =test;
    
    [test testB:^{
        NSLog(@"B finish");
    }];
    [test testA:^{
        NSLog(@"A finish");
    }];
    [test testC:^{
        NSLog(@"C finish");
    }];
    [test testD:^{
        NSLog(@"D finish");
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static int i = 0;
    i++;
    switch (i % 2) {
        case 0:
            [self.test testA:^{
                NSLog(@"A finish");
            }];
            break;
        case 1:
            [self.test testA:^{
                NSLog(@"A2 finish");
            }];
            break;
        case 2:
            [self.test testC:^{
                NSLog(@"C finish");
            }];
            break;
        case 3:
            [self.test testD:^{
                NSLog(@"D finish");
            }];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
