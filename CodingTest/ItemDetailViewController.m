//
//  DetailViewController.m
//  CodingTest
//
//  Created by Exequiel Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "Item.h"
#import "ImagesURLS.h"
#import "UIImageView+SDWebImage_M13ProgressSuite.h"

@interface ItemDetailViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@property (nonatomic, weak) IBOutlet UIImageView* imageView;
@property (nonatomic, weak) IBOutlet UILabel* itemTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel* itemQuantityLabel;
@property (nonatomic, weak) IBOutlet UILabel* itemPriceLabel;
@property (nonatomic, weak) IBOutlet UILabel* itemDescriptionLabel;
@property (nonatomic, weak) IBOutlet UIView*  noItemView;

@end

@implementation ItemDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {

    if (_detailItem != newDetailItem) {
		_detailItem = newDetailItem;

		// Update the view.
		[self configureView];
	}

	if (self.masterPopoverController != nil) {
		[self.masterPopoverController dismissPopoverAnimated:YES];
	}
}

- (void)configureView {
	// Update the user interface for the detail item.
	if (self.detailItem) {
        self.itemTitleLabel.text = self.detailItem.title;

        self.imageView.image = [UIImage imageNamed:@"placeholder"];
        if (self.detailItem.images.count) {
            ImagesURLS *urls = self.detailItem.images[0];
            if (urls.big) {
                [self.imageView setImageUsingProgressViewRingWithURL:[NSURL URLWithString:urls.big] placeholderImage:[UIImage imageNamed:@"placeholder"] options:0 progress:nil completed:nil ProgressPrimaryColor:[UIColor clearColor] ProgressSecondaryColor:[UIColor clearColor] Diameter:50.];
            }
        }
        if (self.detailItem.quantity) {
            NSMutableAttributedString* quantityString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Quantity available: %d", [self.detailItem.quantity unsignedIntValue]]];
            [quantityString setAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]} range:NSMakeRange(0, 19)];
            self.itemQuantityLabel.attributedText = quantityString;
        }else{
            self.itemQuantityLabel.attributedText = nil;
            self.itemQuantityLabel.text = NSLocalizedString(@"No items left", nil);
        }

        if (self.detailItem.price) {
            NSMutableAttributedString* priceString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Price: %.2f", [self.detailItem.price floatValue]]];
            [priceString setAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]} range:NSMakeRange(0, 6)];
            self.itemPriceLabel.attributedText = priceString;
        }else{
            self.itemPriceLabel.attributedText = nil;
            self.itemPriceLabel.text = NSLocalizedString(@"No price", nil);
        }

        self.itemDescriptionLabel.text = self.detailItem.itemDescription;
        self.noItemView.hidden = YES;
    }else{
        self.noItemView.hidden = NO;
    }

}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self configureView];
}

#pragma mark - Split view
- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController {
	barButtonItem.title = NSLocalizedString(@"Master", @"Master");
	[self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
	self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
	[self.navigationItem setLeftBarButtonItem:nil animated:YES];
	self.masterPopoverController = nil;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
	return YES;
}

@end
