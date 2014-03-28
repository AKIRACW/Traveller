//
//  NearShopVC.m
//  Traveller
//
//  Created by TY on 14-3-19.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "NearShopVC.h"

@interface NearShopVC ()

@end

@implementation NearShopVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    //搜索栏
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 40)];
    self.searchBar.delegate = self;
    [self.view addSubview:self.searchBar];
    
    NSArray *types = [NSArray arrayWithObjects:@"列表",@"地图", nil];
    
    //视图类型选择
    self.segmentType = [[UISegmentedControl alloc] initWithItems:types];
    self.segmentType.frame = CGRectMake(0, 60, 320, 30);
    [self.segmentType addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
    self.segmentType.selectedSegmentIndex = 0;
    [self.view addSubview:self.segmentType];
    
    
    
    //列表视图
    self.listView=[[NearShopListView alloc] initWithFrame:CGRectMake(0, 90, 320, self.view.bounds.size.height-134)];
    self.listView.delegate = self;
    [self.view addSubview:self.listView];
    //地图视图
    self.mapView=[[NearShopMapView alloc] initWithFrame:CGRectMake(0, 90, 320, self.view.bounds.size.height-134)];
    self.mapView.hidden = YES;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    //搜索结果视图
    
    self.tableSearchResult = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, 0)];
    self.tableSearchResult.delegate = self;
    self.tableSearchResult.dataSource = self;
    [self.view addSubview:self.tableSearchResult];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
}

//视图类型选择
- (void)segmentedAction:(id)sender{
    switch ([sender selectedSegmentIndex]) {
        case 0:
            NSLog(@"list");
            self.listView.hidden = NO;
            self.mapView.hidden = YES;
            break;
        case 1:
            NSLog(@"map");
            self.listView.hidden = YES;
            self.mapView.hidden = NO;
            break;
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark -UISearchBarDelegate Methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%@",searchText);
    if (searchText.length!=0) {
        
            self.arrResult = [[NSMutableArray alloc] init];
            [self.arrResult addObjectsFromArray:[DPRequest getBusinessListByKeyword:searchText andCity:@"重庆"]];
            [UIView animateWithDuration:0.5 animations:^{
                self.tableSearchResult.frame = CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height-60-44);
                
            }];
            [self.tableSearchResult reloadData];
        
    }else{
        self.arrResult = [[NSMutableArray alloc] init];
        [UIView animateWithDuration:0.5 animations:^{
            self.tableSearchResult.frame = CGRectMake(0, 60, self.view.bounds.size.width, 0);
        }];
        [self.tableSearchResult reloadData];
    }
}

#pragma mark -UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrResult.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"SearchResultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // 设置数据
    BusinessModel *temp = self.arrResult[indexPath.row];
    cell.textLabel.text = temp.name;
    cell.detailTextLabel.text = temp.address;

    return cell;
}
#pragma mark -UITableViewDelegate Methods

#pragma mark -UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark -SelectShopListMethods Methods
- (void)didSelectShopList:(id)shop{
    ShopDetailVC *detail = [[ShopDetailVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detail];
    detail.shop = shop;
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
- (void)didScrollList{
   [self.view endEditing:YES];
}

#pragma mark - SelectShopMapMethods methods
- (void)didSelectShopMap:(id)shop{
    ShopDetailVC *detail = [[ShopDetailVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detail];
    detail.shop = shop;
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

- (void)didUserLocation{
    self.listView.lbHolder.hidden = YES;
    self.listView.listView.hidden = NO;
    [self.listView.actLoading stopAnimating];
    [self.listView.header beginRefreshing];
}
@end
