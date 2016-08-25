//
//  SIListController.h
//  SIKit
//
//  Created by Khemarin on 5/19/16.
//  Copyright © 2016 Soteca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIListControllerDelegate.h"

@interface SIListController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray<NSDictionary *> * list;

@end
