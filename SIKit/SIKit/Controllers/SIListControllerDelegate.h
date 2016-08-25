//
//  SIListControllerDelegate.h
//  SIKit
//
//  Created by Khemarin on 5/19/16.
//  Copyright © 2016 Soteca. All rights reserved.
//

#ifndef SIListControllerDelegate_h
#define SIListControllerDelegate_h

#import <Foundation/Foundation.h>

@class SIListController;

@protocol SIListControllerDelegate <NSObject>

-(void) listController:(SIListController*)controller didSelectRowAtIndexPath:(NSIndexPath*)indexPath;

@end

#endif /* SIListControllerDelegate_h */
