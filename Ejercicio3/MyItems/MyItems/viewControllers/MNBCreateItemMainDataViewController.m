//
//  MNBCreateItemMainDataViewController.m
//  MyItems
//
//  Created by Marcelo Busico on 28/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "MNBCreateItemMainDataViewController.h"
#import "MNBCreateItemDescriptionViewController.h"

@interface MNBCreateItemMainDataViewController ()

@end

@implementation MNBCreateItemMainDataViewController

- (id)init
{
    self = [super initWithNibName:NSStringFromClass([self class])
                           bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        self.title = @"Main Data";
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

-(IBAction)nextButtonPressed:(id)sender {
    MNBCreateItemDescriptionViewController *descriptionViewController = [[MNBCreateItemDescriptionViewController alloc] init];
    
    [self.navigationController pushViewController:descriptionViewController
                                         animated:YES];
}

@end
