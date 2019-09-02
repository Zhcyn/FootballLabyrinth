#import <Foundation/Foundation.h>
@interface JRFootballModel : NSObject
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger col;
- (instancetype)initWithRow:(NSInteger)row withCol:(NSInteger)col;
@end
