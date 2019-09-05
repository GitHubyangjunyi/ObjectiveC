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
//@property (nonatomic, copy) NSString *productName;
@property (nonatomic) int voltage;

-(instancetype) initWithProductName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
