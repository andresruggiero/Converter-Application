//
//  CustomContentCell.h
//  Converter Application
//
//  Created by Andres Ruggiero on 3/18/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomContentCell : UITableViewCell
@property (weak, nonatomic)  NSString *baseNameLabel;
@property (weak, nonatomic)  NSString *baseCurrencyLabel;
@property (weak, nonatomic)  NSString *exchangeRateLabel;

@end
