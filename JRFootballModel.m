#import "JRFootballModel.h"
@implementation JRFootballModel
- (instancetype)initWithRow:(NSInteger)row withCol:(NSInteger)col {
    if (self = [super init]) {
        self.row = row;
        self.col = col;
    }
    return self;
}
@end
