//
//  TPBaseNavigationViewController.m
//  ThreePigsProto
//
//  Created by mssngpeces on 7/10/18.
//  Copyright © 2018 gabejacobs. All rights reserved.
//

#import "TPBaseNavigationViewController.h"
#import "TPRecordSceneViewController.h"

@interface TPBaseNavigationViewController ()

@end

@implementation TPBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.hidden = YES;
    
    TPRecordSceneViewController *recordSceneVC = [[TPRecordSceneViewController alloc] init];
    [self pushViewController:recordSceneVC animated:NO];
    // Do any additional setup after loading the view.
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
