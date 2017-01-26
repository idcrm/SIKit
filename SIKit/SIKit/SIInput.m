//
//  SIView.m
//  SIKit
//
//  Created by Khemarin on 3/2/16.
//  Copyright © 2016 Soteca. All rights reserved.
//

#import "SIInput.h"

@interface SIInput()

/**
 *  The vertical bar view at the left most of component represent required level.
 */
@property (strong, nonatomic) UIView * requiredView;

/**
 *  Height of label input
 */
@property (assign, nonatomic) CGFloat titleLabelHeight;

/**
 *  Text input  
 */
@property (strong, nonatomic) UITextField * inputTextField;

/**
 *  Input button
 */
@property (strong, nonatomic) UIButton * buttonInputTrigger;


/**
 *  Input value of date
 */
@property (strong, nonatomic) NSDate * dateValue;

/**
 *  Input countdown value
 */
@property (assign, nonatomic) NSTimeInterval countdownInterval;


/**
 *  Edge inset from border to inner elements
 */
@property (nonatomic, assign) CGFloat padding;

@end

@implementation SIInput

- (instancetype)init {
    self = [super init];
    if (self) {
        self.labelTitle = @"Label";
        self.inputTextColor = [UIColor blackColor];
    }
    
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    //Add touch gesture to auto focus on text input
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfTap:)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    
    self.dateValue = [NSDate date];
}

- (void)drawRect:(CGRect)rect {
    // Update required level color
    [self _initRequiredView];
    
    //Update label
    [self _initLabelTitle];
    
    switch (self.inputType) {
        case SIInputTypeURL:
        case SIInputTypeText:
        case SIInputTypeEmail:
        case SIInputTypePhone:
        case SIInputTypeInteger:
        case SIInputTypeDouble:
        case SIInputTypePassword:
            //Update input view
            [self _initTextbox];
            
            break;
        case SIInputTypeDate:
        case SIInputTypeDateAndTime:
        case SIInputTypeCountDownTimer:
        case SIInputTypeTime:
        case SIInputTypeList:
        case SIInputTypeOptions:
            [self _initButton];
            break;
        default:
            break;
    }
}

#pragma mark - Update view

- (void) _initTextbox {
    if (self.inputTextField == nil) {
        self.inputTextField = [[UITextField alloc] init];
        [self addSubview:self.inputTextField];
        [self.inputTextField setDelegate:self];
    }
    [self.inputTextField setFrame:CGRectMake(self.padding, self.titleLabelHeight + 5, self.frame.size.width, self.frame.size.height - self.titleLabelHeight - 5)];
    [self.inputTextField setText:self.inputValue];
    [self.inputTextField setTextColor:self.inputTextColor];
    [self.inputTextField setReturnKeyType:UIReturnKeyDone];
    [self _updateKeyboardTypeByInputType];
}

