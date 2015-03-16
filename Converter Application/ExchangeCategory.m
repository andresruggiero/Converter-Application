//
//  ExchangeCategory.m
//  Exchange Rate Converter
//
//  Created by Andres Ruggiero on 2/2/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import "ExchangeCategory.h"
#import "CurrencyCollection.h"

@implementation ExchangeCategory

@synthesize exchangeCategoryName;
@synthesize currencyCollectionArray;

-(id) initWithName:(NSString *) name{
    self = [super init];
    if (self) {
        self.exchangeCategoryName = name;
        self.currencyCollectionArray = [[NSMutableArray alloc] init];
    }
    return  self;
}

-(void) addCurrencyCollection:(CurrencyCollection *)collection{
    [self.currencyCollectionArray addObject:collection];
}



@end
