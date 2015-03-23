//
//  CalculatorContainerViewController.m
//  Converter Application
//
//  Created by Andres Ruggiero on 3/23/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import "CalculatorContainerViewController.h"

@interface CalculatorContainerViewController ()

@end

@implementation CalculatorContainerViewController{
    NSMutableString *displayString;
    int currentNumber;
}

@synthesize display;

- (void)viewDidLoad {
    [super viewDidLoad];
    displayString = [[NSMutableString alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void) processDigit:(int)digit{
    
    currentNumber = currentNumber * 10 + digit;
    [displayString appendString:[NSString stringWithFormat:@"%i",digit]];
    self.display.text = displayString;
    
}

- (IBAction)clickDigit:(id)sender {
    
    int digit = (int)((UIButton *)sender).tag;
    
    if (digit == 10) {
        currentNumber = 0;
        [displayString setString: @""];
        display.text = displayString;
    } else {
        [self processDigit:digit];
    }
    
    
}

@end
