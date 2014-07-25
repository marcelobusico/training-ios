//
//  calculatorTests.m
//  calculatorTests
//
//  Created by Marcelo Busico on 22/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNBCalculator.h"

@interface CalculatorTests : XCTestCase

@property MNBCalculator *calculator;

@end

@implementation CalculatorTests

- (void)setUp
{
    [super setUp];
    _calculator = [[MNBCalculator alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}


- (void)testAddOperationToCurrentValue
{
    XCTAssertEqual(_calculator.currentValue, 0, @"Initial value of calculator should be zero.");
    
    [_calculator addToCurrentValue: 5];
    XCTAssertEqual(_calculator.currentValue, 5, @"Unexpected current value in calculator.");
    
    [_calculator addToCurrentValue: 7];
    XCTAssertEqual(_calculator.currentValue, 12, @"Unexpected current value in calculator.");
    
    [_calculator addToCurrentValue: 3.141592];
    XCTAssertEqual(_calculator.currentValue, 15.141592, @"Unexpected current value in calculator.");
}


- (void)testSubstractOperationFromCurrentValue
{
    XCTAssertEqual(_calculator.currentValue, 0, @"Initial value of calculator should be zero.");
    
    [_calculator subtractFromCurrentValue: 5];
    XCTAssertEqual(_calculator.currentValue, -5, @"Unexpected current value in calculator.");
    
    [_calculator subtractFromCurrentValue: 7];
    XCTAssertEqual(_calculator.currentValue, -12, @"Unexpected current value in calculator.");
    
    [_calculator subtractFromCurrentValue: 3.141592];
    XCTAssertEqual(_calculator.currentValue, -15.141592, @"Unexpected current value in calculator.");
}


- (void)testMultiplyOperationByCurrentValue
{
    _calculator.currentValue = 3;
    XCTAssertEqual(_calculator.currentValue, 3, @"Initial value of calculator should be zero.");
    
    [_calculator multiplyCurrentValue: 5];
    XCTAssertEqual(_calculator.currentValue, 15, @"Unexpected current value in calculator.");
    
    [_calculator multiplyCurrentValue: 2];
    XCTAssertEqual(_calculator.currentValue, 30, @"Unexpected current value in calculator.");
}


- (void)testDivideOperationUsingCurrentValue
{
    _calculator.currentValue = 20;
    XCTAssertEqual(_calculator.currentValue, 20, @"Initial value of calculator should be zero.");
    
    [_calculator divideCurrentValue: 2];
    XCTAssertEqual(_calculator.currentValue, 10, @"Unexpected current value in calculator.");
    
    [_calculator divideCurrentValue: 5];
    XCTAssertEqual(_calculator.currentValue, 2, @"Unexpected current value in calculator.");
}

- (void)testCombineMultipleOperations
{
    _calculator.currentValue = 3;
    XCTAssertEqual(_calculator.currentValue, 3, @"Initial value of calculator should be zero.");
    
    [_calculator addToCurrentValue: 7];
    XCTAssertEqual(_calculator.currentValue, 10, @"Unexpected current value in calculator.");
    
    [_calculator divideCurrentValue: 5];
    XCTAssertEqual(_calculator.currentValue, 2, @"Unexpected current value in calculator.");
    
    [_calculator multiplyCurrentValue: 9];
    XCTAssertEqual(_calculator.currentValue, 18, @"Unexpected current value in calculator.");
    
    [_calculator subtractFromCurrentValue: 3];
    XCTAssertEqual(_calculator.currentValue, 15, @"Unexpected current value in calculator.");
}

@end
