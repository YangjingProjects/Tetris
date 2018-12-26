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
    TetrisType _tetrisType;
}

- (void)setOffsetX:(NSInteger)offsetX {
    
    CGPoint point0 = [self.points[0] CGPointValue];
    CGPoint point1 = [self.points[1] CGPointValue];
    CGPoint point2 = [self.points[2] CGPointValue];
    CGPoint point3 = [self.points[3] CGPointValue];
    
    if (point0.x+offsetX < 0 || point0.x+offsetX >= 10 ||
        point1.x+offsetX < 0 || point1.x+offsetX >= 10 ||
        point2.x+offsetX < 0 || point2.x+offsetX >= 10 ||
        point3.x+offsetX < 0 || point3.x+offsetX >= 10 ) {
        return;
    }
    
    _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(point0.x+offsetX, point0.y)],
                    [NSValue valueWithCGPoint:CGPointMake(point1.x+offsetX, point1.y)],
                    [NSValue valueWithCGPoint:CGPointMake(point2.x+offsetX, point2.y)],
                    [NSValue valueWithCGPoint:CGPointMake(point3.x+offsetX, point3.y)]];
}

- (void)setOffsetY:(NSInteger)offsetY {
    CGPoint point0 = [self.points[0] CGPointValue];
    CGPoint point1 = [self.points[1] CGPointValue];
    CGPoint point2 = [self.points[2] CGPointValue];
    CGPoint point3 = [self.points[3] CGPointValue];
    
//    if (point0.y+offsetY < 0 || point0.y+offsetY >= 20 ||
//        point1.y+offsetY < 0 || point1.y+offsetY >= 20 ||
//        point2.y+offsetY < 0 || point2.y+offsetY >= 20 ||
//        point3.y+offsetY < 0 || point3.y+offsetY >= 20 ) {
//        return;
//    }

    _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y+offsetY)],
                    [NSValue valueWithCGPoint:CGPointMake(point1.x, point1.y+offsetY)],
                    [NSValue valueWithCGPoint:CGPointMake(point2.x, point2.y+offsetY)],
                    [NSValue valueWithCGPoint:CGPointMake(point3.x, point3.y+offsetY)]];
}

- (void)setRotateOffset:(NSInteger)rotateOffset {
    _rotateOffset = rotateOffset%4;
    
    CGPoint point0 = [self.points[0] CGPointValue];
    CGPoint point1 = [self.points[1] CGPointValue];
    CGPoint point2 = [self.points[2] CGPointValue];
    CGPoint point3 = [self.points[3] CGPointValue];
    
    if (_rotateOffset == 0) {
        if (self.type == TetrisTypeI) {
            if (point0.x < 0 || point0.x >= 10 ||
                point0.x+1 < 0 || point0.x+1 >= 10 ||
                point0.x+2 < 0 || point0.x+2 >= 10 ||
                point0.x+3 < 0 || point0.x+3 >= 10 ) {
                return;
            }
            
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x+1, point0.y)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x+2, point0.y)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x+3, point0.y)]];
            
        } else if (self.type == TetrisTypeL) {
            if (point0.x < 0 || point0.x >= 10 ||
                point0.x+1 < 0 || point0.x+1 >= 10 ||
                point0.x+2 < 0 || point0.x+2 >= 10) {
                return;
            }
            
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y+1)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x-1, point0.y+1)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x-1, point0.y+1)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x+2, point0.y)]];
            
        } else if (self.type == TetrisTypeJ) {
            if (point0.x < 0 || point0.x >= 10 ||
                point0.x+1 < 0 || point0.x+1 >= 10 ||
                point0.x+2 < 0 || point0.x+2 >= 10) {
                return;
            }
            
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)]];
            
        } else if (self.type == TetrisTypeO) {
            if (point0.x < 0 || point0.x >= 10 ||
                point0.x+1 < 0 || point0.x+1 >= 10 ||
                point0.x+2 < 0 || point0.x+2 >= 10) {
                return;
            }
            
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)]];
            
        } else if (self.type == TetrisTypeZ) {
            if (point0.x < 0 || point0.x >= 10 ||
                point0.x+1 < 0 || point0.x+1 >= 10 ||
                point0.x+2 < 0 || point0.x+2 >= 10) {
                return;
            }
            
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)]];
            
        } else if (self.type == TetrisTypeS) {
            if (point0.x < 0 || point0.x >= 10 ||
                point0.x+1 < 0 || point0.x+1 >= 10 ||
                point0.x+2 < 0 || point0.x+2 >= 10) {
                return;
            }
            
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)]];
            
        } else if (self.type == TetrisTypeT) {
            if (point0.x < 0 || point0.x >= 10 ||
                point0.x+1 < 0 || point0.x+1 >= 10 ||
                point0.x+2 < 0 || point0.x+2 >= 10) {
                return;
            }
            
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)],
                            [NSValue valueWithCGPoint:CGPointMake(point0.x, point0.y)]];
            
        } else {
            _pointArray = @[];
        }
        
    } else if (_rotateOffset == 1) {
        
    } else if (_rotateOffset == 2) {
        
    } else if (_rotateOffset == 3) {
        
    }
}

