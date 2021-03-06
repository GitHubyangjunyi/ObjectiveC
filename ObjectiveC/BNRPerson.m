//
//  BNRPerson.m
//  ObjectiveC
//
//  Created by 杨俊艺 on 2020/10/8.
//  Copyright © 2020 杨俊艺. All rights reserved.
//

#import "BNRPerson.h"

@implementation BNRPerson

-(float)heightInMeters;
{
    return _heightInMeters;
}

-(void)setHeightInMeters:(float)h
{
    _heightInMeters = h;
}

-(int)weightInKilos;
{
    return _weightInKilos;
}

-(void)setWeightInKilos:(int)w
{
    _weightInKilos = w;
}

-(float)bodyMassIndex;
{
    return _weightInKilos / (_heightInMeters * _heightInMeters);
}

@end
