//
//  RGBS.h
//  RGBX
//
//  Created by 杨俊艺 on 2019/11/10.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "RGB.h"

NS_ASSUME_NONNULL_BEGIN

@interface RGBS : RGB

- (id)initWithRed: (int)r green: (int)g blue: (int)b pui: (int)pu;
- (id)blendColor: (RGB *)color;
- (void)print;

@end

NS_ASSUME_NONNULL_END
