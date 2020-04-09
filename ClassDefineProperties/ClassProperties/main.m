//
//  main.m
//  ClassProperties
//
//  Created by 杨俊艺 on 2020/4/9.
//  Copyright © 2020 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
                
        BNRItem *item = [[BNRItem alloc] init];
        NSLog(@"%@ %@ %@ %d", [item itemName], [item dateCreated], [item serialNumber], [item valueInDollars]);
        
        
        BNRItem *ritem = [BNRItem randomItem];
        NSLog(@"%@", ritem);
        item = nil;
        ritem = nil;
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        BNRItem *backpack = [[BNRItem alloc] initWithItemName:@"Backpack"];
        [items addObject:backpack];
        BNRItem *calculator = [[BNRItem alloc] initWithItemName:@"Calculator"];
        [items addObject:calculator];
        
        backpack.containedItem = calculator;
        
        backpack = nil;
        calculator = nil;
        
    }
    return 0;
}
