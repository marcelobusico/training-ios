//
//  ItemEntity.m
//  Mobile Practise
//
//  Created by Marcelo Busico on 18/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "ItemEntity.h"

@implementation ItemEntity

+(NSArray *)parseFrom:(NSDictionary *)json {
    
    NSArray *results = [json objectForKey:@"results"];
    NSMutableArray *items = [NSMutableArray array];
    
    for (NSDictionary *result in results) {
        ItemEntity *itemEntity = [[ItemEntity alloc] init];
        
        itemEntity.title = [result objectForKey:@"title"];
        itemEntity.price = [result objectForKey:@"price"];
        itemEntity.imageURL = [result objectForKey:@"thumbnail"];
        
        [items addObject:itemEntity];
    }
    
    return items;
}

@end
