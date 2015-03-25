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
#import "Item.h"
#import "CurrencyCollection.h"

#define CATEGORY_TABLE 0
#define BASE_CURRENCY_TABLE 1
#define TARGET_CURRENCY_TABLE 2

@interface ConverterViewController ()

@end

@implementation ConverterViewController

@synthesize showButton;
@synthesize containerView;
@synthesize exchangeManager;
@synthesize categoriesTableView, baseCurrencyTableView, targetCurrencyTableView;

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

- (NSIndexPath *)currentSelectedIndexForTableView:(UITableView *)table
{
    NSIndexPath *selectedIndexPath = [table indexPathForSelectedRow];
    if (selectedIndexPath) {
        return selectedIndexPath;
    }
    else {
        return nil;
    }
}

-(NSString *) getSelectedExchangeCategoryName{
    
    NSIndexPath *path = [self currentSelectedIndexForTableView:self.categoriesTableView];
    //if (path != nil) {
    UITableViewCell *cell  = [self.categoriesTableView cellForRowAtIndexPath:path];
    //NSLog(@"text: %@",cell.textLabel.text);
    
    return cell.textLabel.text;
}


#pragma mark - UITableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    int tag = (int)tableView.tag;
    switch (tag) {
        case CATEGORY_TABLE:
            return 1;
            break;
        case BASE_CURRENCY_TABLE:
            return 1;
            break;
        case TARGET_CURRENCY_TABLE:
            return 1;
        default:
            return 0;
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    
    int tag = (int)tableView.tag;
    
    switch (tag) {
        case CATEGORY_TABLE:{
            NSArray *cat = [exchangeManager getAllCategories];
            return [cat count];
            break;
        }
        case BASE_CURRENCY_TABLE:{
            
            NSString *categoryName = [self getSelectedExchangeCategoryName];
            
            NSArray *currencyCollections = [exchangeManager getAllCurrencyCollectionsFromCategoryWithName:categoryName];
            
            //NSLog(@"%lu",(unsigned long)[currencyCollections count]);
            
            return [currencyCollections count];
            //return 0;
            
            break;
        }
        case TARGET_CURRENCY_TABLE:{
            
            NSString *categoryName = [self getSelectedExchangeCategoryName];
            
            NSIndexPath *path = [self currentSelectedIndexForTableView:self.baseCurrencyTableView];
            UITableViewCell *cell  = [self.baseCurrencyTableView cellForRowAtIndexPath:path];
            //NSLog(@"text: %@",cell.textLabel.text);
            
            NSString *string = cell.textLabel.text;
            
            NSArray *ar = [exchangeManager getItemsFromCurrencyCollectionWithName:string andExchangeCategoryName:categoryName];
            
            NSLog(@"Category: %@ # elements: %lu",categoryName,(unsigned long)[ar count]);
            
            return [ar count];
            break;
        }
        default:
            return 0;
            break;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int tag = (int)tableView.tag;
    
    switch (tag) {
        case CATEGORY_TABLE:{
            
            //NSString *categoryName = [self getSelectedExchangeCategoryName];
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Category Cell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Category Cell"];
            }
            
            NSArray *categories = [exchangeManager getAllCategories];
            
            ExchangeCategory *cat = [categories objectAtIndex:[indexPath row]];
            
            [cell.textLabel setText:cat.exchangeCategoryName];
            //[cell.imageView setImage:cat.exchangeCategoryIcon];
            
            return cell;
            break;
        }
        case BASE_CURRENCY_TABLE:{
            
            NSString *categoryName = [self getSelectedExchangeCategoryName];
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Base Cell"];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Base Cell"];
            }
            
            NSArray *currencyCollections = [exchangeManager getAllCurrencyCollectionsFromCategoryWithName:categoryName];
            
            CurrencyCollection *collection = [currencyCollections objectAtIndex:[indexPath row]];
            
            //NSLog(@"Name: %@",collection.currencyCollectionName);
            
            //NSLog(@"Number: %lu",(unsigned long)[currencyCollections count]);
         
            [cell.textLabel setText:collection.currencyCollectionName];
            
            return cell;
            
            break;
            
        }
        case TARGET_CURRENCY_TABLE:{
            
            NSString *categoryName = [self getSelectedExchangeCategoryName];
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Target Cell"];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Target Cell"];
            }
            
            NSIndexPath *path = [self currentSelectedIndexForTableView:self.baseCurrencyTableView];
            UITableViewCell *cell2  = [self.baseCurrencyTableView cellForRowAtIndexPath:path];
            //NSLog(@"text: %@",cell2.textLabel.text);
            
            NSString *string = cell2.textLabel.text;
            
            NSArray *ar = [exchangeManager getItemsFromCurrencyCollectionWithName:string andExchangeCategoryName:categoryName];
            
            Item *item = [ar objectAtIndex:[indexPath row]];
            
            [cell.textLabel setText:item.targetCurrency];
            
            return cell;
            
            break;
        }
        default:
            return nil;
            break;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int tag = (int)tableView.tag;
    
    switch (tag) {
        case CATEGORY_TABLE:{
            [self.baseCurrencyTableView reloadData];
            NSLog(@"Reloading Data");

            break;
        }
        case BASE_CURRENCY_TABLE:{
            /*NSIndexPath *path = [self currentSelectedIndexForTableView:self.baseCurrencyTableView];
            UITableViewCell *cell2  = [self.baseCurrencyTableView cellForRowAtIndexPath:path];
            NSLog(@"text: %@",cell2.textLabel.text);
            
            NSString *string = cell2.textLabel.text;
            
            NSArray *ar = [exchangeManager getItemsFromCurrencyCollectionWithName:string];
            
            for (Item *item in ar) {
                NSLog(@"%@",item.targetCurrency);
            }*/
            
            [self.targetCurrencyTableView reloadData];
            
            break;
        }
        default:
            break;
    }
}

@end
