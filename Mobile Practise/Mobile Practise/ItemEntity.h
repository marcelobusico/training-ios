//
//  ItemEntity.h
//  Mobile Practise
//
//  Created by Marcelo Busico on 18/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemEntity : NSObject

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSNumber *price;
@property(nonatomic,strong) NSString *imageURL;

+(NSArray *)itemEntitiesFromData:(NSData *)jsonData;

@end
