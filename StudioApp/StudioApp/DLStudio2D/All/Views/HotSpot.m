//
//  HotSpot.m
//  IndoorMapScene
//
//  Created by AmyTeam3 on 2018/9/10.
//  Copyright © 2018 apple. All rights reserved.
//

#import "HotSpot.h"

@implementation HotSpot

- (id)initWithFrame:(CGRect)frame withTile:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.axis = UILayoutConstraintAxisVertical;
        self.distribution = UIStackViewDistributionFillEqually;
        self.spacing = 0;
        self.alignment = UIStackViewAlignmentFill;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
        label.text = title;
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = true;
        [self addArrangedSubview:label];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"DLStudio2D" ofType:@"bundle"];
        [btn setImage: [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:bundlePath] pathForResource:@"spot" ofType:@"png"]] forState:UIControlStateNormal];
        
        
        [[btn imageView] setContentMode:UIViewContentModeScaleAspectFit];
        [btn addTarget:self action:@selector(onSelect) forControlEvents:UIControlEventTouchUpInside];
        [self addArrangedSubview:btn];
     
    }
    return self;
}

#pragma mark - select
- (void)onSelect {
    [self.delegate hotSpotSelectedAt: self];
}
@end
