//
//  StoreCoordinator.m
//  Exchange Rate Converter
//
//  Created by Andres Ruggiero on 2/2/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import "StoreCoordinator.h"
#import "ExchangeManager.h"
#import "ExchangeCategory.h"
#import "CurrencyCollection.h"
#import "Item.h"
#import "PListManager.h"

@implementation StoreCoordinator{
    // Array that contains the available codes
    NSArray *codeArray;
    
    // Array that contains the available lengths
    NSArray *lengthCodeArray;
}

@synthesize storeManager;
@synthesize exchangeManager;
@synthesize pListManager;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
#warning Need to replace storeManager with ParseBackEndManager
        //storeManager = [[StoreManager alloc] init];
        exchangeManager = [ExchangeManager sharedManager];
        
        codeArray = @[@"USD",@"EUR",@"GBP",@"CHF"];
        lengthCodeArray = [[NSArray alloc] initWithObjects:@"mm",@"cm",@"m",@"in",@"ft", nil];
        
        //[self saveDataFromXml];
        [self saveDataFromPLists];
    }
    return self;
}

/*-(void) saveDataFromXml{
    // Create the exchange category "Currency"
    ExchangeCategory *exchangeCategory = [[ExchangeCategory alloc] initWithName:@"Currency"];
    
    // For each code
    for (NSString *code in codeArray) {
        
        // Retrieve the ARRAY of currencies per CODE from the storeManager
        NSArray *array = [[self.storeManager getAllItems] objectForKey:code];
        
        // Create a currencyCollection for each CODE with corresponding ARRAY
        CurrencyCollection *currencyCollection = [[CurrencyCollection alloc] initWithName:code andArrayOfItems:array];
        
        // Add each currencyCollection to the exchangeCategory
        [exchangeCategory addCurrencyCollection:currencyCollection];
    }
    
    // Finally, add the exchangeCategory to the ExchangeManager singleton object
    [exchangeManager addExchangeCategory:exchangeCategory];
    
    //NSLog(@"Exchange Category Name: %@",exchangeCategory.exchangeCategoryName);
}*/

-(void) saveDataFromPLists{
    
    self.pListManager = [[PListManager alloc] init];
    NSMutableArray *categoriesArray = [[NSMutableArray alloc]initWithArray:[self.pListManager getAllCategories]];
    //NSLog(@"%@",categoriesArray);
    
    for (ExchangeCategory *category in categoriesArray) {
        NSLog(@"%@",category.exchangeCategoryName);
        [exchangeManager addExchangeCategory:category];
    }
    
    //NSLog(@"Category Count: %lu",(unsigned long)[exchangeManager.categoryArray count]);
    
    //ExchangeCategory *cat = [exchangeManager.categoryArray objectAtIndex:1];
    
    //for (CurrencyCollection *collection in cat.currencyCollectionArray) {
        //for (Item *item in collection.itemsArray) {
          //  NSLog(@"Item Base: %@",item.baseCurrency);
          //  NSLog(@" To: %@ From: %@",item.toCurrency,item.fromCurrency);
    //    }
   // }
    
}

@end
