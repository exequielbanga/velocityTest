//
//  DetailViewController.h
//  CodingTest
//
//  Created by Jonathan Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Item;

/*!
 *  @brief  This view controller will display a detail of an item
 */
@interface ItemDetailViewController : UIViewController <UISplitViewControllerDelegate>

/*!
 *  @brief  Item to display
 */
@property (strong, nonatomic) Item* detailItem;

@end
