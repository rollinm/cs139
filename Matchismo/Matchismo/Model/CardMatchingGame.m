//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Rollin Morris on 1/30/13.
//  Copyright (c) 2013 appwerkz. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (strong,nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (strong, nonatomic) NSString *lastMove;
@property (strong, nonatomic) NSMutableArray *otherCards;
@end
    

@implementation CardMatchingGame

-(NSMutableArray *) cards
{
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(NSMutableArray *) otherCards
{
    if (!_otherCards) _otherCards = [[NSMutableArray alloc]init];
    return _otherCards;
}

-(id) initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i=0;i<cardCount;i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self=nil;
            } else {
                self.cards[i]=card;
            
            }
        }
    }
    self.game23Mode = 2;
    return self;
}

-(Card *) cardAtIndex:(NSUInteger)index
{
    Card *retCard;
    if (index<self.cards.count)
        retCard = self.cards[index];
    
    return retCard;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1
-(void) flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            self.lastMove = [[NSString alloc] initWithFormat:@"Flipped %@",card.contents];
            
                //do we have enough card to do a match for the mode
            if (self.otherCards.count + 1 == self.game23Mode) {
                    //see if flipping this card up creates a match
                int matchScore = [card match:self.otherCards];
                if (matchScore) {
                        //match made
                        //set all cards unplayable
                    for (Card *otherCard in self.otherCards) {
                        otherCard.unplayable=YES;
                    }
                    card.unplayable=YES;
                    self.score += matchScore * MATCH_BONUS;
                    self.otherCards = nil;
                        // self.lastMove = [[NSString alloc] initWithFormat:@"Matched %@ %@ for %d points",card.contents,otherCards.contents,matchScore * MATCH_BONUS];
                } else {
                        //no match
                        //reset cards
                    NSString *otherCardContents = @"";
                    for (Card *otherCard in self.otherCards) {
                         otherCard.faceUp = NO;
                        otherCardContents = [otherCardContents stringByAppendingFormat:@"%@,",otherCard.contents];
                    }
                    self.otherCards = nil;
                    [self.otherCards addObject:card];

         
                        
                    self.score -= MISMATCH_PENALTY;
                    self.lastMove = [[NSString alloc] initWithFormat:@"No Match %@%@ for %d point penalty",otherCardContents,card.contents, MISMATCH_PENALTY];
                }
                
            } else {
                [self.otherCards addObject:card];    
            }
                
        } else {
            [self.otherCards removeObject:card];
        }
        self.score -= FLIP_COST;
    }
    
    card.faceUp = !card.isFaceUp;
    
}

@end
