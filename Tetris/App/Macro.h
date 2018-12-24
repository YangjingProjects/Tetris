//
//  Macro.h
//  Schulte
//
//  Created by YangJing on 2018/7/16.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

//MARK: - iOS11 - iphoneX
#define kiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//MARK: - screen
#define kScreenWidth            CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHeight           CGRectGetHeight([UIScreen mainScreen].bounds)
#define kScreenBounds           [UIScreen mainScreen].bounds
#define kNaviBarHeight          (kiPhoneX ? 64+24 : 64)

//MARK: - color
#define UIColorFromRGB(rgbValue)                                   \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0    \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]  \

#define kRGBA(r, g, b, a)                                          \
[UIColor colorWithRed:r/255.0                                      \
green:g/255.0                                      \
blue:b/255.0 alpha:a]                             \

#define kRGB(r, g, b) kRGBA(r, g, b, 1)

#endif /* Macro_h */
