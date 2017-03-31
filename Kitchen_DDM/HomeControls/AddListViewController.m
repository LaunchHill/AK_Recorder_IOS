//
//  AddListViewController.m
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/2/3.
//  Copyright © 2017年 郁兵生. All rights reserved.
//

#import "AddListViewController.h"
#import "EditView.h"
#import "DishStepCell.h"
#import "DishRecordViewController.h"
#import "PhotoBrowserView.h"
#import "EditDishMenuViewController.h"
@interface AddListViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (strong, nonatomic) EditView *editView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataArray;
@property (nonatomic, strong) PhotoBrowserView *browserView;
@property (assign, nonatomic) NSInteger photoEditType;
@end

@implementation AddListViewController
#pragma mark - ViewLoad
-(void)viewWillAppear:(BOOL)animated
{
    [[UINavigationBar appearance] setTranslucent:YES];
    [self registerForKeyboardNotifications];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
    [[UINavigationBar appearance] setTranslucent:NO];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _tableView.contentInset = UIEdgeInsetsZero;
    _tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Create Message"];
    _photoEditType=0;
//    [[UINavigationBar appearance] setTranslucent:NO];;
    [_tableView setTableFooterView:[UIView new]];
    if (!_isNewDish) {
        [self getRecipeDetail];
    }else{
        _dataArray=[[NSMutableArray alloc]init];
    }
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(NextStep:)];
    [self.navigationItem setRightBarButtonItem:bar];
    // Do any additional setup after loading the view from its nib.
}
-(EditView*)editView
{
    if (!_editView) {
        _editView=[EditView loadNib];
        [_editView layoutIfNeeded];
        [self.view addSubview:_editView];
        __weak typeof(self)weakSelf = self;
        _editView.editAction=^(NSInteger type,DishStepModel *model){
            [weakSelf.view endEditing:YES];
            switch (type) {
                case 0:{
                    [weakSelf.dataArray addObject:model];
                }
                    break;
                case 1:{
                    [weakSelf.dataArray removeObjectAtIndex:weakSelf.editView.tag-100];
                    
                }
                    break;
                case 2:{
                    
                }
                    break;
                default:
                    break;
            }
            [weakSelf.tableView reloadData];
            if (model.title.length==0||model.number.length==0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"message:@"不能为空"preferredStyle:UIAlertControllerStyleAlert];
                [weakSelf presentViewController:alert animated:YES completion:nil];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
                }]];
            }
        };
        _editView.phontoAction=^(DishStepModel *model){
            if (model.photos.count>0||model.images.length>0) {
                [weakSelf.view endEditing:YES];
                [weakSelf.browserView showView];
            }else{
                [weakSelf photoSelectedAction];
            }
        };
    }
    return _editView;
}
-(PhotoBrowserView*)browserView{
    _browserView=nil;
    if (!_browserView) {
        __weak typeof(self)weakSelf = self;
        _browserView=[[PhotoBrowserView alloc]initWithFrame:self.view.bounds dataWith:_editView.model editType:ReadWrite];
        _browserView.alpha=0;
        _browserView.hiddenEndAction=^(DishStepModel *obj){
            if (weakSelf.editView.tfIndex==0) {
                [weakSelf.editView.nameTF becomeFirstResponder];
            }else if (weakSelf.editView.tfIndex==1){
                [weakSelf.editView.quantityTf becomeFirstResponder];
            }else{
                [weakSelf.editView.methodTF becomeFirstResponder];
            }
        };
        _browserView.addAction=^(id obj){
            weakSelf.photoEditType=0;
            [weakSelf photoSelectedAction];
        };
        _browserView.changeAction=^(id obj){
            weakSelf.photoEditType=1;
            [weakSelf photoSelectedAction];
        };
        [self.navigationController.view addSubview:_browserView];
    }
    return _browserView;
}
#pragma mark - Action
-(void)NextStep:(UIBarButtonItem*)sender
{
    if (_dataArray.count>0) {
        [self updatePhotos];
    }else if(!_dishModel.step_id){
        DishRecordViewController *vc=[[DishRecordViewController alloc]initWithNibName:@"DishRecordViewController" bundle:nil];
        vc.dishModel=_dishModel;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        EditDishMenuViewController *vc=[[EditDishMenuViewController alloc]initWithNibName:@"EditDishMenuViewController" bundle:nil];
         vc.isNewDish=_isNewDish;
          vc.dishModel=_dishModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (IBAction)addMessage:(UIButton *)sender {
    if (_editView) {
        _editView=nil;
    }
    self.editView.tag=0;
    [_editView.nameTF becomeFirstResponder];
}

#pragma mark TableView Delegate and DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str=@"message";
    DishStepCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[DishStepCell loadNib];
    }
    [cell setValueToViewsWith:_dataArray[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.editView.tag=100+indexPath.row;
    [_editView.nameTF becomeFirstResponder];
    [_editView setValueToViewsWith:[_dataArray objectAtIndex:indexPath.row]];
    
}

#pragma mark - EditView Show And Hidden
-(void)showEditView:(CGFloat)height
{
    [UIView animateWithDuration:0.3 animations:^{
        self.editView.frame=CGRectMake(0, -height, Main_Screen_Width, Main_Screen_Height);
    }];
}
-(void)hiddenEditView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.editView.frame=CGRectMake(0, Main_Screen_Height, Main_Screen_Width, Main_Screen_Height);
    }];
}
- (void)photoSelectedAction{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *libaryAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openImagePickerWithType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openImagePickerWithType:UIImagePickerControllerSourceTypeCamera];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:libaryAction];
    [alertController addAction:cameraAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - PhotoPicker
-(void)openImagePickerWithType:(UIImagePickerControllerSourceType)type
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.view.backgroundColor = [UIColor orangeColor];
    picker.sourceType = type;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:(NSString*)kUTTypeImage]) {
        //获取照片的原图
        //        UIImage* original = [info objectForKey:UIImagePickerControllerOriginalImage];
        //获取图片裁剪的图
        UIImage* edit = [info objectForKey:UIImagePickerControllerEditedImage];
        //获取图片裁剪后，剩下的图
        //        UIImage* crop = [info objectForKey:UIImagePickerControllerCropRect];
        //获取图片的url
        //        NSURL* url = [info objectForKey:UIImagePickerControllerMediaURL];
        NSMutableArray *tmpArr=[NSMutableArray arrayWithArray:_editView.model.photos];
        if (_photoEditType==0) {
            [tmpArr addObject:edit];
        }else if(_photoEditType==1){
            [tmpArr replaceObjectAtIndex:_browserView.pageControl.currentPage withObject:edit];
        }
        _editView.model.photos=tmpArr;
        [self dismissViewControllerAnimated:YES completion:^{
            if (_browserView.alpha==1) {
                [_browserView  showView];
                return ;
            }
            if (_editView.tfIndex==0) {
                [_editView.nameTF becomeFirstResponder];
            }else if (_editView.tfIndex==1){
                [_editView.quantityTf becomeFirstResponder];
            }else{
                [_editView.methodTF becomeFirstResponder];
            }
        }];
    }else{
        
    }
}
#pragma mark - KeyBoardNotification
- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardChange:)
                                                name:UIKeyboardDidChangeFrameNotification
                                              object:nil];
    
}
//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    NSLog(@"hight_hitht:%f",kbSize.height);
    [self showEditView:kbSize.height];
}
-(void)begainMoveUpAnimation:(CGFloat)hight{
}
//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification{
    [self hiddenEditView];
}

