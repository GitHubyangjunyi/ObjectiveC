//
//  BNRAsset.m
//  ObjectOwnership
//
//  Created by 杨俊艺 on 2019/9/1.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNRAsset.h"

@implementation BNRAsset

-(NSString *)description
{
    return [NSString stringWithFormat:@"<%@: $%u>", self.label, self.resaleValue];
}

-(void)dealloc
{
    NSLog(@"deallocating %@", self);
}

@end