- (NSArray *)points {
    if (!_pointArray) {
        if (self.type == TetrisTypeI) {
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(4, 0-1)],
                            [NSValue valueWithCGPoint:CGPointMake(4, 1-1)],
                            [NSValue valueWithCGPoint:CGPointMake(4, 2-1)],
                            [NSValue valueWithCGPoint:CGPointMake(4, 3-1)]];

        } else if (self.type == TetrisTypeL) {
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(4, 0-1)],
                            [NSValue valueWithCGPoint:CGPointMake(4, 1-1)],
                            [NSValue valueWithCGPoint:CGPointMake(4, 2-1)],
                            [NSValue valueWithCGPoint:CGPointMake(5, 2-1)]];

        } else if (self.type == TetrisTypeJ) {
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(5, 0-1)],
                            [NSValue valueWithCGPoint:CGPointMake(5, 1-1)],
                            [NSValue valueWithCGPoint:CGPointMake(5, 2-1)],
                            [NSValue valueWithCGPoint:CGPointMake(4, 2-1)]];

        } else if (self.type == TetrisTypeO) {
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(4, 0-1)],
                            [NSValue valueWithCGPoint:CGPointMake(5, 0-1)],
                            [NSValue valueWithCGPoint:CGPointMake(4, 1-1)],
                            [NSValue valueWithCGPoint:CGPointMake(5, 1-1)]];

        } else if (self.type == TetrisTypeZ) {
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(4, 0-1)],
                            [NSValue valueWithCGPoint:CGPointMake(5, 0-1)],
                            [NSValue valueWithCGPoint:CGPointMake(5, 1-1)],
                            [NSValue valueWithCGPoint:CGPointMake(6, 1-1)]];

        } else if (self.type == TetrisTypeS) {
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(5, 0-1)],
                            [NSValue valueWithCGPoint:CGPointMake(6, 0-1)],
                            [NSValue valueWithCGPoint:CGPointMake(4, 1-1)],
                            [NSValue valueWithCGPoint:CGPointMake(5, 1-1)]];

        } else if (self.type == TetrisTypeT) {
            _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(5, 0-1)],
                            [NSValue valueWithCGPoint:CGPointMake(4, 1-1)],
                            [NSValue valueWithCGPoint:CGPointMake(5, 1-1)],
                            [NSValue valueWithCGPoint:CGPointMake(6, 1-1)]];
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

- (TetrisType)type {
    if (_tetrisType == TetrisTypeUnknow) {
        _tetrisType = arc4random()%7+1;
    }
    _tetrisType = TetrisTypeO;
    return _tetrisType;
}

@end
