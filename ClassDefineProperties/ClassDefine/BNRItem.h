//
//  BNRPerson.h
//  ClassDefine
//
//  Created by 杨俊艺 on 2019/9/1.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRItem : NSObject

{
    NSString *_itemName;
    NSString *_serialNumber;
    int _valueInDollars;
    NSDate *_dateCreated;
    
    BNRItem *_containedItem;
    __weak BNRItem *_container;
}

+ (instancetype)randomItem;

-(instancetype)initWithItemName:(NSString *)name
                valueInDollars:(int)value
                   serialNumber:(NSString *)str;

-(instancetype)initWithItemName:(NSString *)name;

- (void)setItemName:(NSString *)str;
- (NSString *)itemName;

- (void)setSerialNumber:(NSString *)str;
- (NSString *)serialNumber;

- (void)setValueInDollars:(int)v;
- (int)valueInDollars;

- (NSDate *)dateCreated;

-(void)setContainedItem:(BNRItem *)item;
-(BNRItem *)containedItem;

-(void)setContainer:(BNRItem *)item;
-(BNRItem *)container;

@end

NS_ASSUME_NONNULL_END
