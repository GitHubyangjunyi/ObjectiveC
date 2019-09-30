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
        //消息发送,NSDate类中有一个date方法,接收方(指针,指向接收消息的对象的地址)是NSDate,选择器是date,date方法执行后NSDate类会在堆上给NSDate实例声明一部分内存,将NSDate实例初始化为当前时间并返回新对象的地址
        NSLog(@"This NSDate object lives at %p", now);
        NSLog(@"This date is %@", now);
        
        double seconds = [now timeIntervalSince1970];
        NSLog(@"It has been %f seconds since the start of 1970.", seconds);
        
        NSDate *later = [now dateByAddingTimeInterval: 100000];
        NSLog(@"In 100000 seconds it will be %@", later);
        
        NSHost *host = [NSHost currentHost];//获取NSHost实例
        NSLog(@"This NSHost object lives at %p", host);
        NSString *hoststring = [host localizedName];
        NSLog(@"This hoststring is %@", hoststring);

        
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSLog(@"My calendar is %@", [cal calendarIdentifier]);//使用格里高利历法,也就是公历
//        unsigned long day = [cal ordinalityOfUnit:<#(NSCalendarUnit)#> inUnit:<#(NSCalendarUnit)#> forDate:<#(nonnull NSDate *)#>];
        unsigned long day = [cal ordinalityOfUnit:NSCalendarUnitDay
                                           inUnit:NSCalendarUnitMonth
                                          forDate:now];//计算now变量指向的NSDate实例的日期是相应月份中的第几日
        NSLog(@"This is day %lu of the month", day);
        
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear: 1996];
        [comps setMonth: 11];
        [comps setDay: 1];
        [comps setHour: 2];
        [comps setMinute: 2];
        [comps setSecond: 4];
        
//        NSCalendar *g = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//        NSDate *dateOfBirth = [g dateFromComponents:comps];
//
//        double secondsSinceEarlierDate = [now timeIntervalSinceDate:comps];
//        NSLog(@"%f", secondsSinceEarlierDate);
        
    }
    return 0;
}
