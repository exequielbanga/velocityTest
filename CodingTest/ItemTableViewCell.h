//
//  SingleTextTableViewCell.h
//  Allianz
//
//  Created by Exequiel Banga on 9/1/14.
//  Copyright (c) 2014 Exequiel Banga. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;

@interface ItemTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel     *itemLabel;
@property (nonatomic, weak) IBOutlet UIImageView *itemImageView;

- (void)fillwithItem:(Item *)anItem;

@end
