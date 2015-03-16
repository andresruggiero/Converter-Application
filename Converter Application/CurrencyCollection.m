//
//  CurrencyCollection.m
//  Exchange Rate Converter
//
//  Created by Andres Ruggiero on 2/2/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import "CurrencyCollection.h"

@implementation CurrencyCollection

@synthesize currencyCollectionName;
@synthesize itemsArray;

-(id) initWithName:(NSString *) name andArrayOfItems:(NSArray *)arrayOfItems{
    self = [super init];
    if (self) {
        self.currencyCollectionName = name;
        self.itemsArray = [[NSArray alloc] initWithArray:arrayOfItems];
    }
    return  self;
}

@end
