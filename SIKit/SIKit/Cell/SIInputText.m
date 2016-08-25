//
//  SIInputText.m
//  SIKit
//
//  Created by Khemarin on 5/10/16.
//  Copyright © 2016 Soteca. All rights reserved.
//

#import "SIInputText.h"

@implementation SIInputText

#pragma mark - Override message

-(instancetype)init {
    self = [super init];
    if (self) {
        self.input = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        [self.contentView addSubview:self.input];
    }
    return self;
}

-(void)setTheme:(SIFormThemeManager *)theme{
    [super setTheme:theme];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
