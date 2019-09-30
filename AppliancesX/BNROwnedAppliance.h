//
//  BNROwnedAppliance.h
//  AppliancesX
//
//  Created by 杨俊艺 on 2019/9/28.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNRAppliance.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNROwnedAppliance : BNRAppliance

@property (readonly) NSSet *ownerNames;

-(instancetype)initWithProductName:(NSString *)name firstOwnerName:(NSString *)fname;
-(void)addOwnerName:(NSString *)n;
-(void)removeOwnerName:(NSString *)n;

@end

NS_ASSUME_NONNULL_END
