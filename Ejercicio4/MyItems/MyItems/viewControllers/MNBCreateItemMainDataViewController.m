//
//  MNBCreateItemMainDataViewController.m
//  MyItems
//
//  Created by Marcelo Busico on 28/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "MNBCreateItemMainDataViewController.h"
#import "MNBCreateItemDescriptionViewController.h"
#import "MNBToolbarViewController.h"
#import "MNBItemEntity.h"

@interface MNBCreateItemMainDataViewController ()

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) IBOutlet UITextField *txtTitle;
@property (nonatomic, strong) IBOutlet UITextField *txtSubtitle;
@property (nonatomic, strong) IBOutlet UITextField *txtPrice;
@property (nonatomic, strong) MNBToolbarViewController *toolbarViewController;
@property (nonatomic, strong) MNBCreateItemDescriptionViewController *descriptionViewController;
@property (nonatomic, strong) MNBItemEntity *itemEntity;

@end

@implementation MNBCreateItemMainDataViewController

- (id)init
{
    self = [super initWithNibName:NSStringFromClass([self class])
                           bundle:[NSBundle mainBundle]];
    if (self) {
        self.title = @"New Item";
        self.toolbarViewController = [[MNBToolbarViewController alloc] init];
        self.itemEntity = [[MNBItemEntity alloc] init];
        self.descriptionViewController = [[MNBCreateItemDescriptionViewController alloc] initWithItemEntity:self.itemEntity];
        //self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.txtTitle.inputAccessoryView = self.toolbarViewController.view;
    self.txtSubtitle.inputAccessoryView = self.toolbarViewController.view;
    self.txtPrice.inputAccessoryView = self.toolbarViewController.view;
    [self.toolbarViewController.fields addObject:self.txtTitle];
    [self.toolbarViewController.fields addObject:self.txtSubtitle];
    [self.toolbarViewController.fields addObject:self.txtPrice];
    self.txtTitle.delegate = self;
    self.txtSubtitle.delegate = self;
    self.txtPrice.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self registerKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self unregisterKeyboardNotifications];
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
    UIEdgeInsets insets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0.0f, keyboardHeight, 0.0f);
    self.scrollView.contentInset = insets;
    self.scrollView.scrollIndicatorInsets = insets;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    UIEdgeInsets insets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0.0f, self.tabBarController.tabBar.frame.size.height, 0.0f);
    self.scrollView.contentInset = insets;
    self.scrollView.scrollIndicatorInsets = insets;
}

-(IBAction)nextButtonPressed:(id)sender {
    if([self.txtTitle.text isEqualToString:@""] ||
       [self.txtPrice.text isEqualToString:@""] ||
       ![self isValidNumberWithString:self.txtPrice.text]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing required data!" message:@"Please enter title and a valid price for the item." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        [alert show];
        
        return;
    }
    
    self.itemEntity.title = self.txtTitle.text;
    self.itemEntity.subTitle = self.txtSubtitle.text;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    self.itemEntity.price = [numberFormatter numberFromString:self.txtPrice.text];
    
    [self.navigationController pushViewController:self.descriptionViewController animated:YES];
}

-(BOOL)isValidNumberWithString:(NSString *)string {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^(\\d+)?(\\.(\\d{1,2})?)?$" options:NSRegularExpressionCaseInsensitive error:&error];
    NSRange textRange = NSMakeRange(0, string.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    
    BOOL didValidate = NO;
    
    if(matchRange.location != NSNotFound) {
        didValidate = YES;
    }

    return didValidate;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([textField isEqual:self.txtPrice]) {
        //Validate only numeric characters
        return [self isValidNumberWithString:string];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if([textField isEqual:self.txtTitle]) {
        //First textfield
        [self.toolbarViewController setButtonPreviousEnabled:NO];
        [self.toolbarViewController setButtonNextEnabled:YES];
    } else if([textField isEqual:self.txtPrice]) {
        //Last textfield
        [self.toolbarViewController setButtonPreviousEnabled:YES];
        [self.toolbarViewController setButtonNextEnabled:NO];
    } else {
        //Any other text field in the middle
        [self.toolbarViewController setButtonPreviousEnabled:YES];
        [self.toolbarViewController setButtonNextEnabled:YES];
    }
}

@end
