//
//  TestController.m
//  Tetris
//
//  Created by Yang on 2018/12/21.
//  Copyright © 2018 YangJing. All rights reserved.
//

#import "TestController.h"
#import "TestModel.h"

@interface TestController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *mainCollectionView;

@property (nonatomic, strong) UICollectionView *previewCollectionView;

@property (nonatomic, strong) UILabel *speedLabel;

@property (nonatomic, strong) UILabel *scoreLabel;

@property (nonatomic, strong) UIButton *startBtn;

@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) UIButton *downBtn;

@property (nonatomic, strong) UIButton *rotateBtn;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *tetrisArray;

@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, assign) NSInteger offsetX;

@property (nonatomic, assign) NSInteger rotateOffset;

@end

@implementation TestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor brownColor];
    [self addSubview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self initData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

//MARK: - data
- (void)initData {
    self.dataArray = [[NSMutableArray alloc] init];
    NSInteger count = 10*20;
    for (NSInteger i = 0; i < count; i++) {
        UIColor *color = kRGB(41, 41, 41);
        [self.dataArray addObject:color];
    }
    
    self.tetrisArray = [[NSMutableArray alloc] init];
}

- (void)addData {
    TestModel *model = [[TestModel alloc] init];
    [self.tetrisArray addObject:model];
}

- (void)refreshData {
    [self.dataArray removeAllObjects];
    NSInteger count = 10*20;
    for (NSInteger i = 0; i < count; i++) {
        UIColor *color = kRGB(41, 41, 41);
        [self.dataArray addObject:color];
    }
    
    if (self.tetrisArray.count <= 0) return;
    
    for (NSInteger i = 0, count = self.tetrisArray.count-1; i < count; i++) {
        TestModel *model = self.tetrisArray[i];
        for (NSValue *pointValue in model.points) {
            CGPoint point = [pointValue CGPointValue];
            [self.dataArray replaceObjectAtIndex:(point.x+point.y*10) withObject:model.color];
        }
    }
    
    TestModel *model = [self.tetrisArray lastObject];
    if (self.offsetX != 0) {
        model.offsetX = self.offsetX;
        BOOL isModelLegalX = [self checkDataWithModel:model];
        if (!isModelLegalX) {
            model.offsetX = -self.offsetX;
        }
        self.offsetX = 0;
    }
    
    model.offsetY = 1;
    BOOL isModelLegalY = [self checkDataWithModel:model];
    if (!isModelLegalY) {
        model.offsetY = -1;
        [self addData];
    }
    
    for (NSValue *pointValue in model.points) {
        CGPoint point = [pointValue CGPointValue];
        [self.dataArray replaceObjectAtIndex:(point.x+point.y*10) withObject:model.color];
    }
    
    if (!isModelLegalY) {
        [self checkDataIfRemoveLine];
    }
    
    [self.mainCollectionView reloadData];
}

- (BOOL)checkDataWithModel:(TestModel *)model {
    if (!model) return NO;
    
    BOOL isModelLegal = YES;
    for (NSValue *pointValue in model.points) {
        CGPoint point = [pointValue CGPointValue];
        if (point.x+point.y*10 >= self.dataArray.count) {
            isModelLegal = NO;
            
        } else {
            UIColor *color = self.dataArray[(int)(point.x+point.y*10)];
            if (!CGColorEqualToColor(color.CGColor, kRGB(41, 41, 41).CGColor)) {
                isModelLegal = NO;
            }
        }
    }
    return isModelLegal;
}

- (void)checkDataIfRemoveLine {
    for (NSInteger i = 19; i >= 0; i--) {
        
        BOOL isFullLine = YES;
        for (NSInteger j = 0; j < 10; j++) {
            
            UIColor *color = self.dataArray[j+i*10];
            if (CGColorEqualToColor(color.CGColor, kRGB(41, 41, 41).CGColor)) {
                isFullLine = NO;
            }
        }
        
        if (isFullLine) {
            if (i > 0) {
                for (NSInteger k = i; k >= 0; k--) {
                    for (NSInteger j = 0; j < 10; j++) {
                        if (k > 0) {
                            UIColor *color = self.dataArray[j+(k-1)*10];
                            [self.dataArray replaceObjectAtIndex:(j+k*10) withObject:color];
                            
                        } else {
                            [self.dataArray replaceObjectAtIndex:(j+k*10) withObject:kRGB(41, 41, 41)];

                        }
                    }
                }
            } else {
                for (NSInteger j = 0; j < 10; j++) {
                    [self.dataArray replaceObjectAtIndex:(j+i*10) withObject:kRGB(41, 41, 41)];
                }
            }
            i++;
        }
        
    }
}

//MARK: - private methods
- (void)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)startAction:(id)sender {
    self.startBtn.hidden = YES;
    
    self.rotateBtn.hidden = NO;
    self.leftBtn.hidden = NO;
    self.rightBtn.hidden = NO;
    self.downBtn.hidden = NO;

    [self addData];
    [self startTimer];
}

- (void)leftAction:(id)sender {
    self.offsetX --;
}

- (void)rightAction:(id)sender {
    self.offsetX ++;

}

- (void)downAction:(id)sender {
    
}

- (void)rotateAction:(id)sender {
    
}

//MARK: - timer
- (void)startTimer {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), 0.2*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshData];
            
        });
    });
    dispatch_resume(self.timer);
}

