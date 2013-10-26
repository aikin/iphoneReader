//
//  RootViewController.m
//  iphoneReader
//
//  Created by xyooyy on 13-10-23.
//  Copyright (c) 2013年 lunajin. All rights reserved.
//

#import "RootViewController.h"
#import "BookListTableView.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)addTableView{
    
    BookListTableView *booklistTableView = [[BookListTableView alloc]init];
    [booklistTableView addBookListTableView:self];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     bookList = [[BookList alloc]init];
    [bookList getURLInBackground];
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addTableView) name:@"requestFinished" object:nil];
    //[bookList unarchiveBookListArray];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [bookList countOfBookListArray];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *booklistCellIdentifier = @"booklistCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:booklistCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:booklistCellIdentifier];
    }
    cell.textLabel.text = [bookList bookTitle:indexPath.row];
    cell.detailTextLabel.text = [bookList bookAuthor:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
