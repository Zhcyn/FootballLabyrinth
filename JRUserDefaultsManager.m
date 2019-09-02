#import "JRUserDefaultsManager.h"
#define USERDEFAULTS_LEVEL_INDEX @"userDefaultsLevelIndex" 
@implementation JRUserDefaultsManager
+ (void)saveCurrentLevel:(NSInteger)levelIndex {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:levelIndex] forKey:USERDEFAULTS_LEVEL_INDEX];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getCurrentLevel {
    NSNumber *levelNum = [[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULTS_LEVEL_INDEX];
    if (levelNum == nil) {
        [self saveCurrentLevel:1];
        return 1;
    }
    return [levelNum integerValue];
}
@end
