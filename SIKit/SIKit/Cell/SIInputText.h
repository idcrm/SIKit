//
//  SIInputText.h
//  SIKit
//
//  Created by Khemarin on 5/10/16.
//  Copyright © 2016 Soteca. All rights reserved.
//

#import "SIInputBase.h"

@interface SIInputText : SIInputBase<UITextFieldDelegate>

@property (strong, nonatomic) UITextField * input;

-(instancetype)init;

@end
