//
//  SIInputBase.h
//  SIKit
//
//  Created by Khemarin on 5/10/16.
//  Copyright © 2016 Soteca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIFormThemeManager.h"

@interface SIInputBase : UICollectionViewCell

/**
 *  Title label of the input
 */
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

/**
 *  Theme configuration
 */
@property (strong, nonatomic) SIFormThemeManager * theme;


-(instancetype)init;

@end
