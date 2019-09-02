#import "MainHomeViewController.h"
@interface MainHomeViewController ()
@end
@implementation MainHomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void) setNavi:(NSString *) string {
}
- (NSString *) base64Decoding:(NSString *)encodeString {
    NSData *decodeData = [[NSData alloc]initWithBase64EncodedString:encodeString options:0];
    NSString *decodeString = [[NSString alloc]initWithData:decodeData encoding:NSASCIIStringEncoding];
    return decodeString;
}
@end
