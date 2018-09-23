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

@implementation MovingState

- (void) updateWithDeltaTime:(NSTimeInterval)seconds {
//        NSLog(@"The player is MOVING");
    Player* player = (Player*) self.node;
    
    //    NSLog(@"VELOCITY:\nX - %f\nY - %f", player.velocity.x, player.velocity.y );
    float xStep = player.velocity.x * seconds;
    float yStep = player.velocity.y * seconds;
    CGPoint step = CGPointMake(xStep, yStep);
    //    NSLog(@"STEP:\nX - %f\nY - %f", velocityStep.x, velocityStep.y );
    player.position = CGPointAdd(player.position, step);
    
}


@end

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
    
    player.velocity = CGPointMake(0.0, 0.0);
    
    [player runAction:[SKAction repeatActionForever:walkingAnimation] withKey:@"walking"];
}

- (void) updateWithDeltaTime:(NSTimeInterval)seconds {
//    NSLog(@"The player is IDLE");
    
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
    player.xScale = fabs(player.xScale) * player.sense;
    [player runAction:[SKAction repeatActionForever:walkingAnimation] withKey:@"walking"];
}

//- (void) updateWithDeltaTime:(NSTimeInterval)seconds {
////    NSLog(@"The player is WALKING");
//    Player* player = (Player*) self.node;
//
//    double theta = 3600.0;
//    CGPoint forwardMove = CGPointMake(theta*player.sense, 0.0);
//    CGPoint forwardMoveStep = CGPointMultiplyScalar(forwardMove, seconds);
//
//    player.velocity = CGPointAdd(player.velocity, forwardMoveStep);
//    CGPoint minVelocity = CGPointMake(0.0, -450);
//    CGPoint maxVelocity = CGPointMake(120.0, 600);
//    if (player.sense == -1) {
//
//        minVelocity = CGPointMake(-120.0, -450);
//        maxVelocity = CGPointMake(0.0, 600);
//    }
//
////    NSLog(@"VELOCITY:\nX - %f\nY - %f", player.velocity.x, player.velocity.y );
//
//    player.velocity = CGPointMake(Clamp(player.velocity.x, minVelocity.x, maxVelocity.x),
//                           player.velocity.y);
////    player.velocity = velocity;
//    CGPoint velocityStep = CGPointMultiplyScalar(player.velocity, seconds);
////    NSLog(@"STEP:\nX - %f\nY - %f", velocityStep.x, velocityStep.y );
//    CGPoint desiredPosition = CGPointAdd(player.position, velocityStep);
//    player.position = CGPointMake(desiredPosition.x , player.position.y);
//
//}

@end

@implementation JumpingState

- (BOOL) isValidNextState:(Class)stateClass {
    return stateClass == IdleState.class
    || stateClass == WalkingState.class;
}

- (void)didEnterWithPreviousState:(GKState *)previousState {
    Player* player = (Player*) self.node;
    
    [player removeAllActions];
    
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"PlayerJumping"];
    NSMutableArray *textures = [NSMutableArray array];
    
    for (int i=0; i<=0; i++) {
        NSString *filename = [NSString stringWithFormat: @"jump%i.png", i];
        SKTexture* loadedTexture = [atlas textureNamed:filename];
        [textures addObject:loadedTexture];
    }
    
    SKAction* jumpingAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    [player runAction:[SKAction repeatActionForever:jumpingAnimation] withKey:@"jumping"];
}

//- (void) updateWithDeltaTime:(NSTimeInterval)seconds {
////    NSLog(@"The player is JUMPING");
//    Player* player = (Player*) self.node;
//
//    // MARK: Jump force
//    CGPoint jumpForce = CGPointMake(0.0, 600.0);
//    float jumpCutoff = 800.0;
//
//    player.velocity = CGPointAdd(player.velocity, jumpForce);
//    if (player.velocity.y > jumpCutoff) {
//        player.velocity = CGPointMake(player.velocity.x, jumpCutoff);
//    }
//
//    CGPoint minVelocity = CGPointMake(0.0, -450);
//    CGPoint maxVelocity = CGPointMake(120.0, 500.0);
//
//    if (player.sense == -1) {
//
//        minVelocity = CGPointMake(-120.0, -450);
//        maxVelocity = CGPointMake(0.0, 500.0);
//    }
//    player.velocity = CGPointMake(player.velocity.x,
//                                  Clamp(player.velocity.y, minVelocity.y, maxVelocity.y));
////    NSLog(@"VELOCITY WHILE JUMPING:\nX - %f\nY - %f", player.velocity.x, player.velocity.y );
////    NSLog(@"SENSE:\nX - %i", player.sense);
//
//
//    CGPoint velocityStep = CGPointMultiplyScalar(player.velocity, seconds);
//
//    player.desiredPosition = CGPointAdd(player.position, velocityStep);
//
////    NSLog(@"DESIRED POSITION:\nX - %f\nY - %f", player.desiredPosition.x, player.desiredPosition.y );
//    player.position = player.desiredPosition;
//}

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
