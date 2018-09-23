//
//  GameViewController.h
//  mc3
//
//  Created by André Carneiro on 10/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>
#import "GameController.h"

@interface GameViewController : GCEventViewController
@property (nonatomic) GameController *ctrl;
@end
