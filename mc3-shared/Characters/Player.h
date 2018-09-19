//
//  Player.h
//  mc3
//
//  Created by Gabriel D'Luca on 14/09/18.
//  Copyright © 2018 Gabriel D'Luca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Player : SKSpriteNode <SKPhysicsContactDelegate>

@property (nonatomic, assign) BOOL forwardMarch;
@property (nonatomic, assign) BOOL mightAsWellJump;
@property (nonatomic, assign) BOOL onGround;
@property (nonatomic, assign) CGPoint desiredPosition;
@property (nonatomic, assign) CGPoint velocity;
- (void)update:(NSTimeInterval)delta;
- (CGRect)collisionBoundingBox;

@end
