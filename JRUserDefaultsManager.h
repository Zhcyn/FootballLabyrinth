#import <Foundation/Foundation.h>
@interface JRUserDefaultsManager : NSObject
+ (void)saveCurrentLevel:(NSInteger)levelIndex;
+ (NSInteger)getCurrentLevel;
@end
