//
//  BNRPerson.m
//  BlockSelf
//
//  Created by 杨俊艺 on 2019/9/4.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNRPerson.h"

@implementation BNRPerson

-(NSString *)description
{
    return [NSString stringWithFormat:@"<BNRPerson %f   %d>", self.heightInMeters, self.weightInKilos];
}

@end
