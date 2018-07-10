//
//  TPRecordSceneViewController.h
//  ThreePigsProto
//
//  Created by mssngpeces on 7/10/18.
//  Copyright © 2018 gabejacobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LLSimpleCamera.h>
#import <LLVideoEditor.h>

@interface TPRecordSceneViewController : UIViewController

@property (nonatomic, strong) LLSimpleCamera *camera;
@property (nonatomic, strong) UIButton *record;

@end
