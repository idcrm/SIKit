//
//  ViewController.m
//  SIKit
//
//  Created by Khemarin on 3/2/16.
//  Copyright © 2016 Soteca. All rights reserved.
//

#import "ViewController.h"
#import "SIKit/SIKit.h"

@interface ViewController ()<SIListControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) SIFormThemeManager * theme;
@property (strong, nonatomic) SIListController *listController;

@property (strong, nonatomic) IBOutlet UICollectionView *formCollectionView;
@property (strong, nonatomic) NSArray *formModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.theme = [[SIFormThemeManager alloc] init];
    self.formCollectionView.backgroundColor = [UIColor clearColor];
    
    self.listController = [[SIListController alloc] init];
    self.listController.delegate = self;
    
    NSMutableArray *list = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        [list addObject:@{@"title" : [NSString stringWithFormat:@"Account %d", i]}];
    }
    self.listController.list = list;
    
    [self initInputView];
    [self initInputCollection];
}

- (void) initInputCollection {
    self.formModel = @[
                       @{
                           @"Label" : @"Subject",
                           @"Type"  : @(SIInputTypeText),
                           @"Value" : @"Hello World",
                           },
                       @{
                           @"Label" : @"Account",
                           @"Type"  : @(SIInputTypeList),
                           @"Value" : @"Account 3",
                           @"Required" :@true,
                           @"Identifier" : @"myAccountList"
                       },
                       @{
                           @"Label" : @"Option",
                           @"Type"  : @(SIInputTypeOptions),
                           @"Value" : @"Collective",
                           @"ReadOnly" :@true,
                           @"Options" : @[@{@"title": @"Professional", @"value" : @"1500000"},
                                          @{@"title": @"Collective", @"value" : @"1500001"},
                                          @{@"title": @"Particuler", @"value" : @"1500002"}
                                          ]
                           },
                       ];
    
    [self.formCollectionView registerClass:[SIInputCell class] forCellWithReuseIdentifier:@"SIInputCell"];
    [self.formCollectionView reloadData];
}

- (void) initInputView {
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
    self.inputSegment.inputType = SIInputTypeSegment;
    self.inputSegment.options = @[@{@"title" : @"Yellow"}, @{@"title": @"Blue"}];
    [self.inputSegment setInputControlFrame:CGRectMake(10, 20, 120, 30)];
    
    self.inputInteger.readOnly = YES;
    
    self.inputDate.inputValue = @"2017-01-01";
    
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
    if (controller.presenter && [controller.presenter isKindOfClass:[SIInput class]]) {
        [((SIInput *)controller.presenter) updateInputValue:item[@"title"] andKey:nil];
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SIInputDelegate/DataSource
-(void)SIInputDidEndEditing:(SIInput *)input {
    NSLog(@"identifier: %@", input.identifier);
}

-(SIListController *)presentingViewControllerForInput:(SIInput *)input{
    if ([input.identifier isEqualToString:@"myAccountList"]) {
        [self.listController refreshTableView];
        self.listController.presenter = input;
        return self.listController;
    }
    return nil;
}

-(void)SIInput:(SIInput *)input OptionDidChange:(NSDictionary *)option {
    NSLog(@"Input: %@, option: %@", input.identifier, option);
}

#pragma mark - CollectionView Delegate/DataSource


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.formModel count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(300, 40);
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SIInputCell * cell = (SIInputCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"SIInputCell" forIndexPath:indexPath];
    
    
    NSDictionary *option  = self.formModel[indexPath.row];
    
    cell.input.inputType  = [option[@"Type"] integerValue];
    cell.input.labelTitle = option[@"Label"];
    cell.input.identifier = option[@"Identifier"];
    [cell.input updateInputValue:option[@"Value"] andKey:nil];
    
    BOOL required = [option[@"Required"] boolValue];
    BOOL readOnly = [option[@"ReadOnly"] boolValue];
    
    //Bar Color
    if (readOnly) {
        cell.input.requiredLevelColor = [UIColor clearColor];
    }
    else if (required) {
        cell.input.requiredLevelColor = [UIColor redColor];
    }
    else {
        cell.input.requiredLevelColor = [UIColor grayColor];
    }
    
    cell.input.delegate = self;
    cell.input.dataSource = self;
    
    //Options
    switch (cell.input.inputType) {
        case SIInputTypeOptions:
            cell.input.options = option[@"Options"];
            break;
        case SIInputTypeList:
        default:
            break;
    }
    
    return cell;
}

@end
