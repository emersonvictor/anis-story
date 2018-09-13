//
//  Platform.m
//  mc3
//
//  Created by Emerson Victor on 13/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "PlatformNode.h"

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
    // TODO: - Defition of collision, category and contact bit mask
    self.physicsBody.categoryBitMask = 0;
    self.physicsBody.collisionBitMask = 1;
    self.physicsBody.contactTestBitMask = 1;

    return self;
}

@end
