#import "JRMazeView.h"
@implementation JRMazeView
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextSetLineWidth(context, 2.0);
    CGContextBeginPath(context);
    for (NSInteger i = 0; i < self.mazeCells.count; i ++) {
        JRMazeCellModel *cell = self.mazeCells[i];
        NSLog(@"画直线，row:%ld, col:%ld", cell.row, cell.col);
        if (!cell.canLeft && cell.col == 0) {
            CGContextMoveToPoint(context, cell.col * self.space, cell.row * self.space);
            CGContextAddLineToPoint(context, cell.col * self.space, (cell.row + 1) * self.space);
        }
        if (!cell.canUp && cell.row == 0) {
            CGContextMoveToPoint(context, cell.col * self.space, cell.row * self.space);
            CGContextAddLineToPoint(context, (cell.col + 1) * self.space, cell.row * self.space);
        }
        if (!cell.canRight) {
            CGContextMoveToPoint(context, (cell.col + 1) * self.space, cell.row * self.space);
            CGContextAddLineToPoint(context, (cell.col + 1) * self.space, (cell.row + 1) * self.space);
        }
        if (!cell.canDown) {
            CGContextMoveToPoint(context, cell.col * self.space, (cell.row + 1) * self.space);
            CGContextAddLineToPoint(context, (cell.col + 1) * self.space, (cell.row + 1) * self.space);
        }
    }
    CGContextStrokePath(context);
}
@end
