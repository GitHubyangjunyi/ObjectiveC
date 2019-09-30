//
//  main.m
//  ClassDefine
//
//  Created by 杨俊艺 on 2019/9/1.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        BNRPerson *mikey = [[BNRPerson alloc] init];
        [mikey setWeightInKilos:96];
        [mikey setHeightInMeters:1.8];
        
        int weight = [mikey weightInKilos];
        float height = [mikey heightInMeters];
        NSLog(@"mikey is %.2f meters tall and weighs %d kilograms", height, weight);
        NSLog(@"mikey has a BMI of %f", [mikey bodyMassIndex]);
        
    }
    return 0;
}
