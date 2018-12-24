//
//  TestModel.h
//  Tetris
//
//  Created by Yang on 2018/12/21.
//  Copyright © 2018 YangJing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TetrisType) {
    TetrisTypeI = 1,
    TetrisTypeL,
    TetrisTypeJ,
    TetrisTypeO,
    TetrisTypeZ,
    TetrisTypeS,
    TetrisTypeT
};

typedef NS_ENUM(NSInteger, RotateType) {
    RotateTypeUp = 1,
    RotateTypeLeft,
    RotateTypeRight,
    RotateTypeDown
};

@interface TestModel : NSObject

/**
 *  方块类型
 *  俄罗斯方块分7种类型，每种类型由4个小方块组成（这里用大写字母表示各种类型）
 */
@property (nonatomic, assign) TetrisType type;

/**
 *  旋转类型
 */
@property (nonatomic, assign) RotateType rotateType;

/**
 *  方块坐标向下偏移量
 */
@property (nonatomic, assign) NSInteger offsetY;

/**
 *  方块坐标向右偏移量
 */
@property (nonatomic, assign) NSInteger offsetX;

/**
 *  方块包含的点坐标
 */
@property (nonatomic, strong, readonly) NSArray *points;

/**
 *  方块颜色
 */
@property (nonatomic, strong, readonly) UIColor *color;

@end
