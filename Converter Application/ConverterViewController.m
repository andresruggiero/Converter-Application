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
#import "StyleKitName.h"
#import "CustomCategoriesTableViewCell.h"

#define CATEGORY_TABLE 0
#define BASE_CURRENCY_TABLE 1
#define TARGET_CURRENCY_TABLE 2

@interface ConverterViewController ()

@end

@implementation ConverterViewController{
    // Variables used to store the selected cells for each table view
    NSString *selectedExchangeCategoryName;
    NSString *selectedBaseCurrencyName;
}

@synthesize showButton;
@synthesize containerView;
@synthesize exchangeManager;
@synthesize categoriesTableView, baseCurrencyTableView, targetCurrencyTableView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.containerView setHidden:YES];
    [self.view setBackgroundColor:[StyleKitName redBaseColor]];
    
    selectedExchangeCategoryName = [[NSString alloc] init];
    selectedBaseCurrencyName = [[NSString alloc] init];
    
    exchangeManager = [ExchangeManager sharedManager];
    
    [self.categoriesTableView setBackgroundColor:[StyleKitName redBaseColor]];
    [self.baseCurrencyTableView setBackgroundColor:[StyleKitName redBaseColor]];
    [self.targetCurrencyTableView setBackgroundColor:[StyleKitName redBaseColor]];
    
    /*[self.categoriesTableView setBackgroundColor:[StyleKitName baseColor]];
    [self.baseCurrencyTableView setBackgroundColor:[StyleKitName baseColor]];
    [self.targetCurrencyTableView setBackgroundColor:[StyleKitName baseColor]];*/
    
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

#pragma mark - UITableView Selection

-(NSString *) getSelectedNameForTableView:(UITableView *)table{
    
    //NSIndexPath *path = [self currentSelectedIndexForTableView:self.categoriesTableView];
    NSIndexPath *selectedIndexPath = [table indexPathForSelectedRow];
    //if (path != nil) {
    //UITableViewCell *cell  = [table cellForRowAtIndexPath:selectedIndexPath];
    //NSLog(@"text: %@",cell.textLabel.text);
    
    int tag = (int)table.tag;
    
    switch (tag) {
        case CATEGORY_TABLE:{
            CustomCategoriesTableViewCell *cell = (CustomCategoriesTableViewCell *)[table cellForRowAtIndexPath:selectedIndexPath];
            return cell.categoriesLabel;
            break;
        }
        case BASE_CURRENCY_TABLE:{
            UITableViewCell *cell = [table cellForRowAtIndexPath:selectedIndexPath];
            return cell.textLabel.text;
            return @"";
            break;
        }
        case TARGET_CURRENCY_TABLE:{
            return @"";
            break;
        }
        default:{
            return @"";
            break;
        }
    }
    
}


#pragma mark - UITableView Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
            NSArray *currencyCollections = [exchangeManager getAllCurrencyCollectionsFromCategoryWithName:selectedExchangeCategoryName];
            //NSLog(@"%lu",(unsigned long)[currencyCollections count]);
            
            return [currencyCollections count];
            //return 0;
            
            break;
        }
        case TARGET_CURRENCY_TABLE:{
            NSArray *ar = [exchangeManager getItemsFromCurrencyCollectionWithName:selectedBaseCurrencyName
                                                          andExchangeCategoryName:selectedExchangeCategoryName];
            
            //NSLog(@"Category: %@ # elements: %lu",selectedExchangeCategoryName,(unsigned long)[ar count]);
            
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
            //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Category Cell"];
            
            CustomCategoriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Categories Cell" forIndexPath:indexPath];
            
            if (cell == nil) {
                cell = [[CustomCategoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Categories Cell"];
            }
            
            // Fix iOS 7 Bug that make separator lines disappear
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.backgroundColor = [UIColor clearColor];
            
            NSArray *categories = [exchangeManager getAllCategories];
            
            ExchangeCategory *cat = [categories objectAtIndex:[indexPath row]];
            
            [cell setIcon:cat.exchangeCategoryIcon];
            [cell setCategoriesLabel:cat.exchangeCategoryName];
            
            return cell;
            break;
        }
        case BASE_CURRENCY_TABLE:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Base Cell"];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Base Cell"];
            }
            
            // Fix iOS 7 Bug that make separator lines disappear
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.backgroundColor = [UIColor clearColor];
            
            NSArray *currencyCollections = [exchangeManager getAllCurrencyCollectionsFromCategoryWithName:selectedExchangeCategoryName];
            
            CurrencyCollection *collection = [currencyCollections objectAtIndex:[indexPath row]];
            
            //NSLog(@"Hey:%@",collection.currencyCollectionName);
            
            [cell.textLabel setText:collection.currencyCollectionName];
            return cell;
            
            break;
            
        }
        case TARGET_CURRENCY_TABLE:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Target Cell"];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Target Cell"];
            }
            
            // Fix iOS 7 Bug that make separator lines disappear
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.backgroundColor = [UIColor clearColor];
            
            NSArray *ar = [exchangeManager getItemsFromCurrencyCollectionWithName:selectedBaseCurrencyName
                                                          andExchangeCategoryName:selectedExchangeCategoryName];
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

#pragma mark - UITableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int tag = (int)tableView.tag;
    
    switch (tag) {
        case CATEGORY_TABLE:{
            selectedExchangeCategoryName = [self getSelectedNameForTableView:self.categoriesTableView];
            NSLog(@"selected Category: %@",selectedExchangeCategoryName);

            [self.baseCurrencyTableView reloadData];
            //NSLog(@"Reloading Data");
            
            // Getting selected cell
            CustomCategoriesTableViewCell *cell = (CustomCategoriesTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            
            // Set selection style to NONE to avoid blue or grey default selection
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            // Set Highlited to YES
            [cell setHighlighted:YES];

            break;
        }
        case BASE_CURRENCY_TABLE:{
            selectedBaseCurrencyName = [self getSelectedNameForTableView:self.baseCurrencyTableView];
            
            [self.targetCurrencyTableView reloadData];
            
            break;
        }
        default:
            break;
    }
}

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomCategoriesTableViewCell *cell = (CustomCategoriesTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    [cell setHighlighted:NO];
}

@end
