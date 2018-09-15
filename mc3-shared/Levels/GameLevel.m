//
//  GameLevel.m
//  mc3
//
//  Created by André Carneiro on 10/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "GameLevel.h"
#import "Player.h"


@implementation GameLevel {
    NSTimeInterval _lastUpdateTime;
}


// MARK: - Initializers and rendering
- (void)sceneDidLoad {
    self.player = [[Player alloc] initWithImageNamed:@"koalio_stand"];
    self.player.physicsBody.categoryBitMask = 0;
    self.player.position = CGPointMake(0, 100);
    self.player.zPosition = 15;
    [self addChild:self.player];
    
    _lastUpdateTime = 0;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect: self.frame];
    }

-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
    
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
    
    [self.player update:delta];
    _lastUpdateTime = currentTime;
}

// MARK: - Siri Remote interactions
#if TARGET_OS_TV
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint touchLocation = [touch locationInNode:self];
        if (touchLocation.x > self.size.width / 2.0) {
            self.player.mightAsWellJump = YES;
        } else {
            self.player.forwardMarch = YES;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        float halfWidth = self.size.width / 2.0;
        CGPoint touchLocation = [touch locationInNode:self];
        
        // Get previous touch and convert it to node space
        CGPoint previousTouchLocation = [touch previousLocationInNode:self];
        
        if (touchLocation.x > halfWidth && previousTouchLocation.x <= halfWidth) {
            self.player.forwardMarch = NO;
            self.player.mightAsWellJump = YES;
        } else if (previousTouchLocation.x > halfWidth && touchLocation.x <= halfWidth) {
            self.player.forwardMarch = YES;
            self.player.mightAsWellJump = NO;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint touchLocation = [touch locationInNode:self];
        if (touchLocation.x < self.size.width / 2.0) {
            self.player.forwardMarch = NO;
        } else {
            self.player.mightAsWellJump = NO;
        }
    }
}
#endif

@end
