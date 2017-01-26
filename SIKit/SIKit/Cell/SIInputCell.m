//
//  SIInputCell.m
//  SIKit
//
//  Created by Khemarin on 1/26/17.
//  Copyright © 2017 Soteca. All rights reserved.
//

#import "SIInputCell.h"

@implementation SIInputCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setTheme:(SIFormThemeManager *)theme {
    _theme = theme;
    
//    self.verticalIndicator.backgroundColor = theme.requiredIndicatorColor;
//    self.titleLabel.font                   = theme.font;
//    self.titleLabel.textColor              = theme.displayColor;
//    self.btnValue.titleLabel.textColor     = theme.actionColor;
}

@end
