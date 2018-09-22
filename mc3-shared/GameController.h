//
//  GameController.h
//  mc3
//
//  Created by André Carneiro on 12/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import <GameplayKit/GameplayKit.h>
#import <SpriteKit/SpriteKit.h>
#import "LevelDelegate.h"
#import "BaseLevelScene.h"
#import "KeyboardInputHandler.h"
#import "ControllerInputHandler.h"
#import "InputScheme.h"
#import <TargetConditionals.h>
#import "Characters/Player.h"

@interface GameController: NSObject <LevelDelegate>
- (instancetype) init;
@property (nonatomic, strong) InputScheme *inputScheme;

#if TARGET_OS_OSX
@property (nonatomic, strong) KeyboardInputHandler *keyboardInputHandler;
#endif

@property (nonatomic, strong) ControllerInputHandler *controllerInputHandler;
@property (nonatomic, strong) Player *playerNode;

- (void) processInput:(NSTimeInterval) delta;


@end
