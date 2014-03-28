//
//  NearShopListView.m
//  Traveller
//
//  Created by TY on 14-3-20.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "NearShopListView.h"
@interface NearShopListView ()
@property(nonatomic,strong)UserModel *user;
@end
@implementation NearShopListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //用户数据
        _user = [UserModel sharedUserModel];
        //附近商户列表
        self.listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, self.bounds.size.width, self.bounds.size.height-30)];
        self.listView.delegate = self;
        self.listView.dataSource = self;
        self.listView.hidden = YES;
        [self addSubview:self.listView];
        //seg商铺类型选择
        NSArray *types = @[@"距离",@"类型",@"星级"];
        self.segShopType = [[UISegmentedControl alloc] initWithItems:types];
        self.segShopType.tintColor = [UIColor purpleColor];
        self.segShopType.frame = CGRectMake(0, 0, self.bounds.size.width, 30);
        [self.segShopType addTarget:self action:@selector(segmentedShopTypeChange:) forControlEvents:UIControlEventValueChanged];
        self.segShopType.selectedSegmentIndex = 0;
        [self addSubview:self.segShopType];
        
        self.arrBusiness = [[NSMutableArray alloc] init];
        
        //MJ刷新
        //[self.listView registerClass:[ShopListCell class] forCellReuseIdentifier:@"ShopCell"];
        self.header = [MJRefreshHeaderView header];
        self.header.scrollView = self.listView;
        self.header.delegate = self;
        //[self.header beginRefreshing];
        self.footer = [MJRefreshFooterView footer];
        self.footer.scrollView = self.listView;
        self.footer.delegate = self;
        //holder
        self.lbHolder = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-100, self.bounds.size.width, 30)];
        self.lbHolder.text = @"正在帮你定位......";
        self.lbHolder.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.lbHolder];
        self.actLoading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.actLoading.frame = CGRectMake(0, 0, 50, 50);
        self.actLoading.center = self.center;
        [self addSubview:self.actLoading];
        [self.actLoading startAnimating];
    }
    return self;
}

- (void)getArrBusinessWithPage:(int)page{
    NSArray *arr = [DPRequest getBusinessListByUser:_user andCategory:@"美食" andRadius:5000 andSort:7 andPage:page];
    [self.arrBusiness addObjectsFromArray:arr];
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.listView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}
- (void)segmentedShopTypeChange:(id)sender{
    switch ([sender selectedSegmentIndex]) {
        case 0:
            NSLog(@"sort by distence");
            break;
        case 1:
            NSLog(@"sort by type");
            break;
        case 2:
            NSLog(@"sort by rate");
            break;
        default:
            break;
    }
}
#pragma mark - 刷新控件的代理方法
#pragma mark 开始进入刷新状态
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    NSLog(@"%@----开始进入刷新状态", refreshView.class);
    
    // 1.添加假数据
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        //刷新
        self.arrBusiness = [[NSMutableArray alloc] init];
        self.curPage = 1;
        [self getArrBusinessWithPage:self.curPage];
        
    } else {
        //添加
        self.curPage +=1;
        [self getArrBusinessWithPage:self.curPage];
    }
    // 2.2秒后刷新表格UI
    [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
}

#pragma mark 刷新完毕
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    NSLog(@"%@----刷新完毕", refreshView.class);
}

#pragma mark 监听刷新状态的改变
- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state
{
    switch (state) {
        case MJRefreshStateNormal:
            NSLog(@"%@----切换到：普通状态", refreshView.class);
            break;
            
        case MJRefreshStatePulling:
            NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
            break;
            
        case MJRefreshStateRefreshing:
            NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
            break;
        default:
            break;
    }
}

#pragma mark -UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrBusiness count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ShopCell";
    ShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [[ShopListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        NSArray *nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"ShopListCell" owner:self options:nil];
        cell = [nibTableCells objectAtIndex:0];
<<<<<<< HEAD
        
    }
    // 设置数据
    BusinessModel *temp = self.arrBusiness[indexPath.row];
    [cell setCellWithBusinessModel:temp];
=======
        // 设置数据
        BusinessModel *temp = self.arrBusiness[indexPath.row];
        [cell setCellWithBusinessModel:temp];
    }
    
>>>>>>> FETCH_HEAD
    
    return cell;
}


#pragma mark -UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
<<<<<<< HEAD
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self respondsToSelector:@selector(didSelectShopList:)]){
        [self.delegate didSelectShopList:self.arrBusiness[indexPath.row]];
    }
    
}

#pragma mark -UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([self respondsToSelector:@selector(didScrollList)]){
        [self.delegate didScrollList];
    }
}
#pragma mark -SelectShopListMethods Methods
- (void)didSelectShopList:(id)shop{
    
}
- (void)didScrollList{
    
}
=======
>>>>>>> FETCH_HEAD
@end
