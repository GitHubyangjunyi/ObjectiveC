//
//  BNRPerson.h
//  Properties
//
//  Created by 杨俊艺 on 2019/9/1.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRPerson : NSObject

@property (nonatomic) float heightInMeters;             //默认是原子性,所以要显式声明非原子性
@property (nonatomic) int weightInKilos;

- (float)bodyMassIndex;

@end

NS_ASSUME_NONNULL_END
