//
//  ItemEntity.m
//  Mobile Practise
//
//  Created by Marcelo Busico on 18/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "ItemEntity.h"
#import "NSDictionary+ItemEntity.h"

@implementation ItemEntity

+(id)itemEntityWithTitle:(NSString *)title price:(NSNumber *)price imageURL:(NSString *)imageURL {
    ItemEntity *itemEntity = [[ItemEntity alloc] init];
    
    itemEntity.title = title;
    itemEntity.price = price;
    itemEntity.imageURL = imageURL;
    
    return itemEntity;
}

+(NSArray *)itemEntitiesFromData:(NSData *)jsonData {
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSArray *results = json[@"results"];
    NSMutableArray *items = [NSMutableArray array];
    
    for (NSDictionary *item in results) {
        ItemEntity *itemEntity = [ItemEntity itemEntityWithTitle:item.title price:item.price imageURL:item.imageURL];
        [items addObject:itemEntity];
    }
    
    return items;
}

@end
