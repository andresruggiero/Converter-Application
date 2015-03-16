//
//  Item.h
//  ParsingTesting
//
//  Created by Andres Ruggiero on 1/14/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (strong, nonatomic) NSString *targetName;
@property (strong, nonatomic) NSString *targetCurrency;
@property (strong, nonatomic) NSString *baseName;
@property (strong, nonatomic) NSString *baseCurrency;
@property (strong, nonatomic) NSString *exchangeRate;

@end
