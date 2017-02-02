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

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self _setupInput];
        [self _setupConstraints];
    }
    return self;
}

- (void) _setupInput {
    self.input = [[SIInput alloc] initWithFrame:self.bounds];
    self.input.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.input];
}

- (void) _setupConstraints {
    [self.input.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:4.0f].active = YES;
    [self.input.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:4.0f].active = YES;
    [self.input.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:4.0f].active = YES;
    [self.input.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:4.0f].active = YES;
    
    [self setNeedsLayout];
}

-(void)setTheme:(SIFormThemeManager *)theme {
    _theme = theme;
    
    self.input.requiredLevelColor   = theme.requiredIndicatorColor;
    self.input.titleLabel.font      = theme.font;
    self.input.titleLabel.textColor = theme.displayColor;
    self.input.actionColor          = theme.actionColor;
}

@end
