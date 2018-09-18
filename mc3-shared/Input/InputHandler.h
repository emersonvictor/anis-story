//
//  InputHandler.h
//  mc3
//
//  Created by André Carneiro on 12/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InputScheme.h"

@interface InputHandler: NSObject

@property (nonatomic, weak) InputScheme* inputScheme;

- (instancetype) initWith:(InputScheme*) inputScheme;

@end
