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

    self.mask = Unmasked;
    self.sense = 1;
    self.heldItem = @"";
    self.speedForce = 4800.0;
    
    // MARK: State Machine
    GameState* walking = [[WalkingState alloc] initWithNode:self];
    GameState* idle = [[IdleState alloc] initWithNode:self];
    GameState* jumping = [[JumpingState alloc] initWithNode:self];
    GameState* running = [[RunningState alloc] initWithNode:self];
    GameState* falling = [[FallingState alloc] initWithNode:self];
    GameState* jumpMomentum = [[JumpMomentumState alloc] initWithNode:self];
    GameState* grabbing = [[GrabbingState alloc] initWithNode:self];
    GameState* climbing = [[ClimbingState alloc] initWithNode:self];
    
    self.stateMachine = [[GKStateMachine alloc] initWithStates:  @[idle, walking, running, jumping, jumpMomentum, falling, grabbing, climbing]];
    [self.stateMachine enterState:IdleState.class];
    
    // MARK: Physics Body
    
    self.physicsBody =  [SKPhysicsBody bodyWithRectangleOfSize: CGSizeMake(70, 90)];

    self.physicsBody.affectedByGravity = TRUE;
    self.physicsBody.allowsRotation = FALSE;
    self.physicsBody.angularDamping = 0;
    self.physicsBody.angularVelocity = 0;
    self.physicsBody.mass = 20;
    self.physicsBody.dynamic = TRUE;
    self.physicsBody.restitution = 0.0;
    
    // MARK: Collision
    self.physicsBody.categoryBitMask = PlayerCategory;
    self.physicsBody.contactTestBitMask = NonInteractiveCategory | InteractiveCategory;
    self.physicsBody.collisionBitMask = PlatformCategory;
    
    return self;
}

- (void) accelerate:(NSTimeInterval)seconds {
    CGPoint forwardMove = CGPointMake(self.speedForce*self.sense, 0.0);
    CGPoint forwardMoveStep = CGPointMultiplyScalar(forwardMove, seconds);
    
    self.velocity = CGPointAdd(self.velocity, forwardMoveStep);
    CGPoint minVelocity = CGPointMake(0.0, -450);

    CGPoint maxVelocity = CGPointMake(240.0, 600);
    if (self.sense == -1) {
        
        minVelocity = CGPointMake(-240.0, -450);
        maxVelocity = CGPointMake(0.0, 600);
    }
    
    self.velocity = CGPointMake(Clamp(self.velocity.x, minVelocity.x, maxVelocity.x), self.velocity.y);
}

- (void) deaccelerate:(NSTimeInterval)seconds {
    self.velocity = CGPointMake(0.0, self.velocity.y);
}

- (void) moveUp:(NSTimeInterval)seconds {
        self.physicsBody.velocity = CGVectorMake(self.physicsBody.velocity.dx, (self.physicsBody.velocity.dy+200));
        CGPoint minVelocity = CGPointMake(0.0, -450);
        CGPoint maxVelocity = CGPointMake(120.0, 500.0);
        
        if (self.sense == -1) {
            minVelocity = CGPointMake(-120.0, -450);
            maxVelocity = CGPointMake(0.0, 500.0);
        }
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

- (void) useMaskEffect {
    if (self.mask == Unmasked) {
        return;
    } else if (self.mask == WhaleMask && !self.audioPlayer.isPlaying) {
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"whaleMoan" ofType:@"wav"];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        NSError *error;

        // MARK: Whale Sound Effect
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
        self.audioPlayer.numberOfLoops = 0;
        [self.audioPlayer play];
    }
}

@end
