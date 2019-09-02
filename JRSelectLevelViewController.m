#import "JRSelectLevelViewController.h"
#import "JRLevelDetailsViewController.h"
static CGFloat space = 10;
static NSInteger levelCount = 60;
@interface JRSelectLevelViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end
@implementation JRSelectLevelViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLevelToScrollView];
}
- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark 生成一个关卡视图
- (UIView *)generateLevelViewWithIndex:(NSInteger)index {
    CGFloat backW = (SCREEN_WIDTH - 10 * 5) / 4.0;
    CGFloat backH = backW;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backW, backH)];
    backView.layer.cornerRadius = 10;
    backView.layer.masksToBounds = YES;
    backView.backgroundColor = [UIColor lightGrayColor];
    UIImageView *backImgView = [[UIImageView alloc] initWithFrame:backView.bounds];
    backImgView.image = [UIImage imageNamed:@"levelBack"];
    [backView addSubview:backImgView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, backW, backH)];
    [btn setTitle:[NSString stringWithFormat:@"%ld", index + 1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.tag = 200 + index;
    [btn addTarget:self action:@selector(selectLevel:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn];
    NSInteger currentLevelIndex = [JRUserDefaultsManager getCurrentLevel];
    if (index + 1 > currentLevelIndex) {
        UIView *lockBackView = [[UIView alloc] initWithFrame:backView.bounds];
        lockBackView.backgroundColor = [UIColor colorWithHex:0x000000 andAlpha:0.3];
        lockBackView.tag = 300 + index;
        [backView addSubview:lockBackView];
        UIImageView *lockImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 32, 32)];
        lockImgView.image = [UIImage imageNamed:@"selectLevel_lock"];
        [lockBackView addSubview:lockImgView];
    }
    return backView;
}
#pragma mark 添加关卡
- (void)addLevelToScrollView {
    NSInteger page = ceil(levelCount / 16.0);
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * page, SCREEN_WIDTH);
    for (NSInteger i = 0; i < levelCount; i ++) {
        UIView *levelView = [self generateLevelViewWithIndex:i];
        CGRect levelRect = levelView.frame;
        NSInteger currentPage = i / 16;
        NSInteger row = i / 4 % 4;
        NSInteger col = i % 4;
        levelRect.origin = CGPointMake(SCREEN_WIDTH * currentPage + space + (space + levelRect.size.width) * col, space + (space + levelRect.size.height) * row);
        levelView.frame = levelRect;
        [self.scrollView addSubview:levelView];
    }
}
#pragma mark 选择关卡
- (void)selectLevel:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger levelIndex = btn.tag - 200;
    JRLevelDetailsViewController *detailsVC = [[JRLevelDetailsViewController alloc] initWithNibName:@"JRLevelDetailsViewController" bundle:nil];
    detailsVC.type = MODE_TYPE_LEVEL;
    detailsVC.levelIndex = levelIndex;
    __weak typeof(self) weakSelf = self;
    detailsVC.success = ^(NSInteger levelIndex) {
        [weakSelf unLockNextLevel:levelIndex+1];
    };
    [self presentViewController:detailsVC animated:NO completion:nil];
}
#pragma mark 解锁下一关
- (void)unLockNextLevel:(NSInteger)nextLevelIndex {
    UIView *lockBackView = [self.view viewWithTag:300 + nextLevelIndex];
    if (lockBackView == nil) {
        return;
    }
    [lockBackView removeFromSuperview];
    [JRUserDefaultsManager saveCurrentLevel:nextLevelIndex + 1];
}
@end
