//
//  BNRAsset.h
//  WeakReferences
//
//  Created by 杨俊艺 on 2019/9/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNREmployee;

NS_ASSUME_NONNULL_BEGIN

@interface BNRAsset : NSObject

@property (nonatomic, copy) NSString *label;
@property (nonatomic) unsigned int resaleValue;
@property (nonatomic, weak) BNREmployee *holder;//添加物品所有者并改为弱引用

@end

NS_ASSUME_NONNULL_END

//由于添加了一个物品所有者,导致了一个编程问题
//当使用BNRAsset类和BNREmployee类时如何确保两者间的关系一致,也就是保证当且仅当某个BNREmployee对象是另一个BNRAsset对象的holder时
//这个BNREmployee对象的asset数组才会包含相应的BNRAsset对象
//三种解决方案
//1.显式地设置两个对象间的双向关系
//[vicePresident addAssetsObject:car];
//[car setHolder:vicePresident];
//2.在为子对象设置父对象的指针时将子对象加入父对象的collection对象中
//-(void)setHolder:(BNREmployee *)e
//{
//    holder = e;
//    [e addAssetsObject:self];
//}
//3.在将子对象加入父对象的collection对象时设置指向父对象的指针(这里所采用)
