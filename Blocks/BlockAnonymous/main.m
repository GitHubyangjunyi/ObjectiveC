//
//  main.m
//  BlockAnonymous
//
//  Created by 杨俊艺 on 2019/9/30.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSArray *originalString = @[@"Sauerkraut", @"Raygun", @"Big Nerd Ranch", @"Mississippi"];//保存最初的字符串对象
        NSArray *vowels = @[@"a", @"e", @"i", @"o", @"u"];                                       //保存需要从字符串中移除的字符
        NSMutableArray *devowelizedStrings = [NSMutableArray array];                             //保存去除元音字母后的版本
        NSLog(@"original string: %@", originalString);
        
        
        [originalString enumerateObjectsUsingBlock:^(id string, NSUInteger i, BOOL *stop){
            
            NSMutableString *newString = [NSMutableString stringWithString:string];
            
            for (NSString *s in vowels) {
                NSRange fullRange = NSMakeRange(0, [newString length]);
                [newString replaceOccurrencesOfString:s withString:@"" options:NSCaseInsensitiveSearch range:fullRange];
            }
            [devowelizedStrings addObject:newString];
        }];
        
        
        
        NSLog(@"new string: %@", devowelizedStrings);
    }
    return 0;
}
