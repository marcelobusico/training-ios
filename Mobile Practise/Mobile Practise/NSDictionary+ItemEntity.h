//
//  NSDictionary+ItemEntity.h
//  Mobile Practise
//
//  Created by Marcelo Busico on 19/08/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ItemEntity)

@property (nonatomic,readonly,getter = getTitle) NSString *title;
@property (nonatomic,readonly,getter = getPrice) NSNumber *price;
@property (nonatomic,readonly,getter = getImageURL) NSString *imageURL;

@end
