//
//  CalculatorContainerViewController.h
//  Converter Application
//
//  Created by Andres Ruggiero on 3/23/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorContainerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;
- (IBAction)clickDigit:(id)sender;


@end
