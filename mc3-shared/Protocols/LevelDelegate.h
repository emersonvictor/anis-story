//
//  LevelDelegate.h
//  mc3
//
//  Created by André Carneiro on 12/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@protocol LevelDelegate <SKSceneDelegate>

// MARK: - Keyboard methods
#if TARGET_OS_OSX
-(void) handleKeyUp:(NSEvent *) event;
-(void) handleKeyDown:(NSEvent *) event;
#endif

@end
