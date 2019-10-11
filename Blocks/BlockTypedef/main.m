//
//  main.m
//  BlockTypedef
//
//  Created by 杨俊艺 on 2019/10/9.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

int (^func (int x)) (int y)
{
    x++;
    return ^(int count){    return count + 1 + x;   };
}

typedef int (^blk_t) (int);

blk_t funcx()
{
    return ^(int count){    return count + 1;   };
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        NSLog(@"%d", func(10)(2));
        NSLog(@"%d", funcx()(2));
        
        blk_t blk = ^(int count){return count + 1;};
        
        //blk_t *blkp = &blk;
        
        NSLog(@"%d", (blk)(4));
        NSLog(@"%p", &blk);
        //NSLog(@"%d", (*blkp)(4));
        
    }
    return 0;
}
