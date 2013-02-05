//
//  PlayingCard.h
//  Stanfard
//
//  Created by Joe Burgett on 1/27/13.
//  Copyright (c) 2013 Joe Burgett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;

@end
