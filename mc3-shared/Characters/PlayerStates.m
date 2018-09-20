//
//  PlayerStates.m
//  mc3
//
//  Created by André Carneiro on 18/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "PlayerStates.h"
#import "Player.h"
#import "SKTUtils.h"

@implementation IdleState

- (BOOL) isValidNextState:(Class)stateClass {
    return stateClass == WalkingState.class
    || stateClass == JumpingState.class
    || stateClass == RunningState.class;
}

- (void)didEnterWithPreviousState:(GKState *)previousState {
    Player* player = (Player*) self.node;
    
    [player removeAllActions];
    
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"PlayerIdle"];
    NSMutableArray *textures = [NSMutableArray array];
    
    for (int i=0; i<=10; i++) {
        NSString *filename = [NSString stringWithFormat: @"idle%i.png", i];
        SKTexture* loadedTexture = [atlas textureNamed:filename];
        [textures addObject:loadedTexture];
    }
    
    SKAction* walkingAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    [player runAction:[SKAction repeatActionForever:walkingAnimation] withKey:@"walking"];
}

- (void) updateWithDeltaTime:(NSTimeInterval)seconds {
    NSLog(@"The player is IDLE");
    
}

@end

@implementation WalkingState

- (BOOL) isValidNextState:(Class)stateClass {
    return stateClass == IdleState.class
    || stateClass == JumpingState.class
    || stateClass == RunningState.class;
}

- (void)didEnterWithPreviousState:(GKState *)previousState {
    Player* player = (Player*) self.node;
    
    [player removeAllActions];
    
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"PlayerWalking"];
    NSMutableArray *textures = [NSMutableArray array];
    
    for (int i=1; i<=7; i++) {
        NSString *filename = [NSString stringWithFormat: @"adventurer%i.png", i];
        SKTexture* loadedTexture = [atlas textureNamed:filename];
        [textures addObject:loadedTexture];
    }
    
    SKAction* walkingAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    [player runAction:[SKAction repeatActionForever:walkingAnimation] withKey:@"walking"];
}

- (void) updateWithDeltaTime:(NSTimeInterval)seconds {
    NSLog(@"The player is WALKING");
    Player* player = (Player*) self.node;
    
    CGPoint forwardMove = CGPointMake(0.04, 0.0);
    CGPoint velocity = CGPointMake(0.0, 0.0);
    CGPoint forwardMoveStep = CGPointMultiplyScalar(forwardMove, seconds);
    
    velocity = CGPointAdd(velocity, forwardMoveStep);
    
    CGPoint minMovement = CGPointMake(0.0, -450);
    CGPoint maxMovement = CGPointMake(120.0, 250.0);
    velocity = CGPointMake(Clamp(velocity.x, minMovement.x, maxMovement.x), Clamp(velocity.y, minMovement.y, maxMovement.y));
    
    CGPoint velocityStep = CGPointMultiplyScalar(velocity, seconds);
    
    CGPoint desiredPosition = CGPointAdd(player.position, velocityStep);
    player.position = CGPointMake(desiredPosition.x, desiredPosition.y);
}

@end

@implementation JumpingState

- (BOOL) isValidNextState:(Class)stateClass {
    return stateClass == IdleState.class;
}

- (void) updateWithDeltaTime:(NSTimeInterval)seconds {
    NSLog(@"The player is JUMPING");
}

@end

@implementation RunningState

- (BOOL) isValidNextState:(Class)stateClass {
    return stateClass == WalkingState.class
    || stateClass == JumpingState.class
    || stateClass == IdleState.class;
}

- (void) updateWithDeltaTime:(NSTimeInterval)seconds {
    NSLog(@"The player is RUNNING");
}

@end