- (void)stopTimer {
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
        NSLog(@"yangjing_Bill: cencel timer");
    }
}

//MARK: - collectionview datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:self.previewCollectionView]) {
        return 36;
    }
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([collectionView isEqual:self.previewCollectionView]) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellId2" forIndexPath:indexPath];
        cell.contentView.backgroundColor = kRGB(41, 41, 41);
        return cell;
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellId" forIndexPath:indexPath];
    cell.contentView.backgroundColor = self.dataArray[indexPath.row];
    return cell;
}

- (void)addSubview {
    
    CGFloat viewWidth = CGRectGetWidth(self.view.safeAreaLayoutGuide.layoutFrame);
    CGFloat itemWidth = (viewWidth/2-1*9)/10;
    
    [self.view addSubview:self.mainCollectionView];
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft).offset((viewWidth-(viewWidth/2+10)-10-(itemWidth*6+10+1*5))/2.0);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(20);
        make.size.mas_equalTo(CGSizeMake(viewWidth/2+10, (viewWidth/2)*2+10));
    }];
    
    UILabel *nextDescLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = kRGB(41, 41, 41);
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        label.text = @"Next:";
        label;
    });
    [self.view addSubview:nextDescLabel];
    [nextDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainCollectionView.mas_safeAreaLayoutGuideRight).offset(10);
        make.top.equalTo(self.mainCollectionView.mas_safeAreaLayoutGuideTop);
        make.width.mas_lessThanOrEqualTo(itemWidth*6+10+1*5);
    }];
    
    [self.view addSubview:self.previewCollectionView];
    [self.previewCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainCollectionView.mas_safeAreaLayoutGuideRight).offset(10);
        make.top.equalTo(nextDescLabel.mas_safeAreaLayoutGuideBottom).offset(5);
        make.width.height.mas_equalTo(itemWidth*6+10+1*5);
    }];
    
    UILabel *levelDescLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = kRGB(41, 41, 41);
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        label.text = @"Level:";
        label;
    });
    [self.view addSubview:levelDescLabel];
    [levelDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainCollectionView.mas_safeAreaLayoutGuideRight).offset(10);
        make.top.equalTo(self.previewCollectionView.mas_safeAreaLayoutGuideBottom).offset(10);
        make.width.mas_lessThanOrEqualTo(itemWidth*6+10+1*5);
    }];
    
    self.startBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"Start" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:self.startBtn];
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_safeAreaLayoutGuideLeft).offset(viewWidth/2.0);
        make.top.equalTo(self.mainCollectionView.mas_safeAreaLayoutGuideBottom).offset(20);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(100);
    }];
    self.startBtn.hidden = NO;
    
    self.rotateBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"Rotate" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(rotateAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:self.rotateBtn];
    [self.rotateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_safeAreaLayoutGuideLeft).offset(viewWidth/2.0);
        make.top.equalTo(self.mainCollectionView.mas_safeAreaLayoutGuideBottom).offset(20);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(100);
    }];
    self.rotateBtn.hidden = YES;

    self.leftBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"Left" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:self.leftBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rotateBtn.mas_safeAreaLayoutGuideLeft).offset(20);
        make.top.equalTo(self.rotateBtn.mas_safeAreaLayoutGuideBottom).offset(20);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(100);
    }];
    self.leftBtn.hidden = YES;
    
    self.downBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"Down" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(downAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:self.downBtn];
    [self.downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_safeAreaLayoutGuideLeft).offset(viewWidth/2.0);
        make.top.equalTo(self.rotateBtn.mas_safeAreaLayoutGuideBottom).offset(20);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(100);
    }];
    self.downBtn.hidden = YES;
    
    self.rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"Right" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rotateBtn.mas_safeAreaLayoutGuideRight).offset(-20);
        make.top.equalTo(self.rotateBtn.mas_safeAreaLayoutGuideBottom).offset(20);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(100);
    }];
    self.rightBtn.hidden = YES;
}

//MARK: - getter
- (UICollectionView *)mainCollectionView {
    if (!_mainCollectionView) {
        CGFloat viewWidth = CGRectGetWidth(self.view.safeAreaLayoutGuide.layoutFrame);
        CGFloat itemWidth = (viewWidth/2-1*9)/10;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _mainCollectionView.backgroundColor = self.view.backgroundColor;
        [_mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellId"];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.scrollEnabled = NO;
        _mainCollectionView.layer.borderColor = kRGBA(41, 41, 41, 1).CGColor;
        _mainCollectionView.layer.borderWidth = 1;
    }
    return _mainCollectionView;
}

- (UICollectionView *)previewCollectionView {
    if (!_previewCollectionView) {
        
        CGFloat viewWidth = CGRectGetWidth(self.view.safeAreaLayoutGuide.layoutFrame);
        CGFloat itemWidth = (viewWidth/2-1*9)/10;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        
        _previewCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _previewCollectionView.backgroundColor = self.view.backgroundColor;
        [_previewCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellId2"];
        _previewCollectionView.delegate = self;
        _previewCollectionView.dataSource = self;
        _previewCollectionView.scrollEnabled = NO;
        _previewCollectionView.layer.borderColor = kRGBA(41, 41, 41, 1).CGColor;
        _previewCollectionView.layer.borderWidth = 1;
    }
    return _previewCollectionView;
}


@end
