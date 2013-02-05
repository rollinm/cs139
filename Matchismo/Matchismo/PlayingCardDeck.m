//
//  PlayingCardDeck.m
//  Stanfard
//
//  Created by Joe Burgett on 1/27/13.
//  Copyright (c) 2013 Joe Burgett. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"
@implementation PlayingCardDeck


-(id)init {
    self = [super init];
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:NO];
            }
        }
    }
    return self;
}
-(Card *)drawRandomCard
{
    NSLog(@"calling draw random card");
    return [super drawRandomCard];
}


@end