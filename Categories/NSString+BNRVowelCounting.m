//
//  NSString+BNRVowelCounting.m
//  Categories
//
//  Created by 杨俊艺 on 2019/9/30.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "NSString+BNRVowelCounting.h"

#import <AppKit/AppKit.h>


@implementation NSString (BNRVowelCounting)

- (int)bnr_vowelCount
{
    NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:@"aeiouyAEIOUY"];
    NSInteger count = [self length];
                     int sum = 0;
    for(int i = 0; i < count; i++){
        unichar c = [self characterAtIndex:i];
        if([charSet characterIsMember:c]){
            sum++;
        }
    }
    return sum;
}

@end
