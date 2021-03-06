//
//  MNBMainViewController.m
//  MyItems
//
//  Created by Marcelo Busico on 28/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "MNBMainViewController.h"
#import "MNBCreateItemMainDataViewController.h"
#import "MBProgressHUD.h"
#import "MNBItemEntity.h"

@interface MNBMainViewController () <MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
}

@end

@implementation MNBMainViewController

- (id)init
{
    self = [super initWithNibName:NSStringFromClass([self class])
                           bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        self.title = @"Create Items";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Create Items" image:[UIImage imageNamed:@"newIcon"] tag:0];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)optionCreateNewItem:(id)sender {
    MNBCreateItemMainDataViewController *createItemMainDataViewController = [[MNBCreateItemMainDataViewController alloc] init];
    
    [self.navigationController pushViewController:createItemMainDataViewController
                                         animated:YES];
}

- (IBAction)optionGenerateLotOfItems:(id)sender {
    HUD = [[MBProgressHUD alloc] initWithView:self.tabBarController.view];
	[self.tabBarController.view addSubview:HUD];
	HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
	HUD.delegate = self;
    [HUD show:YES];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static int AMOUNT_OF_ITEMS = 10000;
        NSInteger totalItems = [MNBItemEntity totalNumberOfStoredItems];
        
        dispatch_apply(AMOUNT_OF_ITEMS, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(size_t i) {
            NSInteger itemNumber = i + totalItems;
            NSString *itemId = [NSString stringWithFormat:@"item-%d", itemNumber];
            
            MNBItemEntity *itemEntity = [[MNBItemEntity alloc] init];
            itemEntity.title = [NSString stringWithFormat:@"Autogenerated #%d", itemNumber];
            itemEntity.subTitle = [NSString stringWithFormat:@"Subtitle #%d", itemNumber];
            itemEntity.price = [NSNumber numberWithFloat:123.45f];
            [itemEntity persistItemWithItemId:itemId];
            
            if(i % 100 == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    HUD.progress = ((float)i / AMOUNT_OF_ITEMS);
                });
            }
        });
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setInteger:totalItems + AMOUNT_OF_ITEMS forKey:@"totalItems"];
        [userDefaults synchronize];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            HUD.mode = MBProgressHUDModeText;
            HUD.labelText = @"Done!";
            [HUD hide:YES afterDelay:2];
        });
    });
}

-(IBAction)forgetAllItems:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [MNBItemEntity forgetAllItems];
    });
}

@end
