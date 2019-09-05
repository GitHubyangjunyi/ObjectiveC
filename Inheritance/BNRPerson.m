//
//  BNRPerson.m
//  Inheritance
//
//  Created by 杨俊艺 on 2019/9/1.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNRPerson.h"

@implementation BNRPerson

- (float)bodyMassIndex
{
    //return _weightInKilos/(_heightInMeters * _heightInMeters);
    return [self weightInKilos] / [self heightInMeters] / [self heightInMeters];
}

@end
