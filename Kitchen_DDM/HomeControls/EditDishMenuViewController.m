//
//  EditDishMenuViewController.m
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/3/1.
//  Copyright © 2017年 郁兵生. All rights reserved.
//

#import "EditDishMenuViewController.h"
#import "DishRecord_TimeCell.h"
#import "DishRecordCell.h"
#import "CustomPhotoLibraryView.h"
#import "AVAudioPlayer.h"
#import "PhotoBrowserView.h"

@interface EditDishMenuViewController ()<UITableViewDelegate,UITableViewDataSource,XMAVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CustomPhotoLibraryView *photoLibraryView;
@property (assign, nonatomic) CGPoint contentoffset;
@property (nonatomic, strong) PhotoBrowserView *browserView;
@property (nonatomic, strong) DishListStepModel *selectedDic;
@property (nonatomic, strong) NSString *stepsString;
@end

@implementation EditDishMenuViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UINavigationBar appearance] setTranslucent:YES];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[XMAVAudioPlayer sharePlayer] stopAudioPlayer];
    [XMAVAudioPlayer sharePlayer].index = NSUIntegerMax;
    [XMAVAudioPlayer sharePlayer].URLString = nil;
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Steps Edit"];
    [XMAVAudioPlayer sharePlayer].delegate = self;
    if (!_isNewDish) {
        [self getStepDetail];
    }
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithTitle:@"Down" style:UIBarButtonItemStylePlain target:self action:@selector(Down:)];
    UIBarButtonItem *bar1=[[UIBarButtonItem alloc]initWithTitle:@"DELETE" style:UIBarButtonItemStylePlain target:self action:@selector(Edit:)];
    [self.navigationItem setRightBarButtonItems:@[bar,bar1]];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - Action
