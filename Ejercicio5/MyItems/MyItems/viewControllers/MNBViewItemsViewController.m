//
//  MNBViewItemsViewController.m
//  MyItems
//
//  Created by Marcelo Busico on 11/08/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "MNBViewItemsViewController.h"
#import "MNBItemTableViewCell.h"
#import "MNBItemEntity.h"
#import "MBProgressHUD.h"

@interface MNBViewItemsViewController () <MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
}

@property (nonatomic,strong) NSArray *items;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MNBViewItemsViewController

- (id)init
{
    self = [super initWithNibName:NSStringFromClass(self.class) bundle:[NSBundle mainBundle]];
    
    if (self) {
        self.title = @"View Items";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"View Items" image:[UIImage imageNamed:@"viewIcon"] tag:1];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadSavedData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)loadSavedData {
    HUD = [[MBProgressHUD alloc] initWithView:self.tabBarController.view];
	[self.tabBarController.view addSubview:HUD];
	HUD.mode = MBProgressHUDModeIndeterminate;
	HUD.delegate = self;
    [HUD show:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        self.items = [MNBItemEntity loadSavedData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [HUD hide:YES];
        });
    });
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.items) {
        return [self.items count];
    } else {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ItemCell";
    
    MNBItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"MNBItemTableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(MNBItemTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MNBItemEntity *item = self.items[indexPath.item];
    cell.itemTitle.text = item.title;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_AR"];
    
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale:locale];

    cell.itemPrice.text = [formatter stringFromNumber:item.price];
    if(item.images.count > 0) {
        cell.itemImage.image = item.images[0];
    }else {
        cell.itemImage.image = [UIImage imageNamed:@"placeholderIcon"];
    }
}

@end
