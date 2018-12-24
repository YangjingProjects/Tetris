//
//  TestModel.m
//  Tetris
//
//  Created by Yang on 2018/12/21.
//  Copyright © 2018 YangJing. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel {
    NSArray *_pointArray;
}

- (void)setOffsetY:(NSInteger)offsetY {
    _offsetY = offsetY;
    
    CGPoint point0 = [self.points[0] CGPointValue];
    CGPoint point1 = [self.points[1] CGPointValue];
    CGPoint point2 = [self.points[2] CGPointValue];
    CGPoint point3 = [self.points[3] CGPointValue];

    if (self.type == TetrisTypeI) {
        _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(point0.x+self.offsetX, point0.y+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(point1.x+self.offsetX, point1.y+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(point2.x+self.offsetX, point2.y+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(point3.x+self.offsetX, point3.y+self.offsetY)]];

    } else if (self.type == TetrisTypeL) {
        _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 19+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 18+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 17+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 17+self.offsetY)]];

    } else if (self.type == TetrisTypeJ) {
        _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 19+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 18+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 17+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 17+self.offsetY)]];

    } else if (self.type == TetrisTypeO) {
        _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 19+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 19+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 18+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 18+self.offsetY)]];

    } else if (self.type == TetrisTypeZ) {
        _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 19+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 19+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 18+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(2+self.offsetX, 18+self.offsetY)]];

    } else if (self.type == TetrisTypeS) {
        _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 19+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(2+self.offsetX, 19+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 18+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 18+self.offsetY)]];

    } else if (self.type == TetrisTypeT) {
        _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 19+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 18+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 18+self.offsetY)],
                        [NSValue valueWithCGPoint:CGPointMake(2+self.offsetX, 18+self.offsetY)]];
    } else {
        _pointArray = @[];
    }
}

- (NSArray *)points {
    if (!_pointArray) {
        if (self.type == TetrisTypeI) {
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 0+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 1+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 2+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 3+self.offsetY)]];

        } else if (self.type == TetrisTypeL) {
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 19+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 18+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 17+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 17+self.offsetY)]];

        } else if (self.type == TetrisTypeJ) {
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 19+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 18+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 17+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 17+self.offsetY)]];

        } else if (self.type == TetrisTypeO) {
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 19+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 19+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 18+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 18+self.offsetY)]];

        } else if (self.type == TetrisTypeZ) {
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 19+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 19+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 18+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(2+self.offsetX, 18+self.offsetY)]];

        } else if (self.type == TetrisTypeS) {
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 19+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(2+self.offsetX, 19+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 18+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 18+self.offsetY)]];

        } else if (self.type == TetrisTypeT) {
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 19+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(0+self.offsetX, 18+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(1+self.offsetX, 18+self.offsetY)],
                            [NSValue valueWithCGPoint:CGPointMake(2+self.offsetX, 18+self.offsetY)]];
        } else {
            _pointArray = @[];
        }
    }

    return _pointArray;
}

- (UIColor *)color {
    if (self.type == TetrisTypeI) {
        return kRGBA(31, 239, 236, 1);
        
    } else if (self.type == TetrisTypeL) {
        return kRGBA(234, 143, 8, 1);

    } else if (self.type == TetrisTypeJ) {
        return kRGBA(0, 0, 236, 1);

    } else if (self.type == TetrisTypeO) {
        return kRGBA(236, 240, 10, 1);

    } else if (self.type == TetrisTypeZ) {
        return kRGBA(222, 0, 6, 1);

    } else if (self.type == TetrisTypeS) {
        return kRGBA(32, 244, 6, 1);

    } else if (self.type == TetrisTypeT) {
        return kRGBA(140, 0, 236, 1);

    }
    return kRGBA(31, 239, 236, 1);
}

@end
