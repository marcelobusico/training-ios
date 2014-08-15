//
//  MNBItemEntity.m
//  MyItems
//
//  Created by Marcelo Busico on 11/08/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "MNBItemEntity.h"

@implementation MNBItemEntity

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if(self) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.subTitle = [aDecoder decodeObjectForKey:@"subTitle"];
        self.price = [aDecoder decodeObjectForKey:@"price"];
        self.description = [aDecoder decodeObjectForKey:@"description"];
        self.images = [aDecoder decodeObjectForKey:@"images"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.subTitle forKey:@"subTitle"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.description forKey:@"description"];
    [aCoder encodeObject:self.images forKey:@"images"];
}

-(void)persistItem {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger totalItems = [userDefaults integerForKey:@"totalItems"];
    
    totalItems++;

    NSString *itemId = [NSString stringWithFormat:@"item-%d", totalItems];
    
    [self persistItemWithItemId:itemId];
    
    [userDefaults setInteger:totalItems forKey:@"totalItems"];
    [userDefaults synchronize];
}

-(void)persistItemWithItemId:(NSString *)itemId {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    
    [userDefaults setObject:data forKey:itemId];
}

+(void)forgetAllItems {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:0 forKey:@"totalItems"];
    [userDefaults synchronize];
}

+(NSArray *)loadSavedData {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger totalItems = [userDefaults integerForKey:@"totalItems"];

    NSMutableArray *items = [NSMutableArray array];

    for (int i = 1; i <= totalItems; i++) {
        NSString *itemId = [NSString stringWithFormat:@"item-%d",i];
        
        NSData *savedData = [userDefaults valueForKey:itemId];
        
        MNBItemEntity *item = nil;
        
        if(savedData) {
            item = [NSKeyedUnarchiver unarchiveObjectWithData:savedData];
        }
        
        if(item) {
            [items addObject:item];
        }
    }
    
    return items;
}

+(NSInteger)totalNumberOfStoredItems {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger totalItems = [userDefaults integerForKey:@"totalItems"];
    return totalItems;
}

@end
