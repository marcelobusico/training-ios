//
//  MNBCalculatorViewController.m
//  calculator
//
//  Created by Marcelo Busico on 23/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "MNBCalculatorViewController.h"
#import "MNBCalculator.h"

@interface MNBCalculatorViewController ()

@property MNBCalculator *calculator;
@property (nonatomic) IBOutlet UILabel *displayLabel;

@end

@implementation MNBCalculatorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _calculator = [[MNBCalculator alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)button0Pressed:(id)sender {
    [self updateDisplayAppendingValue:@"0"];
}

-(IBAction)button1Pressed:(id)sender {
    [self updateDisplayAppendingValue:@"1"];
}

-(IBAction)button2Pressed:(id)sender {
    [self updateDisplayAppendingValue:@"2"];
}

-(IBAction)button3Pressed:(id)sender {
    [self updateDisplayAppendingValue:@"3"];
}

-(IBAction)button4Pressed:(id)sender {
    [self updateDisplayAppendingValue:@"4"];
}

-(IBAction)button5Pressed:(id)sender {
    [self updateDisplayAppendingValue:@"5"];
}

-(IBAction)button6Pressed:(id)sender {
    [self updateDisplayAppendingValue:@"6"];
}

-(IBAction)button7Pressed:(id)sender {
    [self updateDisplayAppendingValue:@"7"];
}

-(IBAction)button8Pressed:(id)sender {
    [self updateDisplayAppendingValue:@"8"];
}

-(IBAction)button9Pressed:(id)sender {
    [self updateDisplayAppendingValue:@"9"];
}

-(IBAction)buttonDotPressed:(id)sender {
    [self updateDisplayAppendingValue:@"."];
}

-(IBAction)buttonEqualsPressed:(id)sender {
    [_calculator applyOperationWith:[_calculator getConvertedDisplayValue]];
    _displayLabel.text = [NSString stringWithFormat:@"%f",_calculator.currentValue];
}

-(IBAction)buttonPlusPressed:(id)sender {
    [_calculator setOperation:OPERATION_SUM withValue:_displayLabel.text];
}

-(IBAction)buttonMinusPressed:(id)sender {
    [_calculator setOperation:OPERATION_SUBTRACTION withValue:_displayLabel.text];
}

-(IBAction)buttonStarPressed:(id)sender {
    [_calculator setOperation:OPERATION_MULTIPLICATION withValue:_displayLabel.text];
}

-(IBAction)buttonSlashPressed:(id)sender {
    [_calculator setOperation:OPERATION_DIVISION withValue:_displayLabel.text];
}

-(IBAction)buttonClearPressed:(id)sender {
    [self clearDisplay];
}

-(IBAction)buttonClearAllPressed:(id)sender {
    _calculator.currentValue = 0;
    [self clearDisplay];
}

-(void)clearDisplay {
    [_calculator.currentDisplayValue setString:@""];
    _displayLabel.text = @"0";
}

-(void)updateDisplayAppendingValue:(NSString *)value {
    if([value isEqualToString:@"."] ) {
        if([[_calculator currentDisplayValue] rangeOfString:@"."].location == NSNotFound) {
            if([[_calculator currentDisplayValue] length] == 0) {
                //Appends the zero if the dot is the first char entered.
                [[_calculator currentDisplayValue] appendString:@"0"];
            }
        } else {
            return;
        }
    }
    
    [[_calculator currentDisplayValue] appendString:value];
    _displayLabel.text = _calculator.currentDisplayValue;
}

@end
