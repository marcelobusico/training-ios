//
//  MNBCreateItemDescriptionViewController.m
//  MyItems
//
//  Created by Marcelo Busico on 28/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "MNBCreateItemDescriptionViewController.h"


@interface MNBCreateItemDescriptionViewController ()

@property (nonatomic,weak) IBOutlet UITextView *txtDescription;

@end


@implementation MNBCreateItemDescriptionViewController

- (id)init
{
    self = [super initWithNibName:NSStringFromClass([self class])
                           bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        self.title = @"Description";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registerKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)unregisterKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    BOOL isPortrait = UIDeviceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation);
    CGFloat keyboardHeight = isPortrait ? CGRectGetHeight([[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]) : CGRectGetWidth([[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]);
    UIEdgeInsets insets = UIEdgeInsetsMake(self.txtDescription.contentInset.top, 0.0f, keyboardHeight, 0.0f);
    self.txtDescription.contentInset = insets;
    self.txtDescription.scrollIndicatorInsets = insets;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    
}

-(IBAction)hideKeyboard:(id)sender {
    [self.txtDescription resignFirstResponder];
}

@end
