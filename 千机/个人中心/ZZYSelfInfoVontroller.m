//
//  ZZYSelfInfoVontroller.m
//  test
//
//  Created by Zzy on 2017/9/5.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import "ZZYSelfInfoVontroller.h"
#import "ZZYModifyNameController.h"
#import "ZZYBindingPhoneController.h"
typedef NS_ENUM(NSUInteger, PhotoSourceType) {  //拍照或选择相册时的选择type
    FromCamera = 0, //拍照
    FromPhotoLib = 1, //相册
    CancelSelect = 2,  //取消
};
@interface ZZYSelfInfoVontroller ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) UISwitch *locationSwitch;
@end

@implementation ZZYSelfInfoVontroller{
    UIImageView *_headImgView;
    UIImage *_selectImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initViews];
}

-(void)initViews{
    UIButton *logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 45)];
    logoutBtn.backgroundColor = [UIColor whiteColor];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(onClickLogout) forControlEvents:UIControlEventTouchUpInside];
    logoutBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.mainTableView.tableFooterView = logoutBtn;
}

-(void)onClickLogout{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"退出登录后所有的防丢器将会断开连接，再次登录前将无法管理，是否确认退出？" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {

    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 4;
    }else {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
    }
    return 45;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor clearColor];
    if (section == 3) {
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, KSCREENWIDTH-20, 15)];
        tipLabel.text = @"关闭后,好友将无法显示你的位置";
        tipLabel.textAlignment = NSTextAlignmentLeft;
        tipLabel.font = [UIFont systemFontOfSize:14];
        tipLabel.textColor = [UIColor darkGrayColor];
        [bgView addSubview:tipLabel];
    }
    return bgView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 80;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZZYSelfInfoCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ZZYSelfInfoCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"头像";
            _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCREENWIDTH-90, 15, 50, 50)];
            _headImgView.backgroundColor = [UIColor redColor];
            _headImgView.layer.cornerRadius = 25;
            _headImgView.layer.masksToBounds = YES;
            _headImgView.image = [UIImage imageNamed:@"default_head"];
            [cell.contentView addSubview:_headImgView];
            
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"昵称";
            cell.detailTextLabel.text = @"没有昵称";
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"修改密码";
            cell.detailTextLabel.text = @"修改";
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"手机号";
            cell.detailTextLabel.text = @"182xxxxxx111";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"邮箱";
            cell.detailTextLabel.text = @"未验证";
            cell.detailTextLabel.textColor = [UIColor redColor];
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"微信";
            cell.detailTextLabel.text = @"zzy3123123123123";
        }else if (indexPath.row == 3){
            cell.textLabel.text = @"QQ";
            cell.detailTextLabel.text = @"1231231";
        }
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.text = @"我的位置";
            self.locationSwitch.frame = CGRectMake(self.mainTableView.frame.size.width - self.locationSwitch.frame.size.width - 10, (cell.contentView.frame.size.height - self.locationSwitch.frame.size.height) / 2, self.locationSwitch.frame.size.width, self.locationSwitch.frame.size.height);
            [cell.contentView addSubview:self.locationSwitch];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0){
        [self showSelectAlert];
    }else if (indexPath.section == 0 && indexPath.row == 1){
        ZZYModifyNameController *modifyController = [[ZZYModifyNameController alloc] init];
        modifyController.fromWhere = 1;
        [self.navigationController pushViewController:modifyController animated:YES];
    }else if (indexPath.section == 1 &&indexPath.row == 0) {
        ZZYModifyNameController *modifyController = [[ZZYModifyNameController alloc] init];
        modifyController.fromWhere = 2;
        [self.navigationController pushViewController:modifyController animated:YES];
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        ZZYBindingPhoneController *bindingPhoneVC = [[ZZYBindingPhoneController alloc] init];
        bindingPhoneVC.signFlag = 2;
        [self.navigationController pushViewController:bindingPhoneVC animated:YES];
    }else if (indexPath.section == 2 && indexPath.row == 1){
        ZZYBindingPhoneController *bindingPhoneVC = [[ZZYBindingPhoneController alloc] init];
        bindingPhoneVC.signFlag = 3;
        [self.navigationController pushViewController:bindingPhoneVC animated:YES];
    }else if (indexPath.section == 2 && (indexPath.row == 2||indexPath.row == 3)){
        NSString *messageStr;
        if (indexPath.row == 2) {
            messageStr = @"“XXX智能贴片”想要打开“微信”";
        }else if (indexPath.row == 3){
            messageStr = @"“XXX智能贴片”想要打开“QQ”";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:messageStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (indexPath.row == 2) {
                
            }else if (indexPath.row == 3){
                
            }
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)showSelectAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self didSelectIndex:FromCamera];
    }];
    UIAlertAction *cancelAction2 = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self didSelectIndex:FromPhotoLib];
    }];
    UIAlertAction *cancelAction3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        [self didSelectIndex:CancelSelect];
    }];
    [alertController addAction:cancelAction1];
    [alertController addAction:cancelAction2];
    [alertController addAction:cancelAction3];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -- 菜单点击方法
-(void)didSelectIndex:(NSInteger)buttonIndex {
    NSUInteger sourceType = 0;
    if (buttonIndex == CancelSelect) {//取消按钮
        return;
    } else if (buttonIndex == FromCamera) {
        // 判断是否支持相机,支持跳转相机，不支持提示
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            sourceType = UIImagePickerControllerSourceTypeCamera;
        } else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请在设置-->隐私-->相机，中开启本应用的相机访问权限！" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil,nil];
            [alert show];
            return;
        }
    } else if(buttonIndex == FromPhotoLib) {
        // 跳转到相册页面
        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
#pragma mark- ImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //处理从相册选择或拍照的图片
    [picker dismissViewControllerAnimated:YES completion:^{
        _selectImage = info[UIImagePickerControllerOriginalImage];
        _headImgView.image = _selectImage;
        
        [[BXHttpRequest getInstance] httpRequestToModifyHeadImage:_selectImage path:@"" Suc:^(int result) {
            
        } Failure:^(int error) {
            
        }];
    }];
}


- (UISwitch *)locationSwitch
{
    if (_locationSwitch == nil) {
        _locationSwitch = [[UISwitch alloc] init];
        [_locationSwitch addTarget:self action:@selector(locationSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _locationSwitch;
}

-(void)locationSwitchChanged:(UISwitch *)sender{
    
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
