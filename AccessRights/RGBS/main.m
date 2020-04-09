//
//  main.m
//  RGBS
//
//  Created by 杨俊艺 on 2019/11/10.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RGB.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        RGB *u, *w;
        u = [[RGB alloc] initWithRed:255 green:127 blue:127];
        w = [[RGB alloc] initWithRed:0 green:127 blue:64];
        [u print];
        [w print];
        
        [[u blendColor: w] print];
        
        
        
        
    }
    return 0;
}
