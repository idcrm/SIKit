//
//  SIInputCell.h
//  SIKit
//
//  Created by Khemarin on 1/26/17.
//  Copyright © 2017 Soteca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIInput.h"
#import "SIFormThemeManager.h"

@interface SIInputCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet SIInput *input;
@property (nonatomic, strong) SIFormThemeManager *theme;

@end
