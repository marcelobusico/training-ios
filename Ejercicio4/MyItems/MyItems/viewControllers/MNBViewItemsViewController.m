//
//  MNBViewItemsViewController.m
//  MyItems
//
//  Created by Marcelo Busico on 11/08/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "MNBViewItemsViewController.h"

@interface MNBViewItemsViewController ()

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
