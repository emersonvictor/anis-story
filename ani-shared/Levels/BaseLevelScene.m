//
//  BaseLevelScene.m
//  mc3
//
//  Created by André Carneiro on 12/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseLevelScene.h"
#import "Categories.h"
#import "InteractiveObject.h"

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
    
//    NSLog(@"keyDown:'%@' keyCode: 0x%02X", event.characters, event.keyCode);
    
    [self.delegate handleKeyDown:event];
}

- (void)keyUp:(NSEvent *)event {
    [self.delegate handleKeyUp:event];
}
#endif

- (void)didBeginContact: (SKPhysicsContact *)contact {
    NSArray *bodies = @[@(contact.bodyA.categoryBitMask),
                        @(contact.bodyB.categoryBitMask)];
    
    // MARK: Interactive Object detection
    if ([bodies containsObject:@(PlayerCategory)] && [bodies containsObject:@(InteractiveCategory)]) {
        NSLog(@"Personagem passou por um objeto interativo");
    }
}

- (void)didEndContact: (SKPhysicsContact *)contact {
    NSArray *bodies = @[contact.bodyA,
                        contact.bodyB];

    for (SKPhysicsBody *body in bodies) {
        if (body.categoryBitMask == InteractiveCategory) {
            InteractiveObject *object = (InteractiveObject*)body.node;
            object.hasPerformedAction = FALSE;
        }
    }
}

@end
