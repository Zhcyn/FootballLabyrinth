#import <Foundation/Foundation.h>
#import "JRMazeView.h"
@interface JRMazeManager : NSObject
+ (JRMazeManager *)manager;
- (JRMazeView *)generateMazeWithRows:(NSInteger)rows withCols:(NSInteger)cols withSpace:(NSInteger)space;
#pragma mark 移动足球
- (void)left;
- (void)up;
- (void)right;
- (void)down;
@property (nonatomic, strong) void (^ success) (void);
@end
