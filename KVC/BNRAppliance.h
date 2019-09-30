//
//  BNRAppliance.h
//  KVC
//
//  Created by 杨俊艺 on 2019/9/5.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRAppliance : NSObject
{
    NSString *_productName;
}
//@property (nonatomic, copy) NSString *productName;        //为了证明KVC能够在没有存取方法的情况下直接存取实例变量,所以注释掉这个属性声明
@property (nonatomic) int voltage;

-(instancetype) initWithProductName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
