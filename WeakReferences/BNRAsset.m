//
//  BNRAsset.m
//  WeakReferences
//
//  Created by 杨俊艺 on 2019/9/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNRAsset.h"
#import "BNREmployee.h"
@implementation BNRAsset

-(NSString *)description
{
    if (self.holder) {
        return [NSString stringWithFormat:@"<%@: $%d, assigned to %@>", self.label, self.resaleValue, self.holder];
    } else {
        return [NSString stringWithFormat:@"<%@: $%u unassigned>", self.label, self.resaleValue];
    }
}

-(void)dealloc
{
    NSLog(@"deallocating %@", self);
}

@end
