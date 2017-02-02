//
//  ViewController.h
//  SIKit
//
//  Created by Khemarin on 3/2/16.
//  Copyright © 2016 Soteca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIInput.h"

@interface ViewController : UIViewController<SIInputDelegate, SIInputDataSource>

@property (strong, nonatomic) IBOutlet SIInput *inputInteger;
@property (strong, nonatomic) IBOutlet SIInput *inputDouble;
@property (strong, nonatomic) IBOutlet SIInput *inputText;
@property (strong, nonatomic) IBOutlet SIInput *inputPhone;
@property (strong, nonatomic) IBOutlet SIInput *inputUrl;
@property (strong, nonatomic) IBOutlet SIInput *inputEmail;
@property (strong, nonatomic) IBOutlet SIInput *inputPassword;
@property (strong, nonatomic) IBOutlet SIInput *inputDate;
@property (strong, nonatomic) IBOutlet SIInput *inputDateTime;
@property (strong, nonatomic) IBOutlet SIInput *inputCountDown;
@property (strong, nonatomic) IBOutlet SIInput *inputTime;
@property (strong, nonatomic) IBOutlet SIInput *inputList;
@property (strong, nonatomic) IBOutlet SIInput *inputOptions;
@property (strong, nonatomic) IBOutlet SIInput *inputSegment;

@end

