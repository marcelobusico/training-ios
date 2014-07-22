//
//  Calculator.m
//  calculator
//
//  Created by Marcelo Busico on 22/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "Calculator.h"

@interface Calculator ()

@end


@implementation Calculator

-(id)init{
    _currentValue = 0;
    return self;
}

-(double)addToCurrentValue:(double)value {
    self.currentValue += value;
    return self.currentValue;
}

-(double)substractFromCurrentValue:(double)value {
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
