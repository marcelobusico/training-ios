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

@interface MNBViewItemsViewController ()

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
    self.items = [MNBItemEntity loadSavedData];
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.items) {
        return self.items.count;
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
