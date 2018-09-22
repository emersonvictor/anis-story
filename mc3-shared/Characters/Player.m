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
    
    self.sense = 1;
    
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
    self.physicsBody.allowsRotation = FALSE;
    self.physicsBody.angularDamping = 0;
    self.physicsBody.angularVelocity = 0;
    self.physicsBody.mass = 70;
    self.physicsBody.dynamic = TRUE;
    self.physicsBody.restitution = 0.0;
    
    // MARK: Collision
    self.physicsBody.categoryBitMask = playerCategory;
    self.physicsBody.collisionBitMask = 0b11;
    
    return self;
}

- (void) accelerate:(NSTimeInterval)seconds {
    double theta = 3600.0;
    CGPoint forwardMove = CGPointMake(theta*self.sense, 0.0);
    CGPoint forwardMoveStep = CGPointMultiplyScalar(forwardMove, seconds);
    
    self.velocity = CGPointAdd(self.velocity, forwardMoveStep);
    CGPoint minVelocity = CGPointMake(0.0, -450);
    CGPoint maxVelocity = CGPointMake(120.0, 600);
    if (self.sense == -1) {
        
        minVelocity = CGPointMake(-120.0, -450);
        maxVelocity = CGPointMake(0.0, 600);
    }
    
    //    NSLog(@"VELOCITY:\nX - %f\nY - %f", player.velocity.x, player.velocity.y );
    
    self.velocity = CGPointMake(Clamp(self.velocity.x, minVelocity.x, maxVelocity.x),
                                  self.velocity.y);
}

- (void)deaccelerate:(NSTimeInterval)seconds {
    self.velocity = CGPointMake(0.0, self.velocity.y);
}

- (void) moveUp:(NSTimeInterval)seconds {
    //    NSLog(@"The player is JUMPING");
//    Player* player = (Player*) self.node;
    
    // MARK: Jump force
    CGPoint jumpForce = CGPointMake(0.0, 600.0);
    float jumpCutoff = 800.0;
    
    self.velocity = CGPointAdd(self.velocity, jumpForce);
    if (self.velocity.y > jumpCutoff) {
        self.velocity = CGPointMake(self.velocity.x, jumpCutoff);
    }
    
    CGPoint minVelocity = CGPointMake(0.0, -450);
    CGPoint maxVelocity = CGPointMake(120.0, 500.0);
    
    if (self.sense == -1) {
        
        minVelocity = CGPointMake(-120.0, -450);
        maxVelocity = CGPointMake(0.0, 500.0);
    }
    self.velocity = CGPointMake(self.velocity.x,
                                  Clamp(self.velocity.y, minVelocity.y, maxVelocity.y));
    //    NSLog(@"VELOCITY WHILE JUMPING:\nX - %f\nY - %f", player.velocity.x, player.velocity.y );
    //    NSLog(@"SENSE:\nX - %i", player.sense);
    
}

- (void) fall:(NSTimeInterval) seconds {
    
    NSLog(@"%f", self.physicsBody.velocity.dy);
    
    self.velocity = CGPointMake(self.velocity.x, self.physicsBody.velocity.dy);
    
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
