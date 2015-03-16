//
//  ExchangeManager.m
//  Exchange Rate Converter
//
//  Created by Andres Ruggiero on 2/2/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import "ExchangeManager.h"
#import "ExchangeCategory.h"

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
            currencyCollectionArray = category.currencyCollectionArray;
        }
    }
    return currencyCollectionArray;
}

@end
