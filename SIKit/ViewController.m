//
//  ViewController.m
//  SIKit
//
//  Created by Khemarin on 3/2/16.
//  Copyright © 2016 Soteca. All rights reserved.
//

#import "ViewController.h"
#import "SIInputText.h"
#import "SIFormThemeManager.h"

@interface ViewController ()

@property (strong, nonatomic) SIFormThemeManager * theme;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.inputInteger setInputType:SIInputTypeInteger];
    [self.inputDouble setInputType:SIInputTypeDouble];
    [self.inputPhone setInputType:SIInputTypePhone];
    [self.inputUrl setInputType:SIInputTypeURL];
    [self.inputEmail setInputType:SIInputTypeEmail];
    [self.inputPassword setInputType:SIInputTypePassword];
    [self.inputDate setInputType:SIInputTypeDate];
    [self.inputTime setInputType:SIInputTypeTime];
    [self.inputDateTime setInputType:SIInputTypeDateAndTime];
    [self.inputCountDown setInputType:SIInputTypeCountDownTimer];
    
    self.inputInteger.delegate = self;
    self.inputInteger.identifier = @"int";
    
    self.inputDouble.delegate = self;
    self.inputDouble.identifier = @"double";
    
    self.theme = [[SIFormThemeManager alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SIInputDelegate/DataSource
-(void)SIInputDidEndEditing:(SIInput *)input {
    NSLog(@"identifier: %@", input.identifier);
}

#pragma mark - CollectionView Delegate/DataSource

/*
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(300, 60);
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"input_identifier";
    SIInputText * input = (SIInputText*)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (!input) {
        input = [[SIInputText alloc] init];
    }
    input.theme = self.theme;
    
    return input;
}
*/
@end
