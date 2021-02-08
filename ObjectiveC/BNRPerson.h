//
//  BNRPerson.h
//  ObjectiveC
//
//  Created by 杨俊艺 on 2020/10/8.
//  Copyright © 2020 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRPerson : NSObject

{
    float _heightInMeters;
    int _weightInKilos;
}

-(float) heightInMeters;
-(void) setHeightInMeters:(float) h;
-(int) weightInKilos;
-(void) setWeightInKilos:(int) w;
-(float) bodyMassIndex;

@end

NS_ASSUME_NONNULL_END
