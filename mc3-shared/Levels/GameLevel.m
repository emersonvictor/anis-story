//
//  GameLevel.m
//  mc3
//
//  Created by André Carneiro on 10/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "GameLevel.h"
#import <CoreGraphics/CoreGraphics.h>
#import "KeyboardInputHandler.h"

@implementation GameLevel {
    NSTimeInterval _lastUpdateTime;
}

// MARK: - Initializers and rendering
- (void)sceneDidLoad {
    self.size = CGSizeMake(self.frame.size.width*5, self.frame.size.height*2);
    self.physicsWorld.contactDelegate = self;
    self.physicsWorld.gravity = CGVectorMake(0.0, -5.0);
    
    // Physics body
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect: CGRectMake(-self.size.width/2, -self.size.height/2, self.size.width, self.size.height)];
    self.physicsBody.categoryBitMask = 0b11;
    self.physicsBody.collisionBitMask = 0b1;
    
    }

- (void)didMoveToView:(SKView *)view {
    NSLog(@"CARREGOU");
    [self.delegate sceneDidLoadFor:self];
}

-(void)update:(CFTimeInterval)currentTime {

    // Initialize _lastUpdateTime if it has not already been
    if (_lastUpdateTime == 0) {
        _lastUpdateTime = currentTime;
    }
    
    // Calculate time since last update
    CGFloat delta = currentTime - _lastUpdateTime;
    
    // Update entities
    for (GKEntity *entity in self.entities) {
        [entity updateWithDeltaTime:delta];
    }
    _lastUpdateTime = currentTime;
}

@end
