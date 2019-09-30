//
//  BNROwnedAppliance.m
//  AppliancesX
//
//  Created by 杨俊艺 on 2019/9/28.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNROwnedAppliance.h"

@implementation BNROwnedAppliance
{
    NSMutableSet *_ownerNames;
}

// MARK: 指定初始化方法
-(instancetype)initWithProductName:(NSString *)name firstOwnerName:(NSString *)fname{
    if (self = [super initWithProductName:name]) {
        _ownerNames = [[NSMutableSet alloc] init];
    }
    if (fname) {
        [_ownerNames addObject:name];
    }
    return self;
}

-(instancetype)initWithProductName:(NSString *)name{//假设未重写这个方法,往下看
    return [self initWithProductName:name firstOwnerName: nil];
}

-(void)addOwnerName:(NSString *)n{
    [_ownerNames addObject:n];
}

-(void)removeOwnerName:(NSString *)n{
    [_ownerNames removeObject:n];
}

-(NSSet *)ownerNames{
    return [_ownerNames copy];
}

@end

//BNROwnedAppliance的初始化方法和之前的BNRAppliance类有一个相同的问题,在创建子类实例时,有可能因为调用的是父类的初始化方法从而导致子类实例的初始化不完整,如下
//BNROwnedAppliance *oa = [[BNROwnedAppliance alloc] initWithProductName:@"Toaster"];
//这行代码会调用BNRAppliance的initWithProductName:方法,因为该方法对实例变量_ownerNames一无所知,就不会初始化_ownerNames
//修改方案是在BNROwnedAppliance.m中覆盖父类的初始化方法initWithProductName:,调用initWithProductName:firstOwnerName:,并使用nil作为firstOwnerName传入,也就是假设未重写的那个方法
//这里是否需要为BNROwnedAppliance实现init方法?不需要,因为以下代码可以正确初始化BNROwnedAppliance实例
//BNROwnedAppliance *oa = [[BNROwnedAppliance alloc] init];
//因为BNROwnedAppliance没有实现init,所以调用BNRAppliance的init方法,从而调用[self initWithProductName:@"UnknownName"]
//又因为self指向的是BNROwnedAppliance实例,所以调用的是BNROwnedAppliance的initWithProductName:方法,该方法又调用[self initWithProductName:name firstOwnerName:nil]
//又因为self指向的是BNROwnedAppliance实例,所以调用的是BNROwnedAppliance的initWithProductName:方法,该方法又调用[self initWithProductName:name firstOwnerName:nil]
//又因为self指向的是BNROwnedAppliance实例,所以调用的是BNROwnedAppliance的initWithProductName:方法,该方法又调用[self initWithProductName:name firstOwnerName:nil]
//调用顺序:BNROwnedAppliance *oa = [[BNROwnedAppliance alloc] init];
//因为BNROwnedAppliance没有实现init
//  所以调用父类BNRAppliance init---->
//      调用[self initWithProductName:@"UnknownName"]---->此时self指向的是BNROwnedAppliance实例
//          调用[self initWithProductName:name firstOwnerName: nil]---->
//              调用initWithProductName:(NSString *)name firstOwnerName:(NSString *)fname---->
//编写初始化方法应该遵循的规则
//1.其他初始化方法都应该直接或间接调用指定初始化方法
//2.指定初始化方法应该先调用父类指定初始化方法,然后再对实例变量初始化
//3.如果某个类指定初始化方法和父类不同,这里指方法名不同,就必须覆盖父类的指定初始化方法,并调用新的指定初始化方法
//4.如果某个类有多个初始化方法,就应该在相应的头文件中明确地注明哪个方法是指定初始化方法
//
//禁用初始化方法
//即使正确覆盖了父类的初始化方法也可能出现问题,假设要创建一个名为BNRWallSafe的NSObject子类,其指定初始化方法是initWithCode:
//出于安全考虑必须为secretCode赋特定的值,不能使用默认值,因此不可以使用之前方案:简单覆盖NSObject的init方法,并使用某个默认值作为实参调用initWithCode:方法
//如何解决?即使不覆盖init方法,BNRWallSafe实例一样可以响应init消息,然后不知情的程序员使用下面的方法创建BNRWallSafe实例
//BNRWallSafe *ws = [[BNRWallSafe alloc] init];
//最佳解决方案是覆盖父类的指定初始化方法,然后告知程序员不能调用
//-(instancetype)init{
//    [NSException raise:@"BNRWallSafeInitialization" format:@"Use initWithSecretCode:xxxx, not nil"];
//}
