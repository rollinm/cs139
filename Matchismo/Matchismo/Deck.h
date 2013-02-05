//
//  Deck.h
//  Stanfard
//
//  Created by Joe Burgett on 1/27/13.
//  Copyright (c) 2013 Joe Burgett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(Card *)drawRandomCard;
@end