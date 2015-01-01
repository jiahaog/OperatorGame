//
//  HPDLifeBarView.m
//  OperatorGame
//
//  Created by Goh Jia Hao on 1/1/15.
//  Copyright (c) 2015 Hippo Design. All rights reserved.
//

#import "HPDLifeBarView.h"
#import <POP.h>
#import <UIColor+BFPaperColors.h>


@interface HPDLifeBarView ()

@property (nonatomic) CGFloat currentLifeWidth;
@property (nonatomic) CGFloat widthOfEachSegment;
@property (nonatomic) UIView *lifeBar;
@property (nonatomic) UILabel *scoreLabel;

@property (nonatomic) int maxLife;


@end

@implementation HPDLifeBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor grayColor];
    
    self.maxLife = 20;
    
    // subtract total width by frame height as we want a square at the end to display the score
    self.widthOfEachSegment = (self.frame.size.width - self.frame.size.height) / self.maxLife;
    
    
    [self initialiseBar];
    [self initialiseScore];
    
    return self;
}

- (void)initialiseBar {
    if (!self.lifeBar) {
        
        int initialLife = 10;
        
        self.lifeBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.widthOfEachSegment *initialLife, self.frame.size.height)];
        [self.lifeBar setBackgroundColor:[UIColor paperColorRed]];
        [self addSubview:self.lifeBar];
    }
}

- (void)initialiseScore {
    if (!self.scoreLabel) {
        self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - self.frame.size.height, 0, self.frame.size.height, self.frame.size.height)];
        [self.scoreLabel setFont:[UIFont systemFontOfSize:30]];
        [self.scoreLabel setTextColor:[UIColor whiteColor]];
        [self.scoreLabel setTextAlignment:NSTextAlignmentCenter];
        [self.scoreLabel setBackgroundColor:[UIColor paperColorCyan]];
        [self addSubview:self.scoreLabel];
    }
}

//- (void)increaseLife {
//    
//    CGRect newFrame = CGRectMake(0, 0, self.lifeBar.frame.size.width + self.widthOfEachSegment, self.lifeBar.frame.size.height);
//
//    [self animateLifeBarToFrame:newFrame];
//}
//
//- (void)decreaseLife {
//    
//    CGRect newFrame = CGRectMake(0, 0, self.lifeBar.frame.size.width - self.widthOfEachSegment, self.lifeBar.frame.size.height);
//    
//    [self animateLifeBarToFrame:newFrame];
//}


- (void)updateLifeWithLife:(int)life {
    
    // Convert life to width
    CGFloat newWidth = self.widthOfEachSegment * life;
    
    CGRect newFrame = CGRectMake(0, 0, newWidth, self.lifeBar.frame.size.height);

    [self animateLifeBarToFrame:newFrame];
}

- (void)updateScoreWithScore:(int)score {
    [self.scoreLabel setText:[@(score) stringValue]];
}

- (void)animateLifeBarToFrame:(CGRect)frame {
    POPBasicAnimation *increaseLifeAnimation = [POPBasicAnimation animation];
    increaseLifeAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
        increaseLifeAnimation.duration = 0.3;
    
    
    increaseLifeAnimation.toValue = [NSValue valueWithCGRect:frame];
    
    [self.lifeBar pop_addAnimation:increaseLifeAnimation forKey:nil];
}

@end
