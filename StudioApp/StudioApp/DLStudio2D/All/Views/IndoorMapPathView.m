//
//  IndoorMapPathView.m
//  WisdomMallAPP
//
//  Created by apple on 14-4-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "IndoorMapPathView.h"

#import "Constants.h"
#import "AStarItem.h"

@interface IndoorMapPathView ()
{
    CGFloat offset_y;
    NSMutableArray *newPaths;
}

@end

@implementation IndoorMapPathView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor clearColor]];
        //iPhone 5
        offset_y = OFFSET_Y;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    //抗锯齿
    CGContextSetAllowsAntialiasing(context, TRUE);
    CGContextSetShouldAntialias(context, true);
    
    //图片大小2000*2855
    //转化成可绘制坐标
    CGFloat x_ratio = rect.size.width/2000;
    
    CGFloat h_ratio = MRScreenHeight/2855;
//    if (IS_IPHONE_5) {
//        h_ratio = 0.52f;
//        offset_y += 46.0f;
//    }
    CGFloat y_ratio = MRScreenHeight/2855;
    if (newPaths) {
        int j = 0;
        
        for (AStarItem *item in newPaths) {
            if (j == 0)
            {
                CGContextMoveToPoint(context, item.id_col * x_ratio, item.id_row * y_ratio + offset_y);  // 开始坐标右边开始
                j++;
                continue;
            }
            
            CGContextAddLineToPoint(context, item.id_col * x_ratio, item.id_row * y_ratio + offset_y);
            
        }
        
        CGContextSetLineWidth(context, 2.0f);
        
        CGFloat lengths[] = {4, 1};
        CGContextSetLineDash(context, 0, lengths, 2);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:53/255.0f green:122/255.0f blue:246/255.0f alpha:1].CGColor);//线框颜色
        CGContextStrokePath(context);
    }
}

- (void)drawPathWithPoints:(NSMutableArray *const)paths
{
    newPaths = paths;
    [self setNeedsDisplay];
}

@end
