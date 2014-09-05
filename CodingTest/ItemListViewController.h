//
//  MasterViewController.h
//  CodingTest
//
//  Created by Jonathan Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemDetailViewController;

/*!
 *  @brief  This view controller will display a list of items
 */
// ASADO: Cambiaria el nombre por ItemListViewContorller
@interface ItemListViewController : UITableViewController

// ASADO: Cambiaria el nombre de la variable por itemDetailViewController
/*!
 *  @brief  View controller that will display an item
 */
@property (strong, nonatomic) ItemDetailViewController *itemDetailViewController;


@end