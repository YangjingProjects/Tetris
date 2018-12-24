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

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *tetrisArray;

@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, assign) NSInteger offsetY;

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
    
    [self getData];
    
    [self startTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

//MARK: - data
- (void)getData {
    self.dataArray = [[NSMutableArray alloc] init];
    NSInteger count = 10*20;
    for (NSInteger i = 0; i < count; i++) {
        UIColor *color = kRGB(41, 41, 41);
        [self.dataArray addObject:color];
    }
    
    self.tetrisArray = [[NSMutableArray alloc] init];
    TestModel *model = [[TestModel alloc] init];
    model.type = TetrisTypeI;
    [self.tetrisArray addObject:model];
}

- (void)refreshData {
    [self.dataArray removeAllObjects];
    NSInteger count = 10*20;
    for (NSInteger i = 0; i < count; i++) {
        UIColor *color = kRGB(41, 41, 41);
        [self.dataArray addObject:color];
    }
    
    for (NSInteger i = 0, count = self.tetrisArray.count; i < count; i++) {
        TestModel *model = self.tetrisArray[i];
        model.offsetY = 1;
        for (NSValue *pointValue in model.points) {
            CGPoint point = [pointValue CGPointValue];
            if (point.x+point.y*10 >= self.dataArray.count) {
                [self stopTimer];
                
            } else {
                [self.dataArray replaceObjectAtIndex:(point.x+point.y*10) withObject:model.color];

            }
        }
    }
    [self.mainCollectionView reloadData];
}

//MARK: - private methods
- (void)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//MARK: - timer
- (void)startTimer {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
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
        make.top.equalTo(self.mainCollectionView.mas_safeAreaLayoutGuideTop);
        make.width.mas_lessThanOrEqualTo(itemWidth*6+10+1*5);
    }];
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
