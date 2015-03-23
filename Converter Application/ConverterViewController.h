//
//  ConverterViewController.h
//  Converter Application
//
//  Created by Andres Ruggiero on 3/23/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConverterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *showButton;
- (IBAction)showContainer:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
