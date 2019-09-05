//
//  BNRAsset.m
//  ObjectOwnership
//
//  Created by 杨俊艺 on 2019/9/1.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNRAsset.h"

@implementation BNRAsset

-(NSString *)description
{
    return [NSString stringWithFormat:@"<%@: $%u>", self.label, self.resaleValue];
}

-(void)dealloc
{
    NSLog(@"deallocating %@", self);
}

@end

//当某个对象没有拥有方时就会被释放掉,NSObject有个dealloc方法
//如果类覆盖了dealloc方法,当类的实例被释放时就会执行dealloc
//为了确定程序释放的是哪一个BNRSeet实例,这里覆盖description方法,返回一个包含label实例和resaleValue实例的字符串
