//
//  BaseLevelScene.m
//  mc3
//
//  Created by André Carneiro on 12/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseLevelScene.h"
#import <TargetConditionals.h>

@implementation BaseLevelScene {
    NSTimeInterval _lastUpdateTime;
}

@dynamic delegate;

- (void)sceneDidLoad {
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect: self.frame];
}

- (void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
    
    // Initialize _lastUpdateTime if it has not already been
    if (_lastUpdateTime == 0) {
        _lastUpdateTime = currentTime;
    }
    
    // Calculate time since last update
    CGFloat dt = currentTime - _lastUpdateTime;
    
    // Update entities
    for (GKEntity *entity in self.entities) {
        [entity updateWithDeltaTime:dt];
    }
    
    _lastUpdateTime = currentTime;
}


// MARK: - Keyboard events
#if TARGET_OS_OSX
- (void)keyDown:(NSEvent *)event {
    [self.delegate handleKeyDown:event];
}

- (void)keyUp:(NSEvent *)event {
    [self.delegate handleKeyUp:event];
}
#endif

@end
