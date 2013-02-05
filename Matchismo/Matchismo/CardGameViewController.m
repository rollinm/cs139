//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Rollin Morris on 1/27/13.
//  Copyright (c) 2013 appwerkz. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"



@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSwitch;

@end

@implementation CardGameViewController

- (IBAction)DealPressed:(id)sender {
    self.game = nil;
    self.flipCount = 0;
    self.modeSwitch.enabled=true;
    [self updateUI];
}

-(void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
    
}
- (IBAction)modeChanged:(id)sender {
        //test which mode is used
    if (self.modeSwitch.selectedSegmentIndex ==0) {
        self.game.game23Mode = 2;
    
    } else {
        self.game.game23Mode = 3;
    }
}

-(CardMatchingGame *) game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    
    return _game;
}


-(void) updateUI
{
    
    for (UIButton *cardButton in self.cardButtons) {
        
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
                   
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        [cardButton setImage:[[UIImage alloc] init] forState:UIControlStateSelected];
        [cardButton setImage:[[UIImage alloc] init] forState:UIControlStateSelected|UIControlStateDisabled];
            // [cardButton setImage:[UIImage imageNamed:@"cardBack.png"] forState:UIControlStateNormal];
    
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = ! card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
  
                    //  [cardButton setImage:[[UIImage alloc] init] ];

        
    }
    
    if (self.flipCount>0) {
        self.modeSwitch.enabled = false;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    self.lastMoveLabel.text = self.game.lastMove;
}

//-(void) setCardButtons:(NSArray *)cardButtons
//{
//    _cardButtons = cardButtons;
//    for (UIButton *cardButton in cardButtons) {
//        Card *card = [self.myDeck drawRandomCard];
//        [cardButton setTitle:card.contents forState:UIControlStateSelected];
//    }
//}

- (IBAction)flipCard:(UIButton *)sender {
    

    //sender.selected = !sender.isSelected;
    
    self.flipCount++;

    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    [self updateUI];
}


@end
