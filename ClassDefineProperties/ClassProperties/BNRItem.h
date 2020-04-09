//
//  BNRItem.h
//  ClassProperties
//
//  Created by 杨俊艺 on 2020/4/9.
//  Copyright © 2020 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRItem : NSObject
//编译器会自动生成带下划线开头的实例变量
@property (nonatomic, strong) BNRItem *containedItem;
@property (nonatomic, weak) BNRItem *container;

@property (nonatomic, copy) NSString *itemName;//指向的对象有可以修改的子类
@property (nonatomic, copy) NSString *serialNumber;//指向的对象有可以修改的子类
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;

+ (instancetype)randomItem;

-(instancetype)initWithItemName:(NSString *)name
                valueInDollars:(int)value
                   serialNumber:(NSString *)str;

-(instancetype)initWithItemName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
