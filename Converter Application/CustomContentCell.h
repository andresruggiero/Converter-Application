//
//  CustomContentCell.h
//  Converter Application
//
//  Created by Andres Ruggiero on 3/18/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *baseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *baseCurrencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *exchangeRateLabel;

@end
