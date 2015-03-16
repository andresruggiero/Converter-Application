//
//  StoreCoordinator.h
//  Exchange Rate Converter
//
//  Created by Andres Ruggiero on 2/2/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  StoreManager;
@class ExchangeManager;
@class PListManager;

@interface StoreCoordinator : NSObject{
    ExchangeManager *exchangeManager;
}

@property StoreManager *storeManager;
@property (strong, nonatomic) ExchangeManager *exchangeManager;
@property (strong, nonatomic) PListManager *pListManager;

-(void) saveDataFromPLists;
//-(void) saveDataFromXml;

@end