-(void)Down:(UIBarButtonItem*)bar{
    [self  updateStepDetail];
}
-(void)Edit:(UIBarButtonItem*)bar{
    if ([bar.title isEqualToString:@"DELETE"]) {
        _tableView.editing=YES;
        bar.title=@"COMPLETE";
    }else{
        _tableView.editing=NO;
        bar.title=@"DELETE";
    }
}
#pragma mark - 初始化
-(PhotoBrowserView*)browserView{
    _browserView=nil;
    if (!_browserView) {
        __weak typeof(self)weakSelf = self;
        DishStepModel *model=[[DishStepModel alloc]init];
        model.title=_selectedDic.title;
        model.photos=@[_selectedDic.image];
        
        _browserView=[[PhotoBrowserView alloc]initWithFrame:self.view.bounds dataWith:model editType:ReadOnly];
        _browserView.alpha=0;
        _browserView.hiddenEndAction=^(id obj){
            weakSelf.browserView=nil;
        };
        _browserView.removeAction=^(id obj){
            DishListStepModel *dic=weakSelf.dataArray[weakSelf.browserView.tag];
            dic.image=nil;
            [weakSelf.tableView reloadData];
            weakSelf.photoLibraryView.selected=10000;
        };
        _browserView.changeAction=^(id obj){
            [weakSelf.photoLibraryView showView];
        };
        [self.navigationController.view addSubview:_browserView];
    }
    return _browserView;
}
-(CustomPhotoLibraryView*)photoLibraryView{
    if (!_photoLibraryView) {
        _photoLibraryView=[[CustomPhotoLibraryView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height, Main_Screen_Width, 408*Screen_Scale) isReadOnly:NO];
        [self.view addSubview:_photoLibraryView];
        __weak typeof(self)weakSelf = self;
        _photoLibraryView.photoSelected=^(id obj,UIImage *img){
            DishListStepModel *dic=weakSelf.dataArray[weakSelf.photoLibraryView.tag];
            dic.image=img;
            [weakSelf.tableView reloadData];
        };
        _photoLibraryView.hiddenAction=^(id obj){
            [weakSelf.tableView setContentOffset:CGPointMake(weakSelf.contentoffset.x,weakSelf.contentoffset.y) animated:YES];
        };
    }
    return _photoLibraryView;
}
- (NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    return _dataArray;
}
#pragma mark - TableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str=@"Record";
    DishListStepModel *obj=[_dataArray objectAtIndex:indexPath.row];
    if ([obj.interval isEqualToString:@"1"])  {
        DishRecord_TimeCell *cell=[tableView dequeueReusableCellWithIdentifier:str];;
        if (cell==nil) {
            cell=[DishRecord_TimeCell loadNib];
        }
        [cell setValueToViewsWith:obj.title];
        return cell;
    }
    DishRecordCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil) {
        __weak typeof(self)weakSelf = self;
        __block NSIndexPath *tmp=indexPath;
        cell=[[DishRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.voiceAction=^(DishRecordCell *tmpCell){
            DishListStepModel *message = tmpCell.dataModel;
            NSString *voiceFileName = message.voiceFileName;
            [[XMAVAudioPlayer sharePlayer] playAudioWithURLString:voiceFileName atIndex:indexPath.row];
        };
        cell.photoAction=^(DishListStepModel *obj){
            if ([obj.image isKindOfClass:[UIImage class]]||[(NSString*)obj.image length]>0) {
                weakSelf.selectedDic=weakSelf.dataArray[tmp.row];
                [weakSelf.view endEditing:YES];
                [weakSelf.browserView showView];
                weakSelf.browserView.tag=tmp.row;
                return ;
            }
            [weakSelf.photoLibraryView showView];
            [weakSelf.photoLibraryView reloadCollectionViewWith:weakSelf.photosArray];
            weakSelf.photoLibraryView.tag=tmp.row;
            //            NSSet *touches = [obj allTouches];   // 把触摸的事件放到集合里
            //            UITouch *touch = [touches anyObject];   //把事件放到触摸的对象了
            //            CGPoint currentTouchPosition = [touch locationInView:weakSelf.view]; //把触发的这个点转成二位坐标
            //获取当前cell在tableview中的位置
            [weakSelf moveViewWith:tmp];
            
            UIImage *img=[[weakSelf.photosDic valueForKey:[NSString stringWithFormat:@"%ld",tmp.row]] objectAtIndex:0];
            if (!img) {
                return ;
            }
            NSIndexPath *ip= [NSIndexPath indexPathForRow:[weakSelf.photosArray indexOfObject:img] inSection:0];
            [weakSelf.photoLibraryView.collectionView scrollToItemAtIndexPath:ip atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        };
        cell.downAction = ^(DishListStepModel *object,NSString *title) {
            NSLog(@"old==%@  new==%@",object.title,title);
            NSString *newStepStr=[weakSelf.stepsString stringByReplacingOccurrencesOfString:object.title withString:title];
            weakSelf.stepsString=newStepStr;
            object.title=title;
            [weakSelf.tableView reloadData];
        } ;
    }
    cell.isEdit=YES;
    cell.tag=indexPath.row;
    DishListStepModel *message = self.dataArray[indexPath.row];
    [cell configureCellWithData:message];
    
    cell.backgroundColor=UIColorFromRGB(0xF5F5F5);
    return cell;
}
-(void)moveViewWith:(NSIndexPath*)indexPath
{
    CGRect rectintableview=[_tableView rectForRowAtIndexPath:indexPath];
    CGRect rectinsuperview=[_tableView convertRect:rectintableview fromView:[_tableView superview]];
    _contentoffset.x=_tableView .contentOffset.x;
    _contentoffset.y=_tableView .contentOffset.y;
    CGFloat tmpH=(self.view.frame.size.height-rectintableview.origin.y-rectinsuperview.size.height-66);
    if (tmpH<self.photoLibraryView.frame.size.height) {
        [self.tableView setContentOffset:CGPointMake(self.tableView.contentOffset.x,self.photoLibraryView.frame.size.height-tmpH) animated:YES];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"\n x==%0.2f \n y==%0.2f",self.tableView.contentOffset.x,self.tableView.contentOffset.y);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DishListStepModel *obj=[_dataArray objectAtIndex:indexPath.row];
    if ([obj.interval isEqualToString:@"1"]) {
        //        return 30;
    }
    DishRecordCell *cell=(DishRecordCell*)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return ([cell configureCellWithData:obj]+49+13+10)*Screen_Scale;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DishListStepModel *message = self.dataArray[indexPath.row];
    if ([message.typeKey integerValue] == MessageTypeVoice)
    {
        if (indexPath.row == [[XMAVAudioPlayer sharePlayer] index]){
            [(DishRecordCell *)cell setVoiceMessageState:[[XMAVAudioPlayer sharePlayer] audioPlayerState]];
        }
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0||indexPath.row+1==_dataArray.count) {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
#pragma mark - XMAVAudioPlayerDelegate方法

- (void)audioPlayerStateDidChanged:(VoiceMessageState)audioPlayerState forIndex:(NSUInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    DishRecordCell *voiceMessageCell = [self.tableView cellForRowAtIndexPath:indexPath];
    dispatch_async(dispatch_get_main_queue(), ^{
        [voiceMessageCell setVoiceMessageState:audioPlayerState];
    });
}
#pragma mark - NetWorking
-(void)getStepDetail{
    __weak typeof(self) weakSelf=self;
    [[NetManager sharedManager] getRequestWithPostParamDic:nil requestUrl:[NSString stringWithFormat:@"/api/steps/%@",_dishModel.step_id] success:^(id responseDic) {
        weakSelf.stepsString=[responseDic[@"step"] [@"content"] mutableCopy];
        //        NSMutableArray *tmpSteps=[CommonDefine analyticalContentData:responseDic[@"step"] [@"content"]];
        NSDictionary *dic=[CommonDefine analyticalData:responseDic[@"step"] [@"steps"]];
        weakSelf.dataArray=[[NSMutableArray alloc]init];
        NSArray *stepsArr=dic[@"AllStepArr"];
        NSArray *midiasArr=dic[@"midiaMuArr"];
        for (int i=0; i<stepsArr.count; i++) {
            DishListStepModel *obj=[[DishListStepModel alloc]init];
            obj.title=[stepsArr objectAtIndex:i];
            obj.image=[midiasArr objectAtIndex:i];
            obj.voiceSecondsKey=@"3";
            obj.id=[NSString stringWithFormat:@"%d",i];
            [weakSelf.dataArray addObject:obj];
        }
        [weakSelf.tableView reloadData];
    } failure:^(id errorString) {
        
    }];
}
-(void)updateStepDetail{
    __weak typeof(self) weakSelf=self;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *tmpDic=[[NSMutableDictionary alloc]init];
    [tmpDic setValue:_stepsString forKey:@"content"];
    [dic setObject:tmpDic forKey:@"step"];
    [[NetManager sharedManager] patchRequestWithPostParamDic:dic requestUrl:[NSString stringWithFormat:@"/api/steps/%@",_dishModel.step_id] success:^(id responseDic) {
        [weakSelf convertStep];
        
    } failure:^(id errorString) {
        
    }];
}
-(void)convertStep{
    __weak typeof(self) weakSelf=self;
    [[NetManager sharedManager] getRequestWithPostParamDic:nil requestUrl:[NSString stringWithFormat:@"/api/steps/%@/convert",_dishModel.step_id] success:^(id responseDic) {
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(id errorString) {
//#error 编辑过返回要有提示
    }];
    
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

@end
