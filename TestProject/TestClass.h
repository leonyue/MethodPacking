//
//  TestClass.h
//  TestProject
//
//  Created by YC-JG-YXKF-PC35 on 16/9/23.
//  Copyright © 2016年 YC-JG-YXKF-PC35. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestClass : NSObject

- (void)testA:(void(^)())block;
- (void)testB:(void(^)())block;
- (void)testC:(void(^)())block;
- (void)testD:(void(^)())block;

@end
