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

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self registerKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self unregisterKeyboardNotifications];
}

/*

 UIKIT_EXTERN NSString *const UIKeyboardWillShowNotification;
 UIKIT_EXTERN NSString *const UIKeyboardDidShowNotification;
 UIKIT_EXTERN NSString *const UIKeyboardWillHideNotification;
 UIKIT_EXTERN NSString *const UIKeyboardDidHideNotification;
 
*/

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
    UIEdgeInsets insets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0.0f, keyboardHeight, 0.0f);
    self.scrollView.contentInset = insets;
    self.scrollView.scrollIndicatorInsets = insets;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    
}

-(IBAction)nextButtonPressed:(id)sender {
    MNBCreateItemDescriptionViewController *descriptionViewController = [[MNBCreateItemDescriptionViewController alloc] init];
    [self.navigationController pushViewController:descriptionViewController animated:YES];
}

@end
