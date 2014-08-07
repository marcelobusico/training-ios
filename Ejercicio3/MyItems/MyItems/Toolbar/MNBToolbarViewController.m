//
//  MNBToolbarViewController.m
//  MyItems
//
//  Created by Marcelo Busico on 31/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "MNBToolbarViewController.h"

@interface MNBToolbarViewController ()

@property (nonatomic, strong) IBOutlet UIButton *btnPrevious;
@property (nonatomic, strong) IBOutlet UIButton *btnNext;

@end

@implementation MNBToolbarViewController

- (id)init
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    
    if (self) {
        // Custom initialization
        _fields = [NSMutableArray array];
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    BOOL hideButtons = (self.fields.count <= 1);
    [self.btnPrevious setHidden:hideButtons];
    [self.btnNext setHidden:hideButtons];
}

-(IBAction)doneButtonPressed:(id)sender {
    for (UIView *view in self.fields) {
        [view resignFirstResponder];
    }
}

-(IBAction)previousButtonPressed:(id)sender {
    UIView *previousView = nil;
    for (UIView *view in self.fields) {
        if([view isFirstResponder]) {
            if(previousView) {
                [previousView becomeFirstResponder];
            }
            return;
        }
        previousView = view;
    }
}

-(IBAction)nextButtonPressed:(id)sender {
    UIView *previousView = nil;
    for (UIView *view in self.fields) {
        if([view isFirstResponder]) {
            previousView = view;
        } else {
            if(previousView) {
                [view becomeFirstResponder];
                return;
            }
        }
    }
}

@end
