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
    player.xScale = fabs(player.xScale) * player.sense;
    //    NSLog(@"VELOCITY:\nX - %f\nY - %f", player.velocity.x, player.velocity.y );
    float xStep = player.velocity.x * seconds;
//    float yStep = player.velocity.y * seconds;
    float yStep = player.physicsBody.velocity.dy * seconds;
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
    
    SKAction* idleAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
//    player.velocity = CGPointMake(0.0, 0.0);
    
    [player runAction:[SKAction repeatActionForever:idleAnimation] withKey:@"idle"];
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
    
    [player runAction:[SKAction repeatActionForever:walkingAnimation] withKey:@"walking"];

    // MARK: Looking for the sound file URL
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"walking" ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    NSError *error;

    // MARK: Configuring the audio player
    player.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
    player.audioPlayer.numberOfLoops = -1;
    player.audioPlayer.volume = 0.15;
    player.audioPlayer.enableRate = TRUE;
    player.audioPlayer.rate = 0.7;

    // MARK: Playing walking sound in the background thread
    qos_class_t identifier = QOS_CLASS_BACKGROUND;
    dispatch_queue_global_t backgroundQueue = dispatch_get_global_queue(identifier, 0);
    dispatch_async(backgroundQueue, ^{
        [player.audioPlayer play];
    });
}

- (void) willExitWithNextState:(GKState *)nextState {
    Player* player = (Player*) self.node;
    [player.audioPlayer stop];
}

@end

@implementation JumpingState

- (BOOL) isValidNextState:(Class)stateClass {
    return stateClass == JumpMomentumState.class;
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

- (void)updateWithDeltaTime:(NSTimeInterval)seconds {
    NSLog(@"%f", ((Player*)self.node).physicsBody.velocity.dy);
    Player* player = (Player*)self.node;
    
    if (player.physicsBody.velocity.dy>=10) {
        [self.stateMachine enterState:JumpMomentumState.class];
    }
    [super updateWithDeltaTime:seconds];
}

- (void) willExitWithNextState:(GKState *)nextState {
    // TO DO: Play falling sound
}


@end

@implementation JumpMomentumState

- (BOOL) isValidNextState:(Class)stateClass {
    return stateClass == FallingState.class;
}


- (void)updateWithDeltaTime:(NSTimeInterval)seconds {
    NSLog(@"%f", ((Player*)self.node).physicsBody.velocity.dy);
    Player* player = (Player*)self.node;
    
    if (player.physicsBody.velocity.dy<=0) {
        [self.stateMachine enterState:FallingState.class];
    }
    [super updateWithDeltaTime:seconds];
}


@end

@implementation FallingState

- (BOOL) isValidNextState:(Class)stateClass {
    return stateClass == IdleState.class;
}

- (void)didEnterWithPreviousState:(GKState *)previousState {
    
    Player* player = (Player*) self.node;
    
    [player removeAllActions];
    
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"PlayerLanding"];
    NSMutableArray *textures = [NSMutableArray array];
    
    for (int i=0; i<=0; i++) {
        NSString *filename = [NSString stringWithFormat: @"landing%i.png", i];
        SKTexture* loadedTexture = [atlas textureNamed:filename];
        [textures addObject:loadedTexture];
    }
    
    SKAction* fallingAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    [player runAction:[SKAction repeatActionForever:fallingAnimation] withKey:@"falling"];
}

- (void)updateWithDeltaTime:(NSTimeInterval)seconds {
    Player* player = (Player*)self.node;
    
    if (player.physicsBody.velocity.dy==0) {
        [self.stateMachine enterState:IdleState.class];
    }
    [super updateWithDeltaTime:seconds];
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
