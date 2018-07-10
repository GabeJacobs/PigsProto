//
//  TPReviewVideoViewController.h
//  ThreePigsProto
//
//  Created by mssngpeces on 7/10/18.
//  Copyright © 2018 gabejacobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface TPReviewVideoViewController : UIViewController
- (instancetype)initWithVideoUrl:(NSURL *)url;

@property (strong, nonatomic) NSURL *videoUrl;
@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;
@property (strong, nonatomic) UIButton *cancelButton;

@end
