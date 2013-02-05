//
//  Card.m
//  Stanfard
//
//  Created by Joe Burgett on 1/27/13.
//  Copyright (c) 2013 Joe Burgett. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int) match:(NSArray *)otherCards {
    
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

@end
