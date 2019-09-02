#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, DIRECTION_TYPE) {
    DIRECTION_TYPE_LEFT, 
    DIRECTION_TYPE_UP, 
    DIRECTION_TYPE_RIGHT, 
    DIRECTION_TYPE_DOWN, 
};
@interface JRMazeCellModel : NSObject
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger col;
@property (nonatomic, assign) BOOL canLeft;
@property (nonatomic, assign) BOOL canUp;
@property (nonatomic, assign) BOOL canRight;
@property (nonatomic, assign) BOOL canDown;
- (instancetype)initWithRow:(NSInteger)row withCol:(NSInteger)col;
- (void)openDirection:(DIRECTION_TYPE)direction;
@end
