//
//  NSDictionary+ItemEntity.m
//  Mobile Practise
//
//  Created by Marcelo Busico on 19/08/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "NSDictionary+ItemEntity.h"

@implementation NSDictionary (ItemEntity)

-(NSString *)getTitle {
    return self[@"title"];
}

-(NSNumber *)getPrice {
    return self[@"price"];
}

-(NSString *)getImageURL {
    return self[@"thumbnail"];
}

@end
