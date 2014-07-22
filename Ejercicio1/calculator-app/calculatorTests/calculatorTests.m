//
//  calculatorTests.m
//  calculatorTests
//
//  Created by Marcelo Busico on 22/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Calculator.h"

@interface CalculatorTests : XCTestCase

@property Calculator *calculator;

@end

@implementation CalculatorTests

- (void)setUp
{
    [super setUp];
    _calculator = [[Calculator alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}


- (void)test_add_operation_to_current_value
{
    XCTAssertEqual(_calculator.currentValue, 0, @"Initial value of calculator should be zero.");
    
    [_calculator addToCurrentValue: 5];
    XCTAssertEqual(_calculator.currentValue, 5, @"Unexpected current value in calculator.");
    
    [_calculator addToCurrentValue: 7];
    XCTAssertEqual(_calculator.currentValue, 12, @"Unexpected current value in calculator.");
    
    [_calculator addToCurrentValue: 3.141592];
    XCTAssertEqual(_calculator.currentValue, 15.141592, @"Unexpected current value in calculator.");
}


- (void)test_substract_operation_from_current_value
{
    XCTAssertEqual(_calculator.currentValue, 0, @"Initial value of calculator should be zero.");
    
    [_calculator substractFromCurrentValue: 5];
    XCTAssertEqual(_calculator.currentValue, -5, @"Unexpected current value in calculator.");
    
    [_calculator substractFromCurrentValue: 7];
    XCTAssertEqual(_calculator.currentValue, -12, @"Unexpected current value in calculator.");
    
    [_calculator substractFromCurrentValue: 3.141592];
    XCTAssertEqual(_calculator.currentValue, -15.141592, @"Unexpected current value in calculator.");
}


- (void)test_multiply_operation_by_current_value
{
    _calculator.currentValue = 3;
    XCTAssertEqual(_calculator.currentValue, 3, @"Initial value of calculator should be zero.");
    
    [_calculator multiplyCurrentValue: 5];
    XCTAssertEqual(_calculator.currentValue, 15, @"Unexpected current value in calculator.");
    
    [_calculator multiplyCurrentValue: 2];
    XCTAssertEqual(_calculator.currentValue, 30, @"Unexpected current value in calculator.");
}


- (void)test_divide_operation_using_current_value
{
    _calculator.currentValue = 20;
    XCTAssertEqual(_calculator.currentValue, 20, @"Initial value of calculator should be zero.");
    
    [_calculator divideCurrentValue: 2];
    XCTAssertEqual(_calculator.currentValue, 10, @"Unexpected current value in calculator.");
    
    [_calculator divideCurrentValue: 5];
    XCTAssertEqual(_calculator.currentValue, 2, @"Unexpected current value in calculator.");
}

- (void)test_combine_multiple_operations
{
    _calculator.currentValue = 3;
    XCTAssertEqual(_calculator.currentValue, 3, @"Initial value of calculator should be zero.");
    
    [_calculator addToCurrentValue: 7];
    XCTAssertEqual(_calculator.currentValue, 10, @"Unexpected current value in calculator.");
    
    [_calculator divideCurrentValue: 5];
    XCTAssertEqual(_calculator.currentValue, 2, @"Unexpected current value in calculator.");
    
    [_calculator multiplyCurrentValue: 9];
    XCTAssertEqual(_calculator.currentValue, 18, @"Unexpected current value in calculator.");
    
    [_calculator substractFromCurrentValue: 3];
    XCTAssertEqual(_calculator.currentValue, 15, @"Unexpected current value in calculator.");
}


@end
