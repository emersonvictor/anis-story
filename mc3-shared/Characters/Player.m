//
//  Player.m
//  SuperKoalio
//
//  Created by Jake Gundersen on 12/27/13.
//  Copyright (c) 2013 Razeware, LLC. All rights reserved.
//

#import "Player.h"
#import "SKTUtils.h"
#import "GameState.h"
#import "PlayerStates.h"

@implementation Player

- (instancetype)initWithImageNamed: (NSString *)name {
    if (self == [super initWithImageNamed:name]) {
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
    self.physicsBody.categoryBitMask = 0b1;
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
