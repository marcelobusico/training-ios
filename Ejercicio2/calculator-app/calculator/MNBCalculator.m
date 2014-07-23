//
//  Calculator.m
//  calculator
//
//  Created by Marcelo Busico on 22/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "MNBCalculator.h"

@interface MNBCalculator ()

@end

@implementation MNBCalculator

-(id)init{
    self = [super init];
    
    if(self) {
        _currentDisplayValue = [NSMutableString stringWithString:@""];
        _currentValue = 0;
    }
    
    return self;
}

-(void)setOperation:(MathOperation) operation withValue:(NSString *)currentDisplayValue {
    [self.currentDisplayValue setString:currentDisplayValue];
    self.currentValue = [self getConvertedDisplayValue];
    self.mathOperation = operation;
    [self.currentDisplayValue setString:@""];
}

-(double)applyOperationWith:(double)value {
    double result = 0;
    
    switch (_mathOperation) {
        case OPERATION_SUM:
            result = [self addToCurrentValue:value];
            break;
        case OPERATION_SUBTRACTION:
            result = [self subtractFromCurrentValue:value];
            break;
        case OPERATION_MULTIPLICATION:
            result = [self multiplyCurrentValue:value];
            break;
        case OPERATION_DIVISION:
            result = [self divideCurrentValue:value];
            break;
        default:
            break;
    }
    
    _currentValue = result;
    
    return result;
}

-(double)getConvertedDisplayValue {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *value = [formatter numberFromString:self.currentDisplayValue];
    return [value doubleValue];
}

-(double)addToCurrentValue:(double)value {
    self.currentValue += value;
    return self.currentValue;
}

-(double)subtractFromCurrentValue:(double)value {
    self.currentValue -= value;
    return self.currentValue;
}

-(double)multiplyCurrentValue:(double)value {
    self.currentValue = self.currentValue * value;
    return self.currentValue;
}

-(double)divideCurrentValue:(double)value {
    self.currentValue = self.currentValue / value;
    return self.currentValue;
}

@end
