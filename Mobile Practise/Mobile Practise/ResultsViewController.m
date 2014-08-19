//
//  ResultsViewController.m
//  Mobile Practise
//
//  Created by Marcelo Busico on 17/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "ResultsViewController.h"
#import "ItemCell.h"
#import "ItemEntity.h"
#import "UIImageView+AFNetworking.h"

@interface ResultsViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tblResults;

@end

@implementation ResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"itemCell";

	ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (cell == nil) {
		[tableView registerNib:[UINib nibWithNibName:@"ItemCell" bundle:nil]
		           forCellReuseIdentifier:CellIdentifier];

		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	}

	return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ItemCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	ItemEntity *itemEntity = [_results objectAtIndex:indexPath.row];

	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_AR"];
	UIImage *placeholder = [UIImage imageNamed:@"placeholderIcon"];

	[formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[formatter setLocale:locale];

	cell.lblTitle.text = itemEntity.title;
	cell.lblPrice.text = [formatter stringFromNumber:itemEntity.price];
	cell.itemImage.image = placeholder;
	__weak ItemCell *weakCell = cell;

	if (itemEntity.imageURL) {
		NSURL *url = [NSURL URLWithString:itemEntity.imageURL];
		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		[cell.itemImage setImageWithURLRequest:request
		                      placeholderImage:placeholder
		                               success: ^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
		    weakCell.itemImage.image = image;
		    [weakCell setNeedsLayout];
		} failure:nil];
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
