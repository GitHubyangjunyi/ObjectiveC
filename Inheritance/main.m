//
//  main.m
//  Inheritance
//
//  Created by 杨俊艺 on 2019/9/1.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNREmployee.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        BNREmployee *mikey = [[BNREmployee alloc] init];
        mikey.weightInKilos = 96;
        mikey.heightInMeters = 1.8;
        mikey.employeeID = 12;
        mikey.hireDate = [NSDate dateWithNaturalLanguageString:@"Aug 2nd, 2010"];
        
        NSLog(@"mikey is %.2f meters tall and weighs %d kilograms", mikey.heightInMeters, mikey.weightInKilos);
        NSLog(@"mikey has a BMI of %f", [mikey bodyMassIndex]);
        NSLog(@"Employee %u hired on %@", mikey.employeeID, mikey.hireDate);
        NSLog(@"Worked for %.2f years", [mikey yearsOfEmployment]);
        
        
        //测试覆盖ddescription
        NSDate *date = mikey.hireDate;
        NSLog(@"%@ hired on %@", mikey, date);
        
        
        
        
    }
    return 0;
}
