//
//  ConverterViewController.m
//  Converter Application
//
//  Created by Andres Ruggiero on 3/23/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import "ConverterViewController.h"
#import "ViewController.h"
#import "ExchangeManager.h"
#import "ExchangeCategory.h"

@interface ConverterViewController ()

@end

@implementation ConverterViewController

@synthesize showButton;
@synthesize containerView;
@synthesize exchangeManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.containerView setHidden:YES];
    exchangeManager = [ExchangeManager sharedManager];
    
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

- (IBAction)showContainer:(id)sender {
    
    [UIView transitionWithView:self.containerView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self.containerView setHidden:NO];
                        [self.containerView setAlpha:1.0];}
                    completion:nil];
}

#pragma mark - UITableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    int tag = (int)tableView.tag;
    switch (tag) {
        case 0:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    
    int tag = (int)tableView.tag;
    
    switch (tag) {
        case 0:{
            NSArray *cat = [exchangeManager getAllCategories];
            return [cat count];
            break;
        }
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int tag = (int)tableView.tag;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    switch (tag) {
        case 0:{
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            }
            
            NSArray *categories = [exchangeManager getAllCategories];
            
            ExchangeCategory *cat = [categories objectAtIndex:[indexPath row]];
            
            [cell.textLabel setText:cat.exchangeCategoryName];
            
            return cell;
        }
            break;
            
        default:
            return cell;
            break;
    }

}



@end
