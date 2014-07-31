//
//  MNBCreateItemDescriptionViewController.m
//  MyItems
//
//  Created by Marcelo Busico on 28/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "MNBCreateItemDescriptionViewController.h"
#import "MNBToolbarViewController.h"
#import "MNBCreateItemImagesViewController.h"

@interface MNBCreateItemDescriptionViewController ()

@property (nonatomic,strong) IBOutlet UITextView *txtDescription;
@property (nonatomic, strong) MNBToolbarViewController *toolbarViewController;
@property (nonatomic, strong) MNBCreateItemImagesViewController *imagesViewController;

@end


@implementation MNBCreateItemDescriptionViewController

- (id)init
{
    self = [super initWithNibName:NSStringFromClass([self class])
                           bundle:[NSBundle mainBundle]];
    if (self) {
        self.title = @"Description";
        self.toolbarViewController = [[MNBToolbarViewController alloc] init];
        self.imagesViewController = [[MNBCreateItemImagesViewController alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerKeyboardNotifications];
    self.txtDescription.inputAccessoryView = self.toolbarViewController.view;
    [self.toolbarViewController.fields addObject:self.txtDescription];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

-(IBAction)nextButtonPressed:(id)sender {
    [self.navigationController pushViewController:self.imagesViewController animated:YES];
}

@end
