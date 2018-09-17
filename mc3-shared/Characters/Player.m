//
//  Player.m
//  SuperKoalio
//
//  Created by Jake Gundersen on 12/27/13.
//  Copyright (c) 2013 Razeware, LLC. All rights reserved.
//

#import "Player.h"
#import "SKTUtils.h"

@implementation Player

- (instancetype)initWithImageNamed: (NSString *)name {
    if (self == [super initWithImageNamed:name]) {
        self.velocity = CGPointMake(0.0, 0.0);
    }
    
    self.physicsBody =  [SKPhysicsBody bodyWithRectangleOfSize: self.frame.size];
    self.physicsBody.affectedByGravity = TRUE;
    self.physicsBody.allowsRotation = TRUE;
    self.physicsBody.angularDamping = 0;
    self.physicsBody.angularVelocity = 0;
    self.physicsBody.mass = 70;
    self.physicsBody.dynamic = TRUE;
    
    // Collision
    self.physicsBody.categoryBitMask = 0b1;
    self.physicsBody.collisionBitMask = 0b11;
    
    return self;
}

- (void)update: (NSTimeInterval)delta {
//    CGPoint gravity = CGPointMake(0.0, -450.0);
//    CGPoint gravityStep = CGPointMultiplyScalar(gravity, delta);
    
    CGPoint forwardMove = CGPointMake(800.0, 0.0);
    CGPoint forwardMoveStep = CGPointMultiplyScalar(forwardMove, delta);
    
    // Velocity
//    self.velocity = CGPointAdd(self.velocity, gravityStep);
//    self.velocity = CGPointMake(self.velocity.x * 0.9, self.velocity.y);
    
    // Jump force
    CGPoint jumpForce = CGPointMake(0.0, 310.0);
    float jumpCutoff = 150.0;
    
    if (self.mightAsWellJump && self.onGround) {
        self.velocity = CGPointAdd(self.velocity, jumpForce);
        [self runAction:[SKAction playSoundFileNamed:@"jump.wav" waitForCompletion:NO]];
    } else if (!self.mightAsWellJump && self.velocity.y > jumpCutoff) {
        self.velocity = CGPointMake(self.velocity.x, jumpCutoff);
    }
    
    if (self.forwardMarch) {
        self.velocity = CGPointAdd(self.velocity, forwardMoveStep);
    }
    
    CGPoint minMovement = CGPointMake(0.0, -450);
    CGPoint maxMovement = CGPointMake(120.0, 250.0);
    self.velocity = CGPointMake(Clamp(self.velocity.x, minMovement.x, maxMovement.x), Clamp(self.velocity.y, minMovement.y, maxMovement.y));
    
    CGPoint velocityStep = CGPointMultiplyScalar(self.velocity, delta);
    
    self.desiredPosition = CGPointAdd(self.position, velocityStep);
    self.position = CGPointMake(self.desiredPosition.x, self.desiredPosition.y);
}


- (CGRect)collisionBoundingBox {
    CGRect boundingBox = CGRectInset(self.frame, 2, 0);
    CGPoint diff = CGPointSubtract(self.desiredPosition, self.position);
    return CGRectOffset(boundingBox, diff.x, diff.y);
}

@end