- (void)keyboardChange:(NSNotification *)notification{
}
#pragma mark - NetWorking
-(void)getRecipeDetail{
    __weak typeof(self) weakSelf=self;
    [[NetManager sharedManager] getRequestWithPostParamDic:nil requestUrl:[NSString stringWithFormat:@"/api/recipes/%@/materials",_dishModel.id] success:^(id responseDic) {
        weakSelf.dataArray=[NSMutableArray arrayWithArray:[DishStepModel instancesFromJsonArray:responseDic[@"materials"]]];
        [weakSelf.tableView reloadData];
    } failure:^(id errorString) {
        
    }];
}
-(void)updateSteps{
    __weak typeof(self) weakSelf=self;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSMutableArray *tmpArr=[[NSMutableArray alloc]init];
    for (int i=0; i<_dataArray.count; i++) {
        DishStepModel *tmpModel=[_dataArray objectAtIndex:i];
        NSMutableDictionary *tmpDic=[[NSMutableDictionary alloc]init];
        [tmpDic setValue:[NSString stringWithFormat:@"%d",i] forKey:@"sequence"];
        [tmpDic setValue:tmpModel.number forKey:@"number"];
        [tmpDic setValue:tmpModel.title forKey:@"title"];
        [tmpDic setValue:tmpModel.treatment forKey:@"treatment"];
        [tmpDic setValue:tmpModel.unit forKey:@"unit"];
        [tmpDic setObject:[self imagesString:tmpModel.photos] forKey:@"images"];
        [tmpArr addObject:tmpDic];
    }
    [dic setValue:tmpArr forKey:@"materials"];
    [[NetManager sharedManager] postRequestWithPostParamDic:dic requestUrl:[NSString stringWithFormat:@"/api/recipes/%@/materials",_dishModel.id] success:^(id responseDic) {
        [weakSelf hiddenMBProgress];
        if(!weakSelf.dishModel.step_id){
            DishRecordViewController *vc=[[DishRecordViewController alloc]initWithNibName:@"DishRecordViewController" bundle:nil];
            vc.dishModel=_dishModel;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            EditDishMenuViewController *vc=[[EditDishMenuViewController alloc]initWithNibName:@"EditDishMenuViewController" bundle:nil];
            vc.isNewDish=_isNewDish;
            vc.dishModel=_dishModel;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(id errorString) {
        
    }];
}
//拼接图片链接
-(NSString*)imagesString:(NSArray*)array{
    NSString *str=@"";
    for (NSString *tmpStr in array) {
        if (str.length==0) {
            str=[tmpStr stringByAppendingString:@" "];
        }else{
            str=[str stringByAppendingString:tmpStr];
        }
    }
    return str;
}
-(void)updatePhotos{
    [self showMBProgressWithtMessage:@"提交中..."];
    __weak typeof(self) weakSelf=self;
    __block NSInteger images=0;
    for (int i=0; i<_dataArray.count; i++) {
        DishStepModel *model=[_dataArray objectAtIndex:i];
        __block NSMutableArray *tmpPhotos=[NSMutableArray arrayWithArray:model.photos];
        for (int d=0; d<tmpPhotos.count; d++) {
            id obj=[tmpPhotos objectAtIndex:d];
            if ([obj isKindOfClass:[UIImage class]]) {
                images++;
                [[NetManager sharedManager] upLoadToQiNiuWith:obj success:^(id urlString)  {
                    images--;
                    //
                    [tmpPhotos replaceObjectAtIndex:d withObject:urlString];
                    model.photos=tmpPhotos;
                    [weakSelf.dataArray replaceObjectAtIndex:i withObject:model];
                    if (images==0) {
                        NSLog(@"%@",weakSelf.dataArray);
                        [weakSelf updateSteps];
                    }
                } failure:^(id errorString) {
                    
                }];
            }
        }
        if (i==_dataArray.count-1&&images==0){
            if (model.photos.count==0&&model.images.length>0) {
                model.photos=[model.images componentsSeparatedByString:@" "];
            }
            [self updateSteps];
        }
        
    }
}
-(void)updatePhoto:(UIImage*)image{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
