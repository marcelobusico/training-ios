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

@end
