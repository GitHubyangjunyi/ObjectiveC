//
//  BNRPerson.m
//  WeakReferencesZeroing
//
//  Created by 杨俊艺 on 2019/9/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNRPerson.h"

@implementation BNRPerson

- (float)bodyMassIndex
{
    return [self weightInKilos] / [self heightInMeters] / [self heightInMeters];
}

@end
