//
//  Platform.m
//  mc3
//
//  Created by Emerson Victor on 13/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "PlatformNode.h"
#import "Categories.h"

@implementation PlatformNode

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    
    // Define physics body characteristics
    self.physicsBody.affectedByGravity = FALSE;
    self.physicsBody.allowsRotation = FALSE;
    self.physicsBody.angularDamping = 0;
    self.physicsBody.angularVelocity = 0;
    self.physicsBody.dynamic = FALSE;
    
    // Collision
    self.physicsBody.categoryBitMask = PlatformCategory;
    self.physicsBody.contactTestBitMask = PlayerCategory | NonInteractiveCategory | InteractiveCategory;
    self.physicsBody.collisionBitMask = PlayerCategory | NonInteractiveCategory | InteractiveCategory;

    return self;
}

@end
