//
//  MNBCalculatorMainViewController.m
//  calculator
//
//  Created by Marcelo Busico on 25/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "MNBCalculatorMainViewController.h"
#import "MNBCalculator.h"

@interface MNBCalculatorMainViewController ()

@property (nonatomic,strong) MNBCalculator *calculator;
@property (nonatomic,strong) NSMutableString *currentDisplayValue;

@property (nonatomic,weak) IBOutlet UILabel *displayLabel;
@property (nonatomic,weak) IBOutlet UILabel *operationLabel;

-(double)getConvertedDisplayValue;

@end

@implementation MNBCalculatorMainViewController

- (id)init
{
    self = [super initWithNibName:NSStringFromClass([MNBCalculatorMainViewController class]) bundle:nil];
    
    if (self) {
        // Custom initialization
        _calculator = [[MNBCalculator alloc] init];
        _currentDisplayValue = [NSMutableString stringWithString:@""];
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
    [_calculator applyOperationWith:[self getConvertedDisplayValue]];
    self.operationLabel.text = @"=";
    self.displayLabel.text = [NSString stringWithFormat:@"%f", self.calculator.currentValue];
}

-(IBAction)buttonPlusPressed:(id)sender {
    [self setOperation:OPERATION_SUM];
}

-(IBAction)buttonMinusPressed:(id)sender {
    [self setOperation:OPERATION_SUBTRACTION];
}

-(IBAction)buttonStarPressed:(id)sender {
    [self setOperation:OPERATION_MULTIPLICATION];
}

-(IBAction)buttonSlashPressed:(id)sender {
    [self setOperation:OPERATION_DIVISION];
}

-(IBAction)buttonClearPressed:(id)sender {
    [self clearDisplay];
}

-(IBAction)buttonClearAllPressed:(id)sender {
    self.calculator.currentValue = 0;
    self.operationLabel.text = @"";
    [self clearDisplay];
}

-(void)setOperation:(MathOperation) operation {
    [self buttonEqualsPressed:nil];
    [self.currentDisplayValue setString:self.displayLabel.text];
    
    switch (operation) {
        case OPERATION_SUM:
            self.operationLabel.text = @"+";
            break;
        case OPERATION_SUBTRACTION:
            self.operationLabel.text = @"-";
            break;
        case OPERATION_MULTIPLICATION:
            self.operationLabel.text = @"*";
            break;
        case OPERATION_DIVISION:
            self.operationLabel.text = @"/";
            break;
        default:
            break;
    }
    
    self.calculator.mathOperation = operation;
    [self.currentDisplayValue setString:@""];
}

-(double)getConvertedDisplayValue {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *value = [formatter numberFromString:self.currentDisplayValue];
    return [value doubleValue];
}

-(void)clearDisplay {
    [self.currentDisplayValue setString:@""];
    self.displayLabel.text = @"0";
}

-(void)updateDisplayAppendingValue:(NSString *)value {
    if([value isEqualToString:@"."] ) {
        if([self.currentDisplayValue rangeOfString:@"."].location == NSNotFound) {
            if([self.currentDisplayValue length] == 0) {
                //Appends the zero if the dot is the first char entered.
                [self.currentDisplayValue appendString:@"0"];
            }
        } else {
            return;
        }
    }
    
    [self.currentDisplayValue appendString:value];
    self.displayLabel.text = self.currentDisplayValue;
}

@end
