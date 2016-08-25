//
//  SIInputBase.m
//  SIKit
//
//  Created by Khemarin on 5/10/16.
//  Copyright © 2016 Soteca. All rights reserved.
//

#import "SIInputBase.h"

@interface SIInputBase()

@property (strong, nonatomic) IBOutlet UIView *verticalIndicator;
@property (strong, nonatomic) IBOutlet UIButton *btnValue;

@end


@implementation SIInputBase

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark -
#pragma mark Getter/Setter

-(void)setTheme:(SIFormThemeManager *)theme {
    _theme                                 = theme;
    self.verticalIndicator.backgroundColor = theme.requiredIndicatorColor;
    self.titleLabel.font                   = theme.font;
    self.titleLabel.textColor              = theme.displayColor;
    self.btnValue.titleLabel.textColor     = theme.actionColor;
}

@end
