//
//  ExchangeManager.m
//  Exchange Rate Converter
//
//  Created by Andres Ruggiero on 2/2/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import "ExchangeManager.h"
#import "ExchangeCategory.h"
#import "CurrencyCollection.h"
#import "Item.h"
#import <Parse/Parse.h>

@implementation ExchangeManager

@synthesize categoryArray;

// Method to declare singleton class

+(id)sharedManager {
    static ExchangeManager *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"Testing init method");
        self.categoryArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) addExchangeCategory:(ExchangeCategory *) exchangeCategory{
    [self.categoryArray addObject:exchangeCategory];
}

#pragma mark - Getter Methods

-(NSArray *) getAllCategories{
    
    return self.categoryArray;
    
}

-(ExchangeCategory *) getExchangeCategoryWithName:(NSString *)name{
    
    for (ExchangeCategory *category in self.categoryArray) {
        if ([category.exchangeCategoryName isEqualToString:name]) {
            //NSLog(@"Found category with name: %@",category.exchangeCategoryName);
            return category;
        }
    }
    
    return nil;
}

-(NSArray *) getAllCurrencyCollectionsFromCategoryWithName:(NSString *)categoryName{
    
    NSArray *currencyCollectionArray;
    
    for (ExchangeCategory *category in self.categoryArray) {
        if ([category.exchangeCategoryName isEqualToString:categoryName]) {
            //NSLog(@"%@ %@",category.exchangeCategoryName, categoryName);
            currencyCollectionArray = category.currencyCollectionArray;
        }
    }
    return currencyCollectionArray;
}

-(CurrencyCollection *) getCurrencyCollectionWithName:(NSString *)name andExchangeCategoryName:(NSString *)categoryName{
    
    NSArray *currencyCollections = [self getAllCurrencyCollectionsFromCategoryWithName:categoryName];
    CurrencyCollection *result = nil;
    
    for (CurrencyCollection *collection in currencyCollections) {
        if ([collection.currencyCollectionName isEqualToString:name]) {
            //NSLog(@"Testing: %@",collection.currencyCollectionName);
            result = collection;
        }
    }
    
    return result;
}

-(CurrencyCollection *) getCurrencyCollectionWithName:(NSString *)name andExchangeCategoryWithName:(NSString *)categoryName{
    
    NSArray *currencyCollections = [self getAllCurrencyCollectionsFromCategoryWithName:categoryName];
    CurrencyCollection *result = nil;
    
    for (CurrencyCollection *collection in currencyCollections) {
        if ([collection.currencyCollectionName isEqualToString:name]) {
            NSLog(@"Testing: %@",collection.currencyCollectionName);
            result = collection;
        }
    }
    
    return result;
}

-(NSMutableArray *)getCurrencyCollectionsWithNames:(NSArray *)names andExchangeCategoryName:(NSString *)categoryName{
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (NSString *object in names) {
        if (![object isEqualToString:@"USD"]) {
            CurrencyCollection *collection = [self getCurrencyCollectionWithName:object andExchangeCategoryName:categoryName];
            //CurrencyCollection *collection = []
            
            if (collection != nil) {
                [result addObject:collection];
            } else {
                NSLog(@"Error: Currency Collection not found");
            }
        }
    }
    
    return result;
}

-(NSArray *) getItemsFromCurrencyCollectionWithName:(NSString *)name andExchangeCategoryName:(NSString *)categoryName{
    
    //CurrencyCollection *coll = [self getCurrencyCollectionWithName:name];
    
    CurrencyCollection *coll = [self getCurrencyCollectionWithName:name andExchangeCategoryWithName:categoryName];
    
    NSLog(@"Cat: %@",categoryName);
    NSLog(@"%lu",(unsigned long)[coll.itemsArray count]);
    
    return coll.itemsArray;
}

-(Item *)getItemFromCurrencyCollection:(CurrencyCollection *)collection fromBaseCurrency:(NSString *)baseCurrency toTargetCurrency:(NSString *)targetCurrency{
    
    Item *finalItem;
    
    for (Item *item in collection.itemsArray) {
        if (([item.baseCurrency isEqualToString:baseCurrency]) &&
            ([item.targetCurrency isEqualToString:targetCurrency]) &&
            (![item.baseCurrency isEqualToString:@"USD"])) {
            //NSLog(@"ExchangeRate: %@",item.exchangeRate);
            //NSLog(@"Name: %@",item.baseName);
            finalItem = item;
        }
    }
    
    //NSLog(@"Final Item Name: %@",finalItem.baseName);
    
    return finalItem;
}

-(NSArray *) loadParameter:(NSString *)parameter{
    
    PFConfig *config = [PFConfig getConfig];
    
    config = [PFConfig currentConfig];
    
    NSLog(@"Getting the latest config...");
    NSArray *message = config[parameter];
    
    if (!message) {
        NSLog(@"Falling back to default message.");
        //welcomeMessage = @"Welcome!";
    }
    
    return message;
    
}

@end
