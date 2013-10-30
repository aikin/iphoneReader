//
//  RootViewController.m
//  iphoneReader
//
//  Created by xyooyy on 13-10-23.
//  Copyright (c) 2013年 lunajin. All rights reserved.
//

#import "RootViewController.h"
#import "BookListTableViewCell.h"


@interface RootViewController ()
{
    NSInteger i;
}
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


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!bookListTableView.pullTableIsRefreshing) {
        bookListTableView.pullTableIsRefreshing = YES;
        [self performSelector:@selector(refreshTableView) withObject:nil afterDelay:3];
    }
    
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    i = 4;
     bookList = [[BookList alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addTableView) name:@"requestFinished" object:nil];

}



- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}


#pragma mark -
#pragma mark Private Methods
- (void)addTableView
{
    
    bookListTableView = [[PullTableView alloc]initWithFrame:CGRectMake(0, 0, 320, 415) style:UITableViewStylePlain pullDownRefresh:YES pullUpLoadMore:YES];
    bookListTableView.pullArrowImage = [UIImage imageNamed:@"blueArrow"];
    bookListTableView.pullDelegate = self;
    bookListTableView.dataSource = self;
    bookListTableView.delegate = self;
    [self.view addSubview:bookListTableView];
    
}


- (void)refreshTableView
{
    [bookList requestURL:@"php"];
    bookListTableView.pullLastRefreshDate = [NSDate date];
    bookListTableView.pullTableIsRefreshing = NO;
    
}


- (void)loadMoreDataToTableView
{
    
    if (i < [bookList countOfBookListArray]) i = i+4;
    [bookListTableView reloadData];
    bookListTableView.pullTableIsLoadingMore = NO;
    
}


#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return i;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *booklistCellIdentifier = @"booklistCellIdentifier";
    BookListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:booklistCellIdentifier];
    if (cell == nil) {
        cell = [[BookListTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:booklistCellIdentifier];
    }

    Book *indexBook = [bookList indexBookModel:indexPath.row];
    [cell getBookTitleLabelText:indexBook.title];
    [cell getBookAuthorLabelText:indexBook.author];
    [cell getImageViewUrl:indexBook.image];
    return cell;

}


#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 120;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark -
#pragma mark PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    
    [self performSelector:@selector(refreshTableView) withObject:nil afterDelay:3.0f];
    
}


- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    
    [self performSelector:@selector(loadMoreDataToTableView) withObject:nil afterDelay:3.0f];

}





#pragma mark -
#pragma mark Dealloc Methods
- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"requestFinished" object:nil];
    
}


@end
