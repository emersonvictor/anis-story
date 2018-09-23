//
//  Player.h
//  mc3
//
//  Created by Gabriel D'Luca on 14/09/18.
//  Copyright © 2018 Gabriel D'Luca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "StatefulNode.h"

typedef enum : NSInteger {
    Unmasked = 0x1<<0,
    WhaleMask = 0x1<<1
} Masks;

@interface Player : StatefulNode <SKPhysicsContactDelegate>

@property (nonatomic, assign) CGPoint desiredPosition;
@property (nonatomic, assign) CGPoint velocity;
@property (nonatomic) NSInteger mask;
@property (nonatomic) int sense;

- (void) accelerate:(NSTimeInterval)seconds;
- (void) deaccelerate:(NSTimeInterval)seconds;
- (void) moveUp:(NSTimeInterval)seconds;
- (void) fall:(NSTimeInterval)seconds;
- (CGRect)collisionBoundingBox;

@end
