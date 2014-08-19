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

static NSString * const kSearchURL = @"https://api.mercadolibre.com/sites/MLA/search?q=%@&limit=100";


@interface ViewController () <MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
}


@property(nonatomic,strong) IBOutlet UITextField *txtSearch;
-(IBAction)showResults:(id)sender;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    HUD.delegate = self;
    HUD.mode = MBProgressHUDModeIndeterminate;
    [self.navigationController.view addSubview:HUD];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)search:(id)sender {
    [HUD show:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *searchString = [self.txtSearch.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *stringUrl = [NSString stringWithFormat:kSearchURL, searchString];
        
        __weak typeof (self) weakSelf = self;
        
        NSURL *url = [NSURL URLWithString:stringUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLResponse *response;
        NSError *error;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        if (data.length > 0 && !error)
        {
            NSArray *itemEntities = [ItemEntity itemEntitiesFromData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUD hide:YES];
                [weakSelf showResults:itemEntities];
            });
        }
    });
}

-(void)showResults:(NSArray *) results {
    ResultsViewController *resultsViewController = [[ResultsViewController alloc] init];
    resultsViewController.title = @"Resultados";
    resultsViewController.results = results;
    
    [self.navigationController pushViewController:resultsViewController
                                         animated:YES];
}

@end
