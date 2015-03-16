//
//  ParseBackEndManager.h
//  Converter Application
//
//  Created by Andres Ruggiero on 3/13/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ExchangeManager;

@interface ParseBackEndManager : NSObject{
    ExchangeManager *exchangeManager;
}

@property (strong, nonatomic) ExchangeManager *exchangeManager;

@end