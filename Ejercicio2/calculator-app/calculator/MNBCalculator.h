//
//  Calculator.h
//  calculator
//
//  Created by Marcelo Busico on 22/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNBCalculator : NSObject

typedef enum
{
    OPERATION_SUM,
    OPERATION_SUBTRACTION,
    OPERATION_MULTIPLICATION,
    OPERATION_DIVISION
} MathOperation;

@property double currentValue;

@property MathOperation mathOperation;

-(void)setOperation:(MathOperation)operation withValue:(double)value;

-(double)applyOperationWith:(double) value;

-(double)addToCurrentValue:(double)value;

-(double)subtractFromCurrentValue:(double)value;

-(double)multiplyCurrentValue:(double)value;

-(double)divideCurrentValue:(double)value;

@end
