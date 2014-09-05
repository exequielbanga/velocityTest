//
//  DetailViewController.h
//  CodingTest
//
//  Created by Jonathan Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) Item *detailItem;

@end

