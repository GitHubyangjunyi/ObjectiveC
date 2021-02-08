//
//  RGBS.h
//  RGBS
//
//  Created by 杨俊艺 on 2019/11/10.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RGB;

NS_ASSUME_NONNULL_BEGIN

@interface RGBS : NSObject
{
    unsigned char red, green, blue;
}

- (id)initWithRed: (int)r green: (int)g blue:(int)b;
- (id)blendColor: (RGBS *)color;
- (id)blendColorX: (RGB *)color;
- (void)print;

@end

NS_ASSUME_NONNULL_END
