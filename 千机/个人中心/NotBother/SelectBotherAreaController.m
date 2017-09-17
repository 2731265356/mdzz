//
//  SelectBotherAreaController.m
//  test
//
//  Created by Zzy on 2017/9/9.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import "SelectBotherAreaController.h"

@interface SelectBotherAreaController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation SelectBotherAreaController{
    NSMutableArray *_searchResultArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置位置勿扰区域";
    _searchResultArr = [[NSMutableArray alloc] init];
    [self initViews];
}

-(void)initViews{
    self.searchTf.delegate = self;
    self.searchTableView.hidden = YES;
    self.cancelBtn.hidden = YES;
    [self.distanceSlider addTarget:self action:@selector(changeBotherAreaDistance:) forControlEvents:UIControlEventValueChanged];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5; //_searchResultArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchAreaResultCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchAreaResultCell"];
    }
//     = [_searchResultArr objectAtIndex:indexPath.row];
    cell.textLabel.text = @"Area";
    return cell;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.searchTableView.hidden = NO;
    self.cancelBtn.hidden = NO;
    self.rightDisCons.constant = 70;
}

-(void)changeBotherAreaDistance:(UISlider *)sender{
    self.distanceLb.text = [NSString stringWithFormat:@"当前半径 %d 米",(int)sender.value];
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
