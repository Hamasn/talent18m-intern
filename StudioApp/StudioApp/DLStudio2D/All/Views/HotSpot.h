//
//  HotSpot.h
//  IndoorMapScene
//
//  Created by AmyTeam3 on 2018/9/10.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class HotSpot;
@protocol HotSpotDelegate <NSObject>
@required
- (void)hotSpotSelectedAt:(HotSpot*)hotSpot;
@end

@interface HotSpot : UIStackView
@property (nonatomic, nonatomic) int x;
@property (nonatomic, nonatomic) int y;
@property (nonatomic, nonatomic) NSString *name;
@property (nonatomic, weak) id <HotSpotDelegate>delegate;
- (id)initWithFrame:(CGRect)frame withTile:(NSString *)title;
@end
