//
//  TestClass.m
//  TestProject
//
//  Created by YC-JG-YXKF-PC35 on 16/9/23.
//  Copyright © 2016年 YC-JG-YXKF-PC35. All rights reserved.
//

#import "TestClass.h"
#import <objc/runtime.h>
#import <objc/message.h>

typedef id (*_IMP)(id,SEL, ...);

@interface TestClass ()

@property (nonatomic, strong) NSMutableArray *execQueue;
@property (nonatomic, copy) void(^heheBlock)() ;
@property (nonatomic, strong) dispatch_source_t timer;

@end
@implementation TestClass


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        unsigned int methodsCount;
        Method *methods = class_copyMethodList([self class], &methodsCount);
        for (int i = 0; i < methodsCount; i++) {
            Method test = methods[i];
            SEL selector = method_getName(test);
            NSString *selectorName = [NSString stringWithCString:sel_getName(selector) encoding:NSUTF8StringEncoding];
            NSLog(@"selectorName:%@",selectorName);
            if (![selectorName hasPrefix:@"test"]) {
                continue;
            }
            _IMP test_IMP = (_IMP) method_getImplementation(test);
            method_setImplementation(test, imp_implementationWithBlock(^(id target, id block) {
                void (^execBlock)() = ^ {
                    test_IMP(target,selector,block);
                };
                NSMutableArray *execQueue = [target valueForKey:@"execQueue"];
                [execQueue addObject:execBlock];
                [target execNext];
            }));
        }

    });

}

- (void)execNext {
    if (_heheBlock) {
        return;
    }
    if (_execQueue.count != 0) {
        void(^execBlock)()  = [_execQueue firstObject];
        [_execQueue removeObject:execBlock];
        execBlock();
    }
}
- (void)execEnd {
    self.heheBlock = nil;
    [self execNext];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _execQueue = [[NSMutableArray alloc] init];
//        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
//        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
//        dispatch_source_set_event_handler(timer, ^{
//            if (_heheBlock) {
//                return;
//            }
//            if (_execQueue.count != 0) {
//                void(^execBlock)()  = [_execQueue firstObject];
//                [_execQueue removeObject:execBlock];
//                execBlock();
//            }
//        });
//        dispatch_resume(timer);
//        _timer = timer;
    }
    return self;
}

- (void)testA:(void(^)())block {
    NSLog(@"send A");
    self.heheBlock = block;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((arc4random() % 10) * 0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self printResult];
    });

}

- (void)testB:(void(^)())block {
    NSLog(@"send B");
    self.heheBlock = block;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((arc4random() % 10) * 0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self printResult];
    });
}
- (void)testC:(void(^)())block {
    NSLog(@"send C");
    self.heheBlock = block;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((arc4random() % 10) * 0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self printResult];
    });
}
- (void)testD:(void(^)())block {
    NSLog(@"send D");
    self.heheBlock = block;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((arc4random() % 10) * 0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self printResult];
    });
}

- (void)printResult {
    self.heheBlock();
    [self execEnd];
}



@end
