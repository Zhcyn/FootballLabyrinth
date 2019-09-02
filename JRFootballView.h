#import <UIKit/UIKit.h>
@interface JRFootballView : UIView
@property (nonatomic, assign, readonly) NSInteger row;
@property (nonatomic, assign, readonly) NSInteger col;
- (instancetype)initWithSpace:(NSInteger)space;
#pragma mark 移动
- (void)moveToLeft;
- (void)moveToUp;
- (void)moveToRight;
- (void)moveToDown;
@end
