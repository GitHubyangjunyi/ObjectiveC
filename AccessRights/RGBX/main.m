//
//  main.m
//  RGBX
//
//  Created by 杨俊艺 on 2019/11/10.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RGB.h"
#import "RGBS.h"
#import "NORGB.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        RGB *u, *w;
        u = [[RGB alloc] initWithRed: 10 green: 10 blue: 10 pri: 10 pui: 10];
        w = [[RGB alloc] initWithRed: 20 green: 20 blue: 20 pri: 20 pui: 20];
        [u print];
        [w print];
        [[u blendColor: w] print];
        
        
        
        NSLog(@"RGBS");
        RGBS *us;
        RGB *ws;
        us = [[RGBS alloc] initWithRed: 10 green: 10 blue: 10 pui: 10];
        ws = [[RGB alloc] initWithRed: 20 green: 20 blue: 20 pri: 20 pui: 20];
        [us print];
        [ws print];
        [[us blendColor: ws] print];
        
        
        NSLog(@"RGBX");
        NORGB *ux;
        ux = [[NORGB alloc] initWithRed: 30 green: 30 blue: 30 pri: 30 pui: 30];
        [ux print];
        [[ux blendColor: w] print];
        
        
        
    }
    return 0;
}