- (void) _initButton {
    if (self.buttonInputTrigger == nil) {
        self.buttonInputTrigger = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.buttonInputTrigger setTitleColor:self.inputTextColor forState:UIControlStateNormal];
        [self.buttonInputTrigger setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self addSubview:self.buttonInputTrigger];
        [self.buttonInputTrigger addTarget:self action:@selector(inputButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (self.inputValue) {
        [self.buttonInputTrigger setTitle:self.inputValue forState:UIControlStateNormal];
    }
    
    [self.buttonInputTrigger setFrame:CGRectMake(self.padding, self.titleLabelHeight + 5, self.frame.size.width, self.frame.size.height - self.titleLabelHeight - 5)];
}

- (void) _updateKeyboardTypeByInputType {
    switch (self.inputType) {
        case SIInputTypeText:
            self.inputTextField.keyboardType = UIKeyboardTypeDefault;
            break;
        case SIInputTypeDouble:
        case SIInputTypeInteger:
            self.inputTextField.keyboardType = UIKeyboardTypeDecimalPad;
            break;
        case SIInputTypePhone:
            self.inputTextField.keyboardType = UIKeyboardTypePhonePad;
            break;
        case SIInputTypePassword:
            self.inputTextField.secureTextEntry = YES;
            break;
        case SIInputTypeEmail:
            self.inputTextField.keyboardType = UIKeyboardTypeEmailAddress;
            break;
        case SIInputTypeURL:
            self.inputTextField.keyboardType = UIKeyboardTypeURL;
            break;
        default:
            break;
    }
}

/**
 *  Check and create required view
 */
- (void) _initRequiredView {
    CGFloat requireViewWidth = 1.0f;
    if (self.requiredView == nil) {
        /* Initialize and add required level view */
        self.requiredView = [[UIView alloc] init];
        [self addSubview:self.requiredView];
    }
    [self.requiredView setFrame:CGRectMake(0, 0, requireViewWidth, self.frame.size.height)];
    [self.requiredView setBackgroundColor:self.requiredLevelColor];
}

/**
 *  Check and create label title view
 */
- (void) _initLabelTitle {
    if (self.titleLabel == nil) {
        self.titleLabelHeight = 25.0f;
        self.padding = 10.0f;
        /* Initialize and add required level view */
        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        [self.titleLabel setLineBreakMode:NSLineBreakByClipping];
        [self.titleLabel setNumberOfLines:1];
        [self.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self.titleLabel setTextColor:[UIColor darkGrayColor]];
        [self addSubview:self.titleLabel];
        self.titleLabel.userInteractionEnabled = NO;
    }
    [self.titleLabel setFrame:CGRectMake(self.padding, -5, self.frame.size.width, self.titleLabelHeight)];
    [self.titleLabel setText:self.labelTitle];
}

- (void) _presentOptions {
    
    UIAlertController *optionAlert = [UIAlertController alertControllerWithTitle:self.labelTitle message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIPopoverPresentationController *popPresenter = [optionAlert popoverPresentationController];
    popPresenter.sourceView = self;
    popPresenter.sourceRect = self.bounds;
    
    //Add options
    for (NSDictionary *item in self.options) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:item[@"title"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.buttonInputTrigger setTitle:action.title forState:UIControlStateNormal];
            
            if ([self.delegate respondsToSelector:@selector(SIInput:OptionDidChange:)]) {
                [self.delegate SIInput:self OptionDidChange:item];
            }
        }];
        [optionAlert addAction:action];
    }
    
    //Present options picker
    [[self _currentTopViewController] presentViewController:optionAlert animated:YES completion:nil];
}

/**
 *  Update required level view color base on property
 *
 *  @param requiredLevelColor
 */
- (void)setRequiredLevelColor:(UIColor *)requiredLevelColor {
    _requiredLevelColor = requiredLevelColor;
    [self.requiredView setBackgroundColor:requiredLevelColor];
}

- (void) setLabelTitle:(NSString *)labelTitle {
    _labelTitle = labelTitle;
    self.titleLabel.text = labelTitle;
}

- (void) setInputType:(SIInputType)inputType {
    _inputType = inputType;
    
    [self _updateKeyboardTypeByInputType];
}

#pragma mark - Validations
/**
 *  Check if the textfield should recieve input and update it base on input type
 *
 *  @param range
 *  @param string
 *
 *  @return
 */
-(BOOL) inputShouldUpdateCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    NSString *resultingString = [self.inputTextField.text stringByReplacingCharactersInRange: range withString: string];
    
    // The user deleting all input is perfectly acceptable.
    if ([resultingString length] < [self.inputTextField.text length]) {
        return YES;
    }
    
    switch (self.inputType) {
        case SIInputTypeInteger:
            return [Validator isIntegerByAppendingString:string toString:self.inputTextField.text];
            break;
        case SIInputTypeDouble:
            return [Validator isFloatByAppendingString:string toString:self.inputTextField.text];
            break;
        default:
            break;
    }
    
    return YES;
}

#pragma mark - UITextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(SIInputDidBeginEditing:)]) {
        [self.delegate SIInputDidBeginEditing:self];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(SIInputDidEndEditing:)]) {
        [self.delegate SIInputDidEndEditing:self];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.delegate && [self.delegate respondsToSelector:@selector(SIInput:shouldUpdateCharactersInRange:replacementString:)]) {
        return [self.delegate SIInput:self shouldUpdateCharactersInRange:range replacementString:string];
    }
    else {
        return [self inputShouldUpdateCharactersInRange:range replacementString:string];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SIInputShouldReturn:)]) {
        return [self.delegate SIInputShouldReturn:self];
    }
    else {
        [textField resignFirstResponder];
        return YES;
    }
}

#pragma mark - DatePopover Delegate

-(void)SIDateTimePickerControllerDidCancel:(SIDateTimePickerController *)sender {
    [sender dismissViewControllerAnimated:YES completion:nil];
}

