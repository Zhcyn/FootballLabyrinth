#import "JRMazeManager.h"
#import "JRMazeCellModel.h"
#import "JRFootballView.h"
@interface JRMazeManager ()
@property (nonatomic, assign) NSInteger rows;
@property (nonatomic, assign) NSInteger cols;
@property (nonatomic, assign) NSInteger space;
@property (nonatomic, strong) NSMutableArray<JRMazeCellModel *> *mazeCells;
@property (nonatomic, strong) JRFootballView *football;
@property (nonatomic, assign) BOOL successful;
@end
static JRMazeManager *mazeManager = nil;
@implementation JRMazeManager
+ (JRMazeManager *)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mazeManager = [[JRMazeManager alloc] init];
    });
    return mazeManager;
}
- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}
- (NSMutableArray<JRMazeCellModel *> *)mazeCells {
    if (!_mazeCells) {
        _mazeCells = [NSMutableArray array];
    }
    return _mazeCells;
}
- (JRMazeView *)generateMazeWithRows:(NSInteger)rows withCols:(NSInteger)cols withSpace:(NSInteger)space {
    if (rows < 2 || cols < 2) {
        NSLog(@"error:您要生成的迷宫太小了，不好玩！！！");
        return nil;
    }
    self.rows = rows;
    self.cols = cols;
    self.space = space;
    self.successful = NO;
    if (self.mazeCells.count > 0) {
        [self.mazeCells removeAllObjects];
    }
    for (NSInteger i = 0; i < rows; i ++) {
        for (NSInteger j = 0; j < cols; j ++) {
            JRMazeCellModel *cell = [[JRMazeCellModel alloc] initWithRow:i withCol:j];
            [self.mazeCells addObject:cell];
        }
    }
    [self setMazePassagewayByRecursionSegmentationWithStartRow:0 endRow:rows-1 startCol:0 endCol:cols-1];
    [self openMazeCellWithRow:0 WithCol:0 withDirection:DIRECTION_TYPE_LEFT];
    [self openMazeCellWithRow:rows - 1 WithCol:cols - 1 withDirection:DIRECTION_TYPE_RIGHT];
    NSLog(@"绘制迷宫");
    return [self generateMazeView];
}
#pragma mark 使用递归分割法设置迷宫通道
- (void)setMazePassagewayByRecursionSegmentationWithStartRow:(NSInteger)startRow endRow:(NSInteger)endRow startCol:(NSInteger)startCol endCol:(NSInteger)endCol {
    NSInteger r1 = startRow;
    NSInteger r2 = endRow;
    NSInteger c1 = startCol;
    NSInteger c2 = endCol;
    if (r1 < r2 && c1 < c2) {
        NSInteger rm = [self getRandomWithFirstNum:r1 withSecondNum:r2];
        NSInteger cm = [self getRandomWithFirstNum:c1 withSecondNum:c2];
        NSInteger cd1 = [self getRandomWithFirstNum:c1 withSecondNum:cm + 1];
        NSInteger cd2 = [self getRandomWithFirstNum:cm + 1 withSecondNum:c2 + 1];
        NSInteger rd1 = [self getRandomWithFirstNum:r1 withSecondNum:rm + 1];
        NSInteger rd2 = [self getRandomWithFirstNum:rm + 1 withSecondNum:r2 + 1];
        NSInteger d = [self getRandomWithFirstNum:1 withSecondNum:4 + 1];
        if (d == 1) {
            [self openMazeCellWithRow:rd2 WithCol:cm withDirection:DIRECTION_TYPE_RIGHT];
            [self openMazeCellWithRow:rd2 WithCol:cm + 1 withDirection:DIRECTION_TYPE_LEFT];
            [self openMazeCellWithRow:rm WithCol:cd1 withDirection:DIRECTION_TYPE_DOWN];
            [self openMazeCellWithRow:rm + 1 WithCol:cd1 withDirection:DIRECTION_TYPE_UP];
            [self openMazeCellWithRow:rm WithCol:cd2 withDirection:DIRECTION_TYPE_DOWN];
            [self openMazeCellWithRow:rm + 1 WithCol:cd2 withDirection:DIRECTION_TYPE_UP];
        }else if (d == 2) {
            [self openMazeCellWithRow:rd1 WithCol:cm withDirection:DIRECTION_TYPE_RIGHT];
            [self openMazeCellWithRow:rd1 WithCol:cm + 1 withDirection:DIRECTION_TYPE_LEFT];
            [self openMazeCellWithRow:rm WithCol:cd1 withDirection:DIRECTION_TYPE_DOWN];
            [self openMazeCellWithRow:rm + 1 WithCol:cd1 withDirection:DIRECTION_TYPE_UP];
            [self openMazeCellWithRow:rm WithCol:cd2 withDirection:DIRECTION_TYPE_DOWN];
            [self openMazeCellWithRow:rm + 1 WithCol:cd2 withDirection:DIRECTION_TYPE_UP];
        }else if (d == 3) {
            [self openMazeCellWithRow:rd1 WithCol:cm withDirection:DIRECTION_TYPE_RIGHT];
            [self openMazeCellWithRow:rd1 WithCol:cm + 1 withDirection:DIRECTION_TYPE_LEFT];
            [self openMazeCellWithRow:rd2 WithCol:cm withDirection:DIRECTION_TYPE_RIGHT];
            [self openMazeCellWithRow:rd2 WithCol:cm + 1 withDirection:DIRECTION_TYPE_LEFT];
            [self openMazeCellWithRow:rm WithCol:cd2 withDirection:DIRECTION_TYPE_DOWN];
            [self openMazeCellWithRow:rm + 1 WithCol:cd2 withDirection:DIRECTION_TYPE_UP];
        }else if (d == 4) {
            [self openMazeCellWithRow:rd1 WithCol:cm withDirection:DIRECTION_TYPE_RIGHT];
            [self openMazeCellWithRow:rd1 WithCol:cm + 1 withDirection:DIRECTION_TYPE_LEFT];
            [self openMazeCellWithRow:rd2 WithCol:cm withDirection:DIRECTION_TYPE_RIGHT];
            [self openMazeCellWithRow:rd2 WithCol:cm + 1 withDirection:DIRECTION_TYPE_LEFT];
            [self openMazeCellWithRow:rm WithCol:cd1 withDirection:DIRECTION_TYPE_DOWN];
            [self openMazeCellWithRow:rm + 1 WithCol:cd1 withDirection:DIRECTION_TYPE_UP];
        }
        [self setMazePassagewayByRecursionSegmentationWithStartRow:r1 endRow:rm startCol:c1 endCol:cm];
        [self setMazePassagewayByRecursionSegmentationWithStartRow:r1 endRow:rm startCol:cm + 1 endCol:c2];
        [self setMazePassagewayByRecursionSegmentationWithStartRow:rm + 1 endRow:r2 startCol:cm + 1 endCol:c2];
        [self setMazePassagewayByRecursionSegmentationWithStartRow:rm + 1 endRow:r2 startCol:c1 endCol:cm];
    }else if (r1 < r2) {
        NSInteger rm = [self getRandomWithFirstNum:r1 withSecondNum:r2];
        [self openMazeCellWithRow:rm WithCol:c1 withDirection:DIRECTION_TYPE_DOWN];
        [self openMazeCellWithRow:rm + 1 WithCol:c1 withDirection:DIRECTION_TYPE_UP];
        [self setMazePassagewayByRecursionSegmentationWithStartRow:r1 endRow:rm startCol:c1 endCol:c1];
        [self setMazePassagewayByRecursionSegmentationWithStartRow:rm + 1 endRow:r2 startCol:c1 endCol:c1];
    }else if (c1 < c2) {
        NSInteger cm = [self getRandomWithFirstNum:c1 withSecondNum:c2 - 1];
        [self openMazeCellWithRow:r1 WithCol:cm withDirection:DIRECTION_TYPE_RIGHT];
        [self openMazeCellWithRow:r1 WithCol:cm + 1 withDirection:DIRECTION_TYPE_LEFT];
        [self setMazePassagewayByRecursionSegmentationWithStartRow:r1 endRow:r1 startCol:c1 endCol:cm];
        [self setMazePassagewayByRecursionSegmentationWithStartRow:r1 endRow:r1 startCol:cm + 1 endCol:c2];
    }
}
#pragma mark 求两个数间的随机数[r1, r2-1]
- (NSInteger)getRandomWithFirstNum:(NSInteger)firstNum withSecondNum:(NSInteger)secondNum {
    if (firstNum == secondNum) {
        return firstNum;
    }
    if (firstNum > secondNum) {
        NSInteger temp = firstNum;
        firstNum = secondNum;
        secondNum = temp;
    }
    return (arc4random() % (secondNum - firstNum) + firstNum);
}
#pragma mark 设置迷宫单元格的某个方向可以移动
- (void)openMazeCellWithRow:(NSInteger)row WithCol:(NSInteger)col withDirection:(DIRECTION_TYPE)direction {
    JRMazeCellModel *cell = self.mazeCells[row * self.cols + col];
    [cell openDirection:direction];
}
#pragma mark 绘制迷宫图
- (JRMazeView *)generateMazeView {
    CGFloat viewW = self.space * self.cols;
    CGFloat viewH = self.space * self.rows;
    JRMazeView *mazeView = [[JRMazeView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewH)];
    mazeView.rows = self.rows;
    mazeView.cols = self.cols;
    mazeView.space = self.space;
    mazeView.mazeCells = self.mazeCells;
    mazeView.backgroundColor = [UIColor clearColor];
    JRFootballView *footballView = [self generateFootball];
    [mazeView addSubview:footballView];
    self.football = footballView;
    return mazeView;
}
#pragma mark 生成足球
- (JRFootballView *)generateFootball {
    JRFootballView *football = [[JRFootballView alloc] initWithSpace:self.space];
    return football;
}
#pragma mark 移动足球
- (void)left {
    NSInteger index = self.football.row * self.cols + self.football.col;
    if (index >= self.mazeCells.count) {
        return;
    }
    if (self.football == nil) {
        return;
    }
    if (self.successful) {
        return;
    }
    JRMazeCellModel *cell = self.mazeCells[index];
    if (cell.row == self.rows - 1 && cell.col == self.cols -1) {
        return;
    }
    if (cell.canLeft && cell.col != 0) {
        [self.football moveToLeft];
    }
}
- (void)up {
    NSInteger index = self.football.row * self.cols + self.football.col;
    if (index >= self.mazeCells.count) {
        return;
    }
    if (self.football == nil) {
        return;
    }
    if (self.successful) {
        return;
    }
    JRMazeCellModel *cell = self.mazeCells[index];
    if (cell.row == self.rows - 1 && cell.col == self.cols -1) {
        return;
    }
    if (cell.canUp && cell.row != 0) {
        [self.football moveToUp];
    }
}
- (void)right {
    NSInteger index = self.football.row * self.cols + self.football.col;
    if (index >= self.mazeCells.count) {
        return;
    }
    if (self.football == nil) {
        return;
    }
    if (self.successful) {
        return;
    }
    JRMazeCellModel *cell = self.mazeCells[index];
    if (cell.row == self.rows - 1 && cell.col == self.cols - 1) {
        return;
    }
    if (cell.canRight && cell.col != self.cols - 1) {
        [self.football moveToRight];
        if (cell.row == self.rows - 1 && cell.col == self.cols - 2) {
            self.successful = YES;
            if (self.success) {
                self.success();
            }
            return;
        }
    }
}
- (void)down {
    NSInteger index = self.football.row * self.cols + self.football.col;
    if (index >= self.mazeCells.count) {
        return;
    }
    if (self.football == nil) {
        return;
    }
    if (self.successful) {
        return;
    }
    JRMazeCellModel *cell = self.mazeCells[index];
    if (cell.row == self.rows - 1 && cell.col == self.cols -1) {
        return;
    }
    if (cell.canDown && cell.row != self.rows - 1) {
        [self.football moveToDown];
        if (cell.row == self.rows - 2 && cell.col == self.cols -1) {
            self.successful = YES;
            if (self.success) {
                self.success();
            }
            return;
        }
    }
}
@end
