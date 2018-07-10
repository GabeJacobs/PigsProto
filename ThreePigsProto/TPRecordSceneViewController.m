//
//  TPRecordSceneViewController.m
//  ThreePigsProto
//
//  Created by mssngpeces on 7/10/18.
//  Copyright © 2018 gabejacobs. All rights reserved.
//

#import "TPRecordSceneViewController.h"
#import "TPReviewVideoViewController.h"

@interface TPRecordSceneViewController ()

@end

@implementation TPRecordSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor redColor];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.camera = [[LLSimpleCamera alloc] init];
    self.camera =  [[LLSimpleCamera alloc] initWithVideoEnabled:YES];
    self.camera = [[LLSimpleCamera alloc] initWithQuality:AVCaptureSessionPresetHigh
                                                 position:LLCameraPositionRear
                                             videoEnabled:YES];
    [self.camera attachToViewController:self withFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [self.camera start];
    
    [self performSelector:@selector(startVideo) withObject:nil afterDelay:2.0];

}

- (void)startVideo {
    [self performSelector:@selector(stopVideo) withObject:nil afterDelay:2.0];

    NSURL *outputURL = [[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"test1"] URLByAppendingPathExtension:@"mov"];
    [self.camera startRecordingWithOutputUrl:outputURL didRecord:^(LLSimpleCamera *camera, NSURL *outputFileUrl, NSError *error) {
        TPReviewVideoViewController *vc = [[TPReviewVideoViewController alloc] initWithVideoUrl:outputFileUrl];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)stopVideo{
    [self.camera stopRecording];

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
