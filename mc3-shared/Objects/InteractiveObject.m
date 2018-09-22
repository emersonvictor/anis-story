//
//  InteractiveObject.m
//  mc3
//
//  Created by Gabriel D'Luca on 22/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "InteractiveObject.h"
#import "Categories.h"

@implementation InteractiveObject

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    self.hasPerformedAction = FALSE;

    // Define physics body characteristics
    self.physicsBody.affectedByGravity = FALSE;
    self.physicsBody.allowsRotation = FALSE;
    self.physicsBody.angularDamping = 0;
    self.physicsBody.angularVelocity = 0;
    self.physicsBody.dynamic = FALSE;

    // Collision
    self.physicsBody.categoryBitMask = InteractiveCategory;
    self.physicsBody.contactTestBitMask = PlayerCategory;
    self.physicsBody.collisionBitMask = PlatformCategory;

    return self;
}

- (void) runInteraction:(Player*)withPlayer {
    NSAssert(FALSE, @"This is an abstract method and should be overridden");
    self.hasPerformedAction = TRUE;
}
@end
