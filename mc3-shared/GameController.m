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
    SKTextureAtlas* playerAtlas =  [SKTextureAtlas atlasNamed:@"PlayerWalking"];
    SKTexture* initialTexture = [playerAtlas textureNamed:@"adventurer1.png"];
    self.playerNode = [[Player alloc] initWithTexture: initialTexture];
    self.playerNode.position = CGPointMake(0, 100);
    self.playerNode.zPosition = 15;
    
    
    // MARK: Keyboard handler
    #if TARGET_OS_OSX
    self.keyboardInputHandler = [[KeyboardInputHandler alloc] initWith:self.inputScheme];
    #endif
    
    self.controllerInputHandler = [[ControllerInputHandler alloc] initWith:self.inputScheme];
    
    return self;
}

// MARK: - Keyboard Logic
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
    [self processInput: delta];
    [self.playerNode updateWithDeltaTime:delta];
    
    _lastUpdateTime = currentTime;
}

- (void)sceneDidLoadFor:(BaseLevelScene *)scene {
    [scene addChild: self.playerNode];
}

- (void)processInput:(NSTimeInterval) delta{
    if (self.inputScheme.right) {
        self.playerNode.sense = 1;
        [self.playerNode accelerate:delta];
        [self.playerNode.stateMachine enterState:WalkingState.class];
    }
    
    
    if (self.inputScheme.left) {
        self.playerNode.sense = -1;
        [self.playerNode accelerate:delta];
        [self.playerNode.stateMachine enterState:WalkingState.class];
    }
    if (!self.inputScheme.left && !self.inputScheme.right) {
        [self.playerNode deaccelerate:delta];
    }
    
    if (self.inputScheme.buttonA && self.playerNode.stateMachine.currentState.class!=FallingState.class) {
        [self.playerNode moveUp:delta];
        [self.playerNode.stateMachine enterState:JumpingState.class];
    }
    else {
//        NSLog(@"%@", self.playerNode.stateMachine.currentState.className);
//        [self.playerNode.stateMachine enterState:FallingState.class];
    }
    
    if (!self.inputScheme.right && !self.inputScheme.buttonA && !self.inputScheme.left) {
        [self.playerNode.stateMachine enterState:IdleState.class];
    }
    
    if (self.inputScheme.buttonB) {
        NSLog(@"B pressed");
    }
    
//    NSLog(@"%@", self.playerNode.stateMachine.currentState);
}

@end
