#import "JRUtils.h"
@interface JRUtils ()
@end
@implementation JRUtils
#pragma mark --弹框提示
+ (void)showAlertViewWithTitle:(NSString *)title
                   withMessage:(NSString *)message
               withActionTitle:(NSString *)actionTitle
              withActionMothed:(void (^)(void))actionMothed
               withCancelTitle:(NSString *)cancelTitle
              withCancelMothed:(void (^)(void))cancelMothed
            withViewController:(UIViewController *)viewController
{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertCon addAction:[UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (actionMothed) {
            actionMothed();
        }
    }]];
    if (cancelTitle) {
        [alertCon addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelMothed) {
                cancelMothed();
            }
        }]];
    }
    [viewController presentViewController:alertCon animated:YES completion:nil];
}
@end
