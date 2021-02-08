//
//  BNRPersonI.m
//  ObjectiveC
//
//  Created by 杨俊艺 on 2020/10/10.
//  Copyright © 2020 杨俊艺. All rights reserved.
//

#import "BNRPersonI.h"

@implementation BNRPersonI
-(float)value: (BNRPerson *)p
{
    return p->_heightInMeters;
}
@end
