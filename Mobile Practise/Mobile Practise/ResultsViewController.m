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

@interface ResultsViewController ()

@property(nonatomic,strong) IBOutlet UITableView *tblResults;

@end

@implementation ResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_results count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"itemCell";
    
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"ItemCell" bundle:nil]
        forCellReuseIdentifier:CellIdentifier];
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(ItemCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    ItemEntity *itemEntity = [_results objectAtIndex:indexPath.row];

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_AR"];
    
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale:locale];
    
    cell.lblTitle.text = [itemEntity title];
    cell.lblPrice.text = [formatter stringFromNumber:[itemEntity price]];
    
    if([itemEntity imageURL]) {
        NSURL *imageUrl = [NSURL URLWithString:[itemEntity imageURL]];
        
        [self downloadImageWithURL:imageUrl completionBlock:^(BOOL succeeded, UIImage *image) {
            if(succeeded) {
                cell.itemImage.image = image;
            }
        }];
    }
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
