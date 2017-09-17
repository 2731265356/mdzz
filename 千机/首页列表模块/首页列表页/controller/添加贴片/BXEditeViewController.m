//
//  BXEditeViewController.m
//  千机
//
//  Created by My MAC on 2017/9/6.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "BXEditeViewController.h"
#import "BXRingListViewController.h"
@interface BXEditeViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImage *headImage;
@end

@implementation BXEditeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(250, 250, 250);
    self.title = @"设置分类";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];

    [self createTableView];
}
-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}
-(void)rightClick{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row==0?75:45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSArray *arr = @[@"照片",@"名称",@"分类"];
    cell.textLabel.text = arr[indexPath.row];
    cell.textLabel.textColor = RGB(50, 50, 50);
    cell.textLabel.font = UIFONT(15);
    if (indexPath.row==0) {
        UIImageView *imageVC = [[UIImageView alloc] init];
        imageVC.backgroundColor = [UIColor redColor];
        imageVC.image = _headImage;
        imageVC.layer.masksToBounds = YES;
        imageVC.layer.cornerRadius = 27.5;
        [cell addSubview:imageVC];
        [imageVC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-35);
            make.centerY.equalTo(cell.contentView);
            make.width.height.equalTo(@55);
        }];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }else if (indexPath.row==1){
        UILabel *lab = [[UILabel alloc] init];
        lab.text = @"自行车";
        lab.textAlignment = NSTextAlignmentRight;
        lab.textColor = RGB(50, 50, 50);
        lab.font = UIFONT(15);
        [cell addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(@-35);
        }];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }else{
        UILabel *lab = [[UILabel alloc] init];
        lab.text = @"自行车";
        lab.textAlignment = NSTextAlignmentRight;
        lab.textColor = RGB(50, 50, 50);
        lab.font = UIFONT(15);
        [cell addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(@-15);
        }]; 
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
        [actionSheet showInView:self.view];
        
    }else{
        BXRingListViewController *ringVC = [[BXRingListViewController alloc] init];
        [self.navigationController pushViewController:ringVC animated:YES];

    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
   
    NSUInteger sourceType = 0;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        switch (buttonIndex) {
            case 2:
                // 取消
                return;
            case 0:
                // 相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
                
            case 1:
                // 相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
        }
    }
    else {
        if (buttonIndex == 2) {
            
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:^{}];

   
}
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    _headImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"image===%@",_headImage);
    [_tableView reloadData];
    
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
