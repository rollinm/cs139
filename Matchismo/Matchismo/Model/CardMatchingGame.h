//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Rollin Morris on 1/30/13.
//  Copyright (c) 2013 appwerkz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import"Deck.h"


@interface CardMatchingGame : NSObject

    //designated initializer
-(id) initWithCardCount:(NSUInteger) cardCount
              usingDeck:(Deck *) deck;

- (void) flipCardAtIndex: (NSUInteger) index;

- (Card *) cardAtIndex: (NSUInteger) index;

@property (readonly, nonatomic) int score;
@property (nonatomic) int game23Mode;
@property (readonly, strong, nonatomic) NSString * lastMove;

@end
