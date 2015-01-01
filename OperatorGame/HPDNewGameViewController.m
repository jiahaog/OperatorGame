//
//  HPDNewGameViewController.m
//  OperatorGame
//
//  Created by Goh Jia Hao on 31/12/14.
//  Copyright (c) 2014 Hippo Design. All rights reserved.
//

#import "HPDNewGameViewController.h"
#import "HPDGameScreenViewController.h"
#import <BFPaperButton.h>
#import <UIColor+BFPaperColors.h>
#import "HPDLifeBarView.h"


@interface HPDNewGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *previousGameStatusTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *previousGameScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;


@property (nonatomic) BFPaperButton *theNewGameButton;

@property (nonatomic) HPDLifeBarView *lifeBar;

@property (nonatomic) int highScore;

@end

@implementation HPDNewGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.previousGameStatusTextLabel.text = @"";
    // Do any additional setup after loading the view.
    if (!self.theNewGameButton) {
        [self createNewGameButton];
    }
    
    self.highScore = 10;
    [self updateHighScoreLabel];
    

}

//// for testing
//- (void)initLifeBar {
//    if (!self.lifeBar) {
//        CGRect lifeBarFrame = CGRectMake(0, 50, self.view.frame.size.width, 60);
////        CGRect lifeBarFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//        self.lifeBar = [[HPDLifeBarView alloc] initWithFrame:lifeBarFrame];
//        [self.view addSubview:self.lifeBar];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)createNewGameButton {
    CGRect bottomBarFrame = CGRectMake(0, self.view.frame.size.height*2/3, self.view.frame.size.width, self.view.frame.size.height/3);
    self.theNewGameButton = [[BFPaperButton alloc] initWithFrame:bottomBarFrame raised:YES];
    self.theNewGameButton.backgroundColor = [UIColor paperColorPurple];
    [self.theNewGameButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.theNewGameButton setTitleFont:[UIFont systemFontOfSize:70]];
    [self.theNewGameButton addTarget:self action:@selector(startNewGameInstance) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.self.theNewGameButton];

}

- (void)startNewGameInstance {
//    [[UIStoryboard storyboardWithName:@"mainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"gameScreenStoryboardID"];
    [self performSegueWithIdentifier:@"gameScreenSegue" sender:self];
    
}

- (void)checkAndUpdateHighScoreWithScore:(int)score {
    if (score > self.highScore) {
        self.highScore = score;
        [self updateHighScoreLabel];
    }
}

- (void)updateHighScoreLabel {
    NSString *highScoreString = [NSString stringWithFormat:@"High Score: %d", self.highScore];
    self.highScoreLabel.text = highScoreString;
}
- (void)setPreviousGameStatusText:(NSString *)text {
    self.previousGameStatusTextLabel.text = text;
}

- (void)setPreviousGameScoreText:(NSString *)scoreText {
    self.previousGameScoreLabel.text = scoreText;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    HPDGameScreenViewController *gameInstanceVC = (HPDGameScreenViewController *)segue.destinationViewController;
    gameInstanceVC.firstScreenVC = self;
    [super prepareForSegue:segue sender:sender];
}

//#pragma mark - NSCoding Methods
//
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeInt:self.highScore forKey:@"highScore"];
//}
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super init];
//    if (self) {
//        self.highScore = [aDecoder decodeIntForKey:@"highScore"];
//    }
//    return self;
//}

@end
