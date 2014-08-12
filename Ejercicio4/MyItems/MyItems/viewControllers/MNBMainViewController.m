//
//  MNBMainViewController.m
//  MyItems
//
//  Created by Marcelo Busico on 28/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "MNBMainViewController.h"
#import "MNBCreateItemMainDataViewController.h"

@interface MNBMainViewController ()

@end

@implementation MNBMainViewController

- (id)init
{
    self = [super initWithNibName:NSStringFromClass([self class])
                           bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        self.title = @"Create Items";
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

@end
