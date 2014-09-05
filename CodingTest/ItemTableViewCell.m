//
//  SingleTextTableViewCell.m
//  Allianz
//
//  Created by Exequiel Banga on 9/1/14.
//  Copyright (c) 2014 Exequiel Banga. All rights reserved.
//

#import "ItemTableViewCell.h"
#import "Item.h"
#import "ImagesURLS.h"
#import "UIImageView+SDWebImage_M13ProgressSuite.h"

@implementation ItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)fillwithItem:(Item *)anItem{
    self.itemLabel.text = anItem.title;
    self.imageView.image = [UIImage imageNamed:@"placeholder"];
    if (anItem.images.count) {
        ImagesURLS *urls = anItem.images[0];
        if (urls.small) {
            [self.imageView setImageUsingProgressViewRingWithURL:[NSURL URLWithString:urls.small] placeholderImage:[UIImage imageNamed:@"placeholder"] options:0 progress:nil completed:nil ProgressPrimaryColor:[UIColor clearColor] ProgressSecondaryColor:[UIColor clearColor] Diameter:50.];
        }
    }
}

@end
