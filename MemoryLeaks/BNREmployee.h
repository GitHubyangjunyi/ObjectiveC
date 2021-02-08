//
//  BNREmployee.h
//  MemoryLeaks
//
//  Created by 杨俊艺 on 2019/9/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNRPerson.h"

NS_ASSUME_NONNULL_BEGIN

@class BNRAsset;

@interface BNREmployee : BNRPerson

@property (nonatomic) unsigned int employeeID;

@property (nonatomic) NSDate *hireDate;
@property (nonatomic, copy) NSArray *assets;

-(double)yearsOfEmployment;
-(void)addAssets:(BNRAsset *)objects;
-(unsigned int)valueOfAssets;

@end

NS_ASSUME_NONNULL_END