-(void)SIDateTimePickerControllerDonePicking:(SIDateTimePickerController *)sender withDate:(NSDate *)date andCountdownDuration:(NSTimeInterval)duration{
    [sender dismissViewControllerAnimated:YES completion:nil];
    //update view
    [self.buttonInputTrigger setTitle:[self _getDisplayDateFromDate:date] forState:UIControlStateNormal];
    //update value
    self.dateValue = date;
    self.countdownInterval = duration;
}


#pragma mark - Gesture & Event

- (void) selfTap: (UITapGestureRecognizer*)tap {
    if (self.inputTextField) {
        [self.inputTextField becomeFirstResponder];
    }
    else {
        [self inputButtonTap:self.buttonInputTrigger];
    }
}

- (void) inputButtonTap:(UIButton*)sender {
    if (self.inputType == SIInputTypeDate ||
        self.inputType == SIInputTypeCountDownTimer ||
        self.inputType == SIInputTypeDateAndTime ||
        self.inputType == SIInputTypeTime) {
        //init controller
        SIDateTimePickerController* datePickerController = [[SIDateTimePickerController alloc] init];
        datePickerController.modalPresentationStyle = UIModalPresentationPopover;
        datePickerController.popoverPresentationController.sourceView = sender;
        datePickerController.delegate = self;
        
        //set date picker mode
        /* Note: After setting datePickerMode, the countDownDuration will be reset to 60. So set mode before set countdown duration */
        datePickerController.datePicker.datePickerMode = [self _getDatePickerModeByInputType:self.inputType];
        
        datePickerController.datePicker.date = self.dateValue;
        if (self.inputType == SIInputTypeCountDownTimer) {
            datePickerController.datePicker.countDownDuration = self.countdownInterval;
        }
        
        //present popover
        [[self _currentTopViewController] presentViewController:datePickerController animated:YES completion:nil];
    }
    else if(self.inputType == SIInputTypeList) {
        if ([self.dataSource respondsToSelector:@selector(presentingViewControllerForInput:)]) {
            SIListController *presentViewController = [self.dataSource presentingViewControllerForInput:self];
            presentViewController.modalPresentationStyle = UIModalPresentationPopover;
            presentViewController.popoverPresentationController.sourceView = sender;
            [[self _currentTopViewController] presentViewController:presentViewController animated:YES completion:nil];
        }
    }
    else if (self.inputType == SIInputTypeOptions) {
        [self _presentOptions];
    }
}


#pragma mark - Tweak Utils

- (UIViewController *) _currentTopViewController
{
    UIViewController *topVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while (topVC.presentedViewController)
    {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (NSString *) _getDisplayDateFromDate:(NSDate*)date {
    if ([self.dateFormat isEqualToString:@""] || self.dateFormat == nil) {
        self.dateFormat = [self _getDefaultDateFormatByInputType:self.inputType];
    }
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:self.dateFormat];
    
    return [df stringFromDate:date];
}

- (NSString *) _getDefaultDateFormatByInputType:(SIInputType)type {
    NSString * dateFormat;
    switch (type) {
        case SIInputTypeTime:
            dateFormat = @"HH':'mm";
            break;
        case SIInputTypeDateAndTime:
            dateFormat = @"yyyy'-'MM'-'dd' 'HH':'mm";
            break;
        case SIInputTypeCountDownTimer:
            dateFormat = @"HH':'mm";
            break;
        case SIInputTypeDate:
            dateFormat = @"yyyy'-'MM'-'dd";
            break;
        default:
            dateFormat = @"yyyy'-'MM'-'dd";
            break;
    }
    return dateFormat;
}

- (UIDatePickerMode) _getDatePickerModeByInputType:(SIInputType)type {
    UIDatePickerMode mode;
    switch (type) {
        case SIInputTypeTime:
            mode = UIDatePickerModeTime;
            break;
        case SIInputTypeDateAndTime:
            mode = UIDatePickerModeDateAndTime;
            break;
        case SIInputTypeCountDownTimer:
            mode = UIDatePickerModeCountDownTimer;
            break;
        case SIInputTypeDate:
            mode = UIDatePickerModeDate;
            break;
        default:
            mode = UIDatePickerModeDate;
            break;
    }
    return mode;
}

-(void)updateInputValue:(NSString *)value andKey:(NSString *)key {
    self.inputValue = value;
    self.inputKey = key;
    
    [self setNeedsDisplay];
}

@end