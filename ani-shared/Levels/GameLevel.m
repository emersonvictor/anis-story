//
//  GameLevel.m
//  mc3
//
//  Created by André Carneiro on 10/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "GameLevel.h"

@implementation GameLevel {
    NSTimeInterval _lastUpdateTime;
}

// MARK: - Initializers and rendering
- (void)didMoveToView:(SKView *)view {
    [self.delegate sceneDidLoadFor:self];
    
    SKAudioNode *audioNode = [[SKAudioNode alloc] initWithFileNamed:@"raindrops.m4a"];
    [audioNode runAction:[SKAction changeVolumeTo:0 duration:0]];
    [audioNode setPosition:CGPointMake(-1063.073, 292.758)];
    [audioNode setPositional:TRUE];
    [self addChild:audioNode];
    [audioNode runAction:[SKAction changeVolumeTo:0.01 duration:0]];
}

- (void)sceneDidLoad {
    self.physicsWorld.contactDelegate = self;
    self.physicsWorld.gravity = CGVectorMake(0.0, -5.0);
    
    // Physics body
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect: CGRectMake(-self.size.width/2, -self.size.height/2, self.size.width, self.size.height)];
    self.physicsBody.categoryBitMask = 0b11;
    self.physicsBody.collisionBitMask = 0b1;
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
