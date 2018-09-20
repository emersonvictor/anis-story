//
//  Player.m
//  mc3
//
//  Created by Gabriel D'Luca on 14/09/18.
//  Copyright © 2018 Gabriel D'Luca. All rights reserved.
//

#import "Player.h"
#import "SKTUtils.h"
#import "Categories.h"
#import "GameState.h"
#import "PlayerStates.h"

@implementation Player

- (instancetype)initWithTexture:(SKTexture *)texture {
    if (self == [super initWithTexture:texture]) {
        self.velocity = CGPointMake(0.0, 0.0);
    }
    
    // MARK: State Machine
    GameState* walking = [[WalkingState alloc] initWithNode:self];
    GameState* idle = [[IdleState alloc] initWithNode:self];
    GameState* jumping = [[JumpingState alloc] initWithNode:self];
    GameState* running = [[RunningState alloc] initWithNode:self];
    
    self.stateMachine = [[GKStateMachine alloc] initWithStates:  @[idle, walking, running, jumping]];
    [self.stateMachine enterState:IdleState.class];
    
    // MARK: Physics Body
    self.physicsBody =  [SKPhysicsBody bodyWithRectangleOfSize: self.frame.size];
    self.physicsBody.affectedByGravity = TRUE;
    self.physicsBody.allowsRotation = TRUE;
    self.physicsBody.angularDamping = 0;
    self.physicsBody.angularVelocity = 0;
    self.physicsBody.mass = 70;
    self.physicsBody.dynamic = TRUE;
    
    // MARK: Collision
    self.physicsBody.categoryBitMask = playerCategory;
    self.physicsBody.collisionBitMask = 0b11;
    
    return self;
}

- (void)updateWithDeltaTime: (NSTimeInterval)delta {
    [self.stateMachine updateWithDeltaTime: delta];
}


- (CGRect)collisionBoundingBox {
    CGRect boundingBox = CGRectInset(self.frame, 2, 0);
    CGPoint diff = CGPointSubtract(self.desiredPosition, self.position);
    return CGRectOffset(boundingBox, diff.x, diff.y);
}

@end
