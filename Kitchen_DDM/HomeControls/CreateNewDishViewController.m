//
//  CreateNewDishViewController.m
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/1/22.
//  Copyright © 2017年 郁兵生. All rights reserved.
//

#import "CreateNewDishViewController.h"
#import "AddListViewController.h"

@interface CreateNewDishViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *dishNameTF;

@property (weak, nonatomic) IBOutlet UILabel *introductionTV;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation CreateNewDishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Create New Dish"];
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(NextStep:)];
    [self.navigationItem setRightBarButtonItem:bar];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - Action
-(void)NextStep:(UIBarButtonItem*)sender
{
    if (_dishNameTF.text.length==0) {
        
    }
    AddListViewController *vc=[[AddListViewController alloc]initWithNibName:@"AddListViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)photoSelectedAction:(UIButton *)sender {
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *libaryAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
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
-(void)openImagePickerWithType:(UIImagePickerControllerSourceType)type
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.view.backgroundColor = [UIColor orangeColor];
    picker.sourceType = type;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark - TextViewDelegatewqe
-(void)textViewDidChange:(UITextView *)textView
{
    if ([CommonDefine convertToInt:textView.text]==0) {
       _numberLab.text=@"0/120";
        _introductionTV.text=@"Introduction";
    }else if([CommonDefine convertToInt:textView.text]<=120){
         _introductionTV.text=@"";
        _numberLab.text=[NSString stringWithFormat:@"%d/120",[CommonDefine convertToInt:textView.text]];
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([CommonDefine convertToInt:textView.text]>=120) {
        return NO;
    }
    return YES;
}
#pragma mark- ImagePickerDelegate

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
        [_imageView setImage:edit];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    }else{
        
    }
}
#pragma mark - ActionSheetDelegate
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
