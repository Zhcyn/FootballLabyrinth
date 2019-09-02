#import "JRLevelDetailsViewController.h"
#import "JRMazeManager.h"
#import "JRRulesIntroductionViewController.h"
@interface JRLevelDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *mazeBackView;
@property (nonatomic, strong) JRMazeView *mazeView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger moveIndex;
@property (nonatomic, assign) BOOL isAutoMove;
@end
@implementation JRLevelDetailsViewController
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.type == MODE_TYPE_LEVEL) {
        [self createUIWithLevel];
    }else {
        [self createUIWithRandom];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [JRMazeManager manager].success = ^{
        [self win];
    };
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(autoMove) userInfo:nil repeats:YES];
    [self.timer setFireDate:[NSDate distantFuture]];
}
- (void)createUIWithLevel {
    if (self.mazeView != nil) {
        [self.mazeView removeFromSuperview];
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%ld Round", self.levelIndex + 1];
    NSInteger row = 10;
    if (self.levelIndex < 5) {
        row = 10;
    }else if (self.levelIndex >= 5 && self.levelIndex < 10) {
        row = 12;
    }else if (self.levelIndex >= 10 && self.levelIndex < 13) {
        row = 14;
    }else if (self.levelIndex >= 13 && self.levelIndex < 15) {
        row = 16;
    }else if (self.levelIndex >= 15 && self.levelIndex < 17) {
        row = 17;
    }else if (self.levelIndex >= 17 && self.levelIndex < 19) {
        row = 18;
    }else if (self.levelIndex >= 19 && self.levelIndex < 20) {
        row = 19;
    }else if (self.levelIndex >= 20 && self.levelIndex < 30) {
        row = 20;
    }else if (self.levelIndex >= 30 && self.levelIndex < 40) {
        row = 25;
    }else if (self.levelIndex >= 40 && self.levelIndex < 50) {
        row = 28;
    }else if (self.levelIndex >= 50) {
        row = 29;
    }
    NSInteger col = row;
    CGFloat space = (CGRectGetWidth(self.mazeBackView.frame) - 20) / col;
    JRMazeView *mazeView = [[JRMazeManager manager] generateMazeWithRows:row withCols:col withSpace:space];
    mazeView.center = CGPointMake(CGRectGetWidth(self.mazeBackView.frame) / 2.0, CGRectGetHeight(self.mazeBackView.frame) / 2.0);
    [self.mazeBackView addSubview:mazeView];
    self.mazeView = mazeView;
}
- (void)createUIWithRandom {
    if (self.mazeView != nil) {
        [self.mazeView removeFromSuperview];
    }
    self.titleLabel.text = @"Random Mode";
    NSInteger row = arc4random() % 30 + 10;
    NSInteger col = row;
    CGFloat space = (CGRectGetWidth(self.mazeBackView.frame) - 20) / col;
    JRMazeView *mazeView = [[JRMazeManager manager] generateMazeWithRows:row withCols:col withSpace:space];
    mazeView.center = CGPointMake(CGRectGetWidth(self.mazeBackView.frame) / 2.0, CGRectGetHeight(self.mazeBackView.frame) / 2.0);
    [self.mazeBackView addSubview:mazeView];
    self.mazeView = mazeView;
}
- (IBAction)move:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger index = btn.tag - 100;
    self.moveIndex = index;
    [self.view bringSubviewToFront:btn];
    if (index == 0) {
        [[JRMazeManager manager] left];
    }else if (index == 1) {
        [[JRMazeManager manager] up];
    }else if (index == 2) {
        [[JRMazeManager manager] right];
    }else if (index == 3) {
        [[JRMazeManager manager] down];
    }
    self.isAutoMove = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.timer setFireDate:[NSDate distantPast]];
    });
}
#pragma mark 长按自动移动
- (void)autoMove {
    if (!self.isAutoMove) {
        [self.timer setFireDate:[NSDate distantFuture]];
        return;
    }
    NSLog(@"自动移动");
    NSInteger index = self.moveIndex;
    if (index == 0) {
        [[JRMazeManager manager] left];
    }else if (index == 1) {
        [[JRMazeManager manager] up];
    }else if (index == 2) {
        [[JRMazeManager manager] right];
    }else if (index == 3) {
        [[JRMazeManager manager] down];
    }
}
- (IBAction)stop:(id)sender {
    self.isAutoMove = NO;
    [self.timer setFireDate:[NSDate distantFuture]];
}
#pragma mark 通关
- (void)win {
    if (self.type == MODE_TYPE_LEVEL && self.success) {
        self.success(self.levelIndex);
    }
    [self.timer invalidate];
    self.timer = nil;
    [JRUtils showAlertViewWithTitle:@"通关" withMessage:@"恭喜，您已顺利通过此关。" withActionTitle:@"确定" withActionMothed:^{
        [self goback:nil];
    } withCancelTitle:nil withCancelMothed:nil withViewController:self];
}
#pragma mark 返回
- (IBAction)goback:(id)sender {
    [self.timer invalidate];
    self.timer = nil;
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark 规则介绍
- (IBAction)rulesIntroduction:(id)sender {
    JRRulesIntroductionViewController *rulesVC = [[JRRulesIntroductionViewController alloc] initWithNibName:@"JRRulesIntroductionViewController" bundle:nil];
    [self presentViewController:rulesVC animated:YES completion:nil];
}
@end
