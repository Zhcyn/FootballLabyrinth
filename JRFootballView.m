#import "JRFootballView.h"
CGFloat moveDuration = 0.08;
@interface JRFootballView ()
@property (nonatomic, assign, readwrite) NSInteger row;
@property (nonatomic, assign, readwrite) NSInteger col;
@property (nonatomic, assign) NSInteger space;
@end
@implementation JRFootballView
- (instancetype)initWithSpace:(NSInteger)space {
    if (self = [super init]) {
        self.space = space;
        self.row = 0;
        self.col = 0;
        self.frame = CGRectMake(0, 0, space, space);
        UIImageView *footballImgView = [[UIImageView alloc] initWithFrame:self.frame];
        footballImgView.image = [UIImage imageNamed:@"football"];
        [self addSubview:footballImgView];
        self.layer.cornerRadius = space / 2.0;
        self.layer.masksToBounds = YES;
    }
    return self;
}
#pragma mark 移动
- (void)moveToLeft {
    CGRect oldRect = self.frame;
    CGRect moveRect = oldRect;
    moveRect.origin = CGPointMake(oldRect.origin.x - self.space, oldRect.origin.y);
    [UIView animateWithDuration:moveDuration animations:^{
        self.frame = moveRect;
    }];
    self.col -= 1;
}
- (void)moveToUp {
    CGRect oldRect = self.frame;
    CGRect moveRect = oldRect;
    moveRect.origin = CGPointMake(oldRect.origin.x, oldRect.origin.y - self.space);
    [UIView animateWithDuration:moveDuration animations:^{
        self.frame = moveRect;
    }];
    self.row -= 1;
}
- (void)moveToRight {
    CGRect oldRect = self.frame;
    CGRect moveRect = oldRect;
    moveRect.origin = CGPointMake(oldRect.origin.x + self.space, oldRect.origin.y);
    [UIView animateWithDuration:moveDuration animations:^{
        self.frame = moveRect;
    }];
    self.col += 1;
}
- (void)moveToDown {
    CGRect oldRect = self.frame;
    CGRect moveRect = oldRect;
    moveRect.origin = CGPointMake(oldRect.origin.x, oldRect.origin.y + self.space);
    [UIView animateWithDuration:moveDuration animations:^{
        self.frame = moveRect;
    }];
    self.row += 1;
}
@end
