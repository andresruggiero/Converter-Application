//
//  ViewController.h
//  Converter Application
//
//  Created by Andres Ruggiero on 3/13/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExchangeManager;

@interface ViewController : UIViewController{
    ExchangeManager *exchangeManager;
}

@property (strong, nonatomic) ExchangeManager *exchangeManager;

@end

