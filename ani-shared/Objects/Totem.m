//
//  Totem.m
//  mc3
//
//  Created by Gabriel D'Luca on 22/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "Totem.h"

@implementation Totem

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}

- (void) runInteraction:(Player*)withPlayer {
    // TO DO: Implementar interação do palito de fósforo
    self.hasPerformedAction = TRUE;
}

@end
