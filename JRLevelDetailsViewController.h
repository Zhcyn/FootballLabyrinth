#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, MODE_TYPE) {
    MODE_TYPE_LEVEL, 
    MODE_TYPE_RANDOM, 
};
@interface JRLevelDetailsViewController : UIViewController
@property (nonatomic, assign) MODE_TYPE type;
@property (nonatomic, assign) NSInteger levelIndex;
@property (nonatomic, strong) void (^success) (NSInteger levelIndex);
@end
