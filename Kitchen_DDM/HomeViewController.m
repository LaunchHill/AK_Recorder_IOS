//
//  ViewController.m
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/1/19.
//  Copyright © 2017年 郁兵生. All rights reserved.
//

#import "HomeViewController.h"
#import "CreateNewDishViewController.h"
#import "DishListCell.h"
#import "AddListViewController.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"菜谱列表"];
    _tableView.tableFooterView=[UIView new];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self getList];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)addDish:(UIButton *)sender {
//    [self getList];
    CreateNewDishViewController *vc=[[CreateNewDishViewController alloc]initWithNibName:@"CreateNewDishViewController" bundle:nil];
     [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark TableView Delegate and DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str=@"list";
    DishListCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[DishListCell loadNib];
    }
    DishListModel *model=[_dataArray objectAtIndex:indexPath.row];
    cell.titleView.text=model.title;
    id urlStr=[model.main_image[@"main_image"] valueForKey:@"thumb"][@"url"];
    if ([urlStr isEqual:[NSNull null]]) {
        urlStr=@"";
    }
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:(NSString*)urlStr] placeholderImage:[UIImage imageNamed:@"dishPhotoBlank"] options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AddListViewController *vc=[[AddListViewController alloc]initWithNibName:@"AddListViewController" bundle:nil];
    vc.dishModel=_dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - NetWorking
-(void)getList{
    __weak typeof(self) weakSelf=self;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:@"1" forKey:@"page"];
    [dic setValue:@"20" forKey:@"per_page"];
    [[NetManager sharedManager] getRequestWithPostParamDic:dic requestUrl:@"/api/recipes" success:^(id responseDic) {
        weakSelf.dataArray=[NSMutableArray arrayWithArray:[DishListModel instancesFromJsonArray:responseDic[@"recipes"]]];
        [weakSelf.tableView reloadData];
    } failure:^(id errorString) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
