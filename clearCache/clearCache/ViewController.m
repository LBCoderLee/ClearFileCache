//
//  ViewController.m
//  clearCache
//
//  Created by li  bo on 16/5/30.
//  Copyright © 2016年 li  bo. All rights reserved.
//

#import "ViewController.h"
#import "LBClearCacheTool.h"

#import "SVProgressHUD.h"

#define filePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 50;
}

/*
 
 
 说明：大家可以NSLog打印“[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]”
 这个路径，然后进入这个路径去给Library -> Caches文件夹里面随便放文件，再次运行这个cell上显示的就是你文件夹真实的缓存
 点击清除的时候，大家可以观察这个文件夹里面的东西，是会随之自动删除的
 
 
 
 
 
 
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row==0&&indexPath.section==0) {

        NSString *fileSize = [LBClearCacheTool getCacheSizeWithFilePath:filePath];
        if ([fileSize integerValue] == 0) {
            cell.textLabel.text = @"清除缓存";
        }else {
            cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(%@)",fileSize];
        }
    }else {
        cell.textLabel.text=[NSString stringWithFormat:@"这是第%zd组cell",indexPath.row];

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0&&indexPath.section==0) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确定清除缓存吗?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        //创建一个取消和一个确定按钮
        UIAlertAction *actionCancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        //因为需要点击确定按钮后改变文字的值，所以需要在确定按钮这个block里面进行相应的操作
        UIAlertAction *actionOk=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

            //清楚缓存
            BOOL isSuccess = [LBClearCacheTool clearCacheWithFilePath:filePath];
            if (isSuccess) {
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                [SVProgressHUD showSuccessWithStatus:@"清除成功"];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }



        }   ];
        //将取消和确定按钮添加进弹框控制器
        [alert addAction:actionCancle];
        [alert addAction:actionOk];
        //添加一个文本框到弹框控制器


        //显示弹框控制器
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}
@end
