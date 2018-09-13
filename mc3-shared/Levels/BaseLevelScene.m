//
//  BaseLevelScene.m
//  mc3
//
//  Created by André Carneiro on 12/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseLevelScene.h"

@implementation BaseLevelScene {
    NSTimeInterval _lastUpdateTime;
}

@dynamic delegate;

- (void)sceneDidLoad {
    // Setup your scene here
    
    // Initialize update time
    _lastUpdateTime = 0;
}



-(void)update:(CFTimeInterval)currentTime {
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

- (void)keyDown:(NSEvent *)event {
    [self.delegate handleKeyDown:event];
}

- (void)keyUp:(NSEvent *)event {
    [self.delegate handleKeyUp:event];
}



@end
