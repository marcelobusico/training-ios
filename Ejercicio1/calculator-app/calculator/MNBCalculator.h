//
//  Calculator.h
//  calculator
//
//  Created by Marcelo Busico on 22/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNBCalculator : NSObject

@property double currentValue;

-(double)addToCurrentValue:(double)value;

-(double)substractFromCurrentValue:(double)value;

-(double)multiplyCurrentValue:(double)value;

-(double)divideCurrentValue:(double)value;

@end
