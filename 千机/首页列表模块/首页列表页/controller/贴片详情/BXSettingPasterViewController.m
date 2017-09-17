//
//  BXSettingPasterViewController.m
//  千机
//
//  Created by My MAC on 2017/9/9.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "BXSettingPasterViewController.h"
#import "BXClassifyListViewController.h"
#import "BXRingListViewController.h"
@interface BXSettingPasterViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,BXRingListViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) UIImage *headImage;
@property (nonatomic, strong) NSString *ringStr;

@end

@implementation BXSettingPasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(250, 250, 250);
    self.title = @"设置";
    _titleArr = @[@[@"名称",@"图片",@"分类",@"设备铃声"],@[@"激活时间",@"设备ID",@"固件更新"]];
    _headImage = [UIImage imageNamed:@"ic-头像-设置页面"];
    _ringStr = @"小白";
    [self createTableView];
}
-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_titleArr[section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section==1?31.5:0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0 && indexPath.row==1) {
        return 75;
    }
    return 45;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    UIView *view = [[UIView alloc] init];
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"设备信息";
    lab.textColor = RGB(100, 100, 100);
    lab.font = UIFONT(12);
    [view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(view);
    }];
    if (section==0) {
        return nil;
    }
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _titleArr[indexPath.section][indexPath.row];
    cell.textLabel.textColor = RGB(50, 50, 50);
    cell.textLabel.font = UIFONT(15);
    if (indexPath.section==0 && indexPath.row==1) {
        UIImageView *imageVC = [[UIImageView alloc] init];
       // imageVC.backgroundColor = [UIColor redColor];
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
        
    }else {
        for (UIView *view in cell.subviews) {
            if ([view isKindOfClass:[UILabel class]]) {
                [view removeFromSuperview];
            }
        }
        UILabel *lab = [[UILabel alloc] init];
        lab.text = _ringStr;
        lab.textAlignment = NSTextAlignmentRight;
        lab.textColor = RGB(100, 100, 100);
        lab.font = UIFONT(13);
       // lab.tag = 1000+indexPath.row;
        [cell addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(@-35);
        }];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    UILabel *lineLab = [[UILabel alloc] init];
    lineLab.backgroundColor = RGB(250, 250, 250);
    [cell.contentView addSubview:lineLab];
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.height.equalTo(@1);
        make.right.bottom.equalTo(@0);
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==1) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
        [actionSheet showInView:self.view];
    }else if (indexPath.section==0&&indexPath.row==2) {
        BXClassifyListViewController *classVC = [[BXClassifyListViewController alloc] init];
        [self.navigationController pushViewController:classVC animated:YES];
    }else if (indexPath.section==0&&indexPath.row==3){
        BXRingListViewController *ringVC = [[BXRingListViewController alloc] init];
        ringVC.delegate = self;
        [self.navigationController pushViewController:ringVC animated:YES];
    }
}
-(void)setRing:(NSString *)ringStr{
    _ringStr = ringStr;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];  //你需要更新的组数中的cell
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
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
