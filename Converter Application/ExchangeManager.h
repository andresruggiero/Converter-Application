//
//  ExchangeManager.h
//  Exchange Rate Converter
//
//  Created by Andres Ruggiero on 2/2/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ExchangeCategory;
@class CurrencyCollection;
@class Item;

@interface ExchangeManager : NSObject

// Array of categories
@property NSMutableArray *categoryArray;


// Method to declare singleton class
+ (id) sharedManager;

-(void) addExchangeCategory:(ExchangeCategory *)exchangeCategory;

// Fetching data methods
-(NSArray *) getAllCategories;
-(NSArray *) getAllCurrencyCollectionsFromCategoryWithName:(NSString *)categoryName;
-(ExchangeCategory *) getExchangeCategoryWithName:(NSString *)name;
-(CurrencyCollection *) getCurrencyCollectionWithName:(NSString *)name;
-(NSMutableArray *)getCurrencyCollectionsWithNames:(NSArray *)names;
-(Item *)getItemFromCurrencyCollection:(CurrencyCollection *)collection fromBaseCurrency:(NSString *)baseCurrency toTargetCurrency:(NSString *)targetCurrency;

-(NSArray *) loadParameter:(NSString *)parameter;

@end
