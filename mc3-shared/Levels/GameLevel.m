//
//  GameLevel.m
//  mc3
//
//  Created by André Carneiro on 10/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "GameLevel.h"
#import "Player.h"
#import <CoreGraphics/CoreGraphics.h>
#import "KeyboardInputHandler.h"


@implementation GameLevel {
    NSTimeInterval _lastUpdateTime;
}


// MARK: - Initializers and rendering
- (void)sceneDidLoad {
    // Physics body
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect: self.frame];
    self.physicsBody.categoryBitMask = 0b11;
    self.physicsBody.collisionBitMask = 0b1;
    
    // Create player and add to the scene
    self.player = [[Player alloc] initWithImageNamed:@"koalio_stand"];
    self.player.position = CGPointMake(0, 100);
    self.player.zPosition = 15;

    [self addChild: self.player];
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
    
    [self.player update:delta];
    _lastUpdateTime = currentTime;
}

// MARK: - Siri Remote interactions
#if TARGET_OS_TV
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint touchLocation = [touch locationInNode:self];
        if (touchLocation.x > self.size.width / 2.0) {
            self.player.mightAsWellJump = TRUE;
        } else {
            self.player.forwardMarch = TRUE;
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
            self.player.forwardMarch = FALSE;
            self.player.mightAsWellJump = TRUE;
        } else if (previousTouchLocation.x > halfWidth && touchLocation.x <= halfWidth) {
            self.player.forwardMarch = TRUE;
            self.player.mightAsWellJump = FALSE;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint touchLocation = [touch locationInNode:self];
        if (touchLocation.x < self.size.width / 2.0) {
            self.player.forwardMarch = FALSE;
        } else {
            self.player.mightAsWellJump = FALSE;
        }
        self.player.velocity = CGPointMake(0.0, 0.0);
    }
}
#endif

@end
