//
//  NORGB.h
//  RGBX
//
//  Created by 杨俊艺 on 2019/11/10.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RGB;

NS_ASSUME_NONNULL_BEGIN

@interface NORGB : NSObject
{
@private
    int pri;
@protected
    unsigned char red, green, blue;
@public
    int pui;
}

- (id)initWithRed: (int)r green: (int)g blue: (int)b pri: (int)p pui: (int)pu;
- (id)blendColor: (RGB *)color;
- (void)print;

@end

NS_ASSUME_NONNULL_END
