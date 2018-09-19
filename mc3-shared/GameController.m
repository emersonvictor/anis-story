//
//  GameController.m
//  mc3
//
//  Created by André Carneiro on 12/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "GameController.h"
#import "PlayerStates.h"


@implementation GameController {
    NSTimeInterval _lastUpdateTime;
}

- (instancetype) init {
    self = [super init];
    self.inputScheme = [[InputScheme alloc] init];
    self.playerNode = [[Player alloc] initWithImageNamed:@"koalio_stand"];
    self.playerNode.position = CGPointMake(0, 100);
    self.playerNode.zPosition = 15;
    
    
//    Keyboard handler
#if TARGET_OS_OSX
    self.keyboardInputHandler = [[KeyboardInputHandler alloc] initWith:self.inputScheme];
#endif
    
    self.controllerInputHandler = [[ControllerInputHandler alloc] initWith:self.inputScheme];
    
    return self;
}


//MARK: - Keyboard Logic
#if TARGET_OS_OSX
- (void)handleKeyDown:(NSEvent *)event {
    [self.keyboardInputHandler handleKeyDown:event.keyCode];
}

- (void)handleKeyUp:(NSEvent *)event {
    [self.keyboardInputHandler handleKeyUp:event.keyCode];
}
#endif

- (void)update:(NSTimeInterval)currentTime forScene:(SKScene *)scene {
    
    // Initialize _lastUpdateTime if it has not already been
    if (_lastUpdateTime == 0) {
        _lastUpdateTime = currentTime;
    }
    
    // Calculate time since last update
    CGFloat delta = currentTime - _lastUpdateTime;
    [self processInput];
    [self.playerNode updateWithDeltaTime:delta];
    
}

- (void)sceneDidLoadFor:(BaseLevelScene *)scene {
    
    NSLog(@"CENA");
    [scene addChild: self.playerNode];
}

- (void)processInput {
    if (self.inputScheme.right) {
        self.playerNode.forwardMarch = TRUE;
        [self.playerNode.stateMachine enterState:WalkingState.class];
    }
    else {
        [self.playerNode.stateMachine enterState:IdleState.class];
    }
    
}

@end


