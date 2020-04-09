//
//  main.m
//  ObjectiveC
//
//  Created by 杨俊艺 on 2019/8/30.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSDate *now = [NSDate date];
        NSLog(@"This date is %@", now);
        
        double seconds = [now timeIntervalSince1970];
        NSLog(@"It has been %f seconds since the start of 1970.", seconds);
        
        NSDate *later = [now dateByAddingTimeInterval: 100000];
        NSLog(@"In 100000 seconds it will be %@", later);
        
        NSHost *host = [NSHost currentHost];
        NSString *hoststring = [host localizedName];
        NSLog(@"This hoststring is %@", hoststring);

        NSCalendar *cal = [NSCalendar currentCalendar];
        NSLog(@"My calendar is %@", [cal calendarIdentifier]);//使用格里高利历法也就是公历
        unsigned long day = [cal ordinalityOfUnit:NSCalendarUnitDay
                                           inUnit:NSCalendarUnitMonth
                                          forDate:now];//计算now变量指向的NSDate实例的日期是相应月份中的第几日
        NSLog(@"This is day %lu of the month", day);
        
        //计算从我出生到现在间隔几秒
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear: 1996];
        [comps setMonth: 11];
        [comps setDay: 1];
        [comps setHour: 2];
        [comps setMinute: 2];
        [comps setSecond: 4];
        
        NSCalendar *g = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *dateOfBirth = [g dateFromComponents:comps];

        double secondsSinceEarlierDate = [now timeIntervalSinceDate:dateOfBirth];
        NSLog(@"%f", secondsSinceEarlierDate);
        
        
        NSString *list = @"abc the xcv ght";
        NSString *name = @"the";
        NSString *nname = @"eh";
        
        NSRange match = [list rangeOfString: name];
        if (!(match.location == NSNotFound)) {
            NSLog(@"%lu", (unsigned long)match.location);
            NSLog(@"%lu", (unsigned long)match.length);
        }else{
            NSLog(@"%lu", (unsigned long)match.location);
            NSLog(@"%lu", (unsigned long)match.length);
        }
        match = [list rangeOfString: nname];
        if (!(match.location == NSNotFound)) {
            NSLog(@"%lu", (unsigned long)match.location);
            NSLog(@"%lu", (unsigned long)match.length);
        }else{
            NSLog(@"Not Found");
            NSLog(@"%lu", (unsigned long)match.length);
        }
        
    }
    return 0;
}
