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
#import "SIListController.h"

@interface ViewController ()<SIListControllerDelegate>

@property (strong, nonatomic) SIFormThemeManager * theme;
@property (strong, nonatomic) SIListController *listController;

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
    self.inputList.inputType = SIInputTypeList;
    
    self.inputOptions.inputType = SIInputTypeOptions;
    self.inputOptions.identifier = @"OptionsIdentifier";
    self.inputOptions.options = @[
                                  @{@"title": @"Professional", @"value" : @"1500000"},
                                  @{@"title": @"Collective", @"value" : @"1500001"},
                                  @{@"title": @"Particuler", @"value" : @"1500002"}
                                  ];
    self.inputOptions.delegate = self;
    
    self.inputInteger.delegate = self;
    self.inputInteger.identifier = @"int";
    
    self.inputDouble.delegate = self;
    self.inputDouble.identifier = @"double";
    
    self.inputList.delegate = self;
    self.inputList.dataSource = self;
    self.inputList.identifier = @"myAccountList";
    
    self.theme = [[SIFormThemeManager alloc] init];
    
    self.listController = [[SIListController alloc] init];
    self.listController.delegate = self;
    
    NSMutableArray *list = [NSMutableArray array];
    for (NSUInteger i = 0; i < 20; i++) {
        [list addObject:@{@"title" : [NSString stringWithFormat:@"Account %ld", i]}];
    }
    self.listController.list = list;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SIListController Delegate
-(UITableViewCell *)listController:(SIListController *)controller cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"listcell";
    UITableViewCell * cell = [controller.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.listController.list[indexPath.row][@"title"]];
    
    return cell;
}

-(void)listController:(SIListController *)controller didSelectItem:(id)item {
    NSLog(@"%@", item);
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SIInputDelegate/DataSource
-(void)SIInputDidEndEditing:(SIInput *)input {
    NSLog(@"identifier: %@", input.identifier);
}

-(SIListController *)presentingViewControllerForInput:(SIInput *)input{
    if ([input.identifier isEqualToString:@"myAccountList"]) {
        [self.listController refreshTableView];
        return self.listController;
    }
    return nil;
}

-(void)SIInput:(SIInput *)input OptionDidChange:(NSDictionary *)option {
    NSLog(@"Input: %@, option: %@", input.identifier, option);
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
