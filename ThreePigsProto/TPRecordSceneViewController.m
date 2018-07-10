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
    
    
    self.record = [UIButton buttonWithType:UIButtonTypeCustom];
    self.record.backgroundColor = [UIColor whiteColor];
    self.record.frame = CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height - 100, 100, 50);
    [self.record setTitle:@"RECORD" forState:UIControlStateNormal];
    [self.record setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.record addTarget:self action:@selector(startVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.record];

}

- (void)startVideo {
    if([self.camera isRecording]){
        [self stopVideo];
        
    } else{
        [self.record setBackgroundColor:[UIColor redColor]];
        [self.record setTitle:@"recording" forState:UIControlStateNormal];
         NSURL *outputURL = [[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"test1"] URLByAppendingPathExtension:@"mov"];
         NSURL *outputURL2 = [[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"test2"] URLByAppendingPathExtension:@"mov"];
         [self.camera startRecordingWithOutputUrl:outputURL didRecord:^(LLSimpleCamera *camera, NSURL *outputFileUrl, NSError *error) {
            
            
            LLVideoEditor *videoEditor = [[LLVideoEditor alloc] initWithVideoURL:outputFileUrl];
            [videoEditor rotate:LLRotateDegree180];
            
            CALayer *layer = [self createVideoLayer:videoEditor.videoSize];
            
            
            [videoEditor addLayer:layer];
            [videoEditor exportToUrl:outputURL2 completionBlock:^(AVAssetExportSession *session) {
                
                switch (session.status) {
                    case AVAssetExportSessionStatusCompleted: {
                        // show the cropped video
                        TPReviewVideoViewController *vc = [[TPReviewVideoViewController alloc] initWithVideoUrl:outputURL2];
                        [self.navigationController pushViewController:vc animated:NO];
                        break;
                    }
                    case AVAssetExportSessionStatusFailed:
                        NSLog(@"Failed:%@",session.error);
                        break;
                    case AVAssetExportSessionStatusCancelled:
                        NSLog(@"Canceled:%@", session.error);
                        break;
                    default:
                        break;
                }
            }];
            
            
            
            //        TPReviewVideoViewController *vc = [[TPReviewVideoViewController alloc] initWithVideoUrl:outputFileUrl];
            //        [self.navigationController pushViewController:vc animated:YES];
        }];
    }
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

- (CALayer *)createVideoLayer:(CGSize)videoSize {
    
    
    // a simple red rectangle
    CALayer *layer = [CALayer layer];
//    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.frame = CGRectMake(0, 0, 1920, 1080);
    UIImage *maskImage = [UIImage imageNamed:@"dragon"];
    layer.contents = (id)maskImage.CGImage;
//    maskLayer.bounds = self.view.bounds;
//    maskLayer.frame = self.view.frame;
    return layer;
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
