//
//  ViewController.m
//  Mobile Practise
//
//  Created by Marcelo Busico on 17/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "ViewController.h"
#import "ResultsViewController.h"
#import "ItemEntity.h"
#import "MBProgressHUD.h"
#import "SearchManager.h"
#import "URLConnectionSearchManager.h"
#import "AFNetworkingSearchManager.h"

@interface ViewController () <MBProgressHUDDelegate> {
	MBProgressHUD *HUD;
}

@property (nonatomic, strong) IBOutlet UITextField *txtSearch;
@property (nonatomic, strong) NSObject <SearchManager> *searchManager;

@end


@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	HUD.delegate = self;
	HUD.mode = MBProgressHUDModeIndeterminate;
	[self.navigationController.view addSubview:HUD];

	//Choose the SearchManager you want to use
	self.searchManager = [[AFNetworkingSearchManager alloc] init];
	//self.searchManager = [[URLConnectionSearchManager alloc] init];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (IBAction)search:(id)sender {
	[HUD show:YES];

	NSString *searchString = [self.txtSearch.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	__weak typeof(self) weakSelf = self;

	[self.searchManager searchItemsWithQuery:searchString completionBlock: ^(NSArray *itemEntities) {
	    [HUD hide:YES];
	    if (itemEntities) {
	        [weakSelf showResults:itemEntities];
		}
	}];
}

- (void)showResults:(NSArray *)results {
	ResultsViewController *resultsViewController = [[ResultsViewController alloc] init];
	resultsViewController.title = @"Resultados";
	resultsViewController.results = results;

	[self.navigationController pushViewController:resultsViewController
	                                     animated:YES];
}

@end
