//
//  CurrencyCollection.h
//  Exchange Rate Converter
//
//  Created by Andres Ruggiero on 2/2/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrencyCollection : NSObject

@property (strong, nonatomic) NSString *currencyCollectionName;

// Array of items per Currency Collection
@property NSArray *itemsArray;

-(id) initWithName:(NSString *) name andArrayOfItems:(NSArray *)arrayOfItems;

@end
