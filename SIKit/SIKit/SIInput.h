//
//  SIView.h
//  SIKit
//
//  Created by Khemarin on 3/2/16.
//  Copyright © 2016 Soteca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Validator.h"
#import "SIInputDelegate.h"
#import "SIDateTimePickerController.h"
#import "SIListController.h"

/**
 * Types of input
 */
typedef enum : NSUInteger {
    SIInputTypeText,
    SIInputTypeInteger,
    SIInputTypeDouble,
    SIInputTypePhone,
    SIInputTypeURL,
    SIInputTypeEmail,
    SIInputTypePassword,
    SIInputTypeTime,
    SIInputTypeDate,
    SIInputTypeDateAndTime,
    SIInputTypeCountDownTimer,
    SIInputTypeSwitch, //Yes-No UISwitch
    SIInputTypeList,
    SIInputTypeOptions
} SIInputType;


IB_DESIGNABLE @interface SIInput : UIView<UITextFieldDelegate, SIDateTimePickerControllerDelegate>

@property (strong, nonatomic, nullable) id<SIInputDelegate> delegate;
@property (strong, nonatomic, nullable) id<SIInputDataSource> dataSource;

/**
 *  Title label to display along with the input to describe what is the input for
 */
@property (strong, nonatomic, nullable) UILabel * titleLabel;

/**
 *  The actual input view
 */
@property (strong, nonatomic, nullable) UITextView * input;

/**
 *  An additional property to indetify the compoenent
 */
@property (strong, nonatomic, nullable) NSString * identifier;

/**
 *  Additional information of the component
 */
@property (strong, nonatomic, nullable) NSDictionary * info;

/**
 * Options to pick when type is SIInputTypeOptions
 */
@property (strong, nonatomic, nullable) NSArray<NSDictionary*> *options;

/**
 *  Input type
 */
@property (nonatomic) SIInputType inputType;

/**
 *  On the left most of the component, we have a vertical bar indicate required level.
 *  We may use red represent mandatory, blue for recommened etc.
 */
@property (strong, nonatomic, nullable) IBInspectable UIColor * requiredLevelColor;

/**
 *  Label title text
 */
@property (strong, nonatomic, nullable) IBInspectable NSString * labelTitle;

/**
 *  Value to display in input (key-value will display value)
 */
@property (strong, nonatomic, nullable) IBInspectable NSString * inputValue;

/**
 *  Role as key for key-value
 */
@property (strong, nonatomic, nullable) NSString * inputKey;

/**
 *  Input value color
 */
@property (strong, nonatomic, nullable) IBInspectable UIColor * inputTextColor;

/**
 *  Action color
 */
@property (strong, nonatomic, nullable) IBInspectable UIColor * actionColor;

/**
 *  Readonly flag
 */
@property (assign, nonatomic) BOOL readOnly;


/**
 dateFormat
 */
@property (copy, nonnull) NSString * dateFormat;

/**
 Update the key/value of the input

 @param value value to display
 @param key value key
 */
- (void) updateInputValue:(NSString * _Nonnull)value andKey:(NSString * _Nullable)key;

@end
