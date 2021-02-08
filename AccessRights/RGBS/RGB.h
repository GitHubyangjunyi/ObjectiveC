//
//  RGB.h
//  RGBS
//
//  Created by 杨俊艺 on 2019/11/10.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RGB : NSObject
{
    unsigned char red, green, blue;
}

- (id)initWithRed: (int)r green: (int)g blue: (int)b;
- (id)blendColor: (RGB *)color;
- (void)print;

@end

NS_ASSUME_NONNULL_END
