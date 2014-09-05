//
//  MasterViewController.m
//  CodingTest
//
//  Created by Exequiel Banga on 4/9/14.
//  Copyright (c) 2014 ExequielBanga. All rights reserved.
//

#import "ItemListViewController.h"
#import "ItemDetailViewController.h"

#import "ItemPaginator.h"
#import "ItemTableViewCell.h"
#import "SearchFilter.h"
#import "ListingsService.h"
#import "ImagesService.h"
#import "MBProgressHUD.h"
#import "Item.h"

#define kCellReuseIdentifier @"itemCell"
#define kTimeBetweenServiceCalls .25
@interface ItemListViewController ()<UISearchBarDelegate>
@property (nonatomic,strong)ListingsService *service;
@property (nonatomic,strong)ItemPaginator *itemPaginator;
@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic, strong) MBProgressHUD* loadingHUD;

@property (nonatomic, strong) NSMutableDictionary *imagesServices;

@end

@implementation ItemListViewController

- (void)awakeFromNib {
	[super awakeFromNib];
	if (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular && self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
		self.clearsSelectionOnViewWillAppear = NO;
		self.preferredContentSize = CGSizeMake(320.0, 600.0);
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];

    if ([[[self.splitViewController.viewControllers lastObject] topViewController] isKindOfClass:[ItemDetailViewController class]]) {
		self.itemDetailViewController = (ItemDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
	}

	[self.tableView registerNib:[UINib nibWithNibName:@"ItemTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kCellReuseIdentifier];

	self.tableView.estimatedRowHeight = 78.f;
	self.tableView.rowHeight = UITableViewAutomaticDimension;

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
    self.searchBar.showsCancelButton = YES;
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;
    

	[self callService];
}

#pragma mark - AditionalViews
- (void)showLoadingMessage {
    if (!self.loadingHUD) {
        self.loadingHUD = [[MBProgressHUD alloc] initWithView:self.view];
        self.loadingHUD.labelText = @"Loading";
        self.loadingHUD.color = [UIColor blackColor];
        self.loadingHUD.removeFromSuperViewOnHide = YES;
    }
    self.loadingHUD.frame = self.view.bounds;
    self.tableView.userInteractionEnabled = NO;
    [self.view addSubview:self.loadingHUD];
    [self.loadingHUD show:YES];
}

- (void)hideLoadingMessage {
    self.tableView.userInteractionEnabled = YES;
    [self.loadingHUD hide:YES];
}

- (void)showConnectionError{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Service Error" message:@"Please try again later" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}


#pragma mark - Services

- (SearchFilter *)searchFilter{
    SearchFilter *searchFilter = [SearchFilter new];
    searchFilter.pageSize = self.itemPaginator.pageSize;
    searchFilter.currentPage = self.itemPaginator.currentPage;
    searchFilter.queryString = self.searchBar.text;
    
    return searchFilter;
}

- (void)callService{
    if (!self.service) {
        self.service = [ListingsService new];
        self.itemPaginator = [ItemPaginator new];
    }
    SearchFilter *searchFilter = [self searchFilter];
    [self showLoadingMessage];
    [self.service getItemsWithSearchFilter:searchFilter withBlock:^(NSObject *response, NSError * error){
        [self hideLoadingMessage];
        if (error) {
            [self showConnectionError];
        }else{
            [self.itemPaginator.items addObjectsFromArray:(NSArray *)response];
            [self.tableView reloadData];
            NSArray *items = (NSArray *)response;
            for (NSInteger i = 0; i < items.count; i++) {
                Item *anItem = items[i];
                [self performSelector:@selector(getImageForItem:) withObject:anItem afterDelay:i*kTimeBetweenServiceCalls];
            }
        }
    }];
}

- (void)getImageForItem:(Item *)anItem{
    if (!self.imagesServices) {
        self.imagesServices = [NSMutableDictionary new];
    }
    ImagesService *service = self.imagesServices[anItem.itemId];
    if (!service) {
        service = [ImagesService new];
        [self.imagesServices setObject:service forKey:anItem.itemId];
        [service getImagesForItem:anItem withBlock:^(NSObject *response, NSError * error){
            if (response) {
                anItem.images  = (NSArray *)response;
            }
            [self.imagesServices removeObjectForKey:anItem.itemId];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.itemPaginator.items indexOfObject:anItem] inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
}

- (void)cancelGetImageForItem:(Item *)anItem{
    ImagesService *service = self.imagesServices[anItem];
    if (service) {
        [service invalidate];
        [self.imagesServices removeObjectForKey:anItem.itemId];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.itemPaginator.items.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //Last Cell
    if (indexPath.row == self.itemPaginator.items.count -1) {
        //Request next page
        self.itemPaginator.currentPage ++;
        [self callService];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	ItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
	[cell fillwithItem:self.itemPaginator.items[indexPath.row]];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	self.itemDetailViewController.detailItem = self.itemPaginator.items[indexPath.row];

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self showDetailViewController:[self.splitViewController.viewControllers lastObject] sender:nil];
    }else{
        [self showDetailViewController:self.itemDetailViewController sender:nil];
    }

}

#pragma mark - SearchBar
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    //Cleanup the last search
    [self.class cancelPreviousPerformRequestsWithTarget:self selector:@selector(getImageForItem:) object:nil];
    for (Item *anItem in self.itemPaginator.items) {
        [self cancelGetImageForItem:anItem];
    }
    self.itemPaginator = [ItemPaginator new];
    [self callService];
}

@end
