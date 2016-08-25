//
//  SIListController.m
//  SIKit
//
//  Created by Khemarin on 5/19/16.
//  Copyright © 2016 Soteca. All rights reserved.
//

#import "SIListController.h"

@interface SIListController()

@property (strong, nonatomic) UITableView * tableView;

@end

@implementation SIListController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.tableView setDelegate:self];
        
        [self.view addSubview:self.tableView];
    }
    return self;
}

#pragma mark - UITableView Delegate & DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}

@end
