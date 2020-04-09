//
//  BNRPerson.m
//  ClassDefine
//
//  Created by 杨俊艺 on 2019/9/1.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

//这种形式的类方法称为便捷方法
+ (instancetype)randomItem
{
    NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
    
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@", [randomAdjectiveList objectAtIndex:adjectiveIndex], [randomNounList objectAtIndex:nounIndex]];
    int randomValue = arc4random() % 100;
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10];
    return [[self alloc] initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
}

//指定初始化
-(instancetype)initWithItemName:(NSString *)name
                valueInDollars:(int)value
                   serialNumber:(NSString *)str
{
    self = [super init];
    if (self) {
        _itemName = name;
        _serialNumber = str;
        _valueInDollars = value;
        _dateCreated = [[NSDate alloc] init];
    }
    return self;;
}

-(instancetype)initWithItemName:(NSString *)name
{
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}

//覆盖继承自父类的init并串联初始化方法形成初始化方法链
-(instancetype)init
{
    return [self initWithItemName:@"Item"];
}

- (void)setItemName:(NSString *)str
{
    _itemName = str;
}

- (NSString *)itemName
{
    return _itemName;
}

- (void)setSerialNumber:(NSString *)str
{
    _serialNumber = str;
}

- (NSString *)serialNumber
{
    return _serialNumber;
}

- (void)setValueInDollars:(int)v
{
    _valueInDollars = v;
}

- (int)valueInDollars
{
    return _valueInDollars;
}

- (NSDate *)dateCreated
{
    return _dateCreated;
}

-(void)setContainedItem:(BNRItem *)item
{
    _containedItem = item;
    item.container = self;
}

-(BNRItem *)containedItem
{
    return _containedItem;
}

-(void)setContainer:(BNRItem *)item
{
    _container = item;
}

-(BNRItem *)container
{
    return _container;
}

-(NSString *)description
{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
                                   self.itemName,
                                   self.serialNumber,
                                   self.valueInDollars,
                                   self.dateCreated];
    return descriptionString;
}

-(void)dealloc
{
    NSLog(@"Destroyed: %@", self);
}

@end
