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

@interface HPDNewGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *previousGameStatusTextLabel;

@property (nonatomic) BFPaperButton *theNewGameButton;

@end

@implementation HPDNewGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.previousGameStatusTextLabel.text = @"";
    // Do any additional setup after loading the view.
    if (!self.theNewGameButton) {
        [self createNewGameButton];
    }
}

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
    self.theNewGameButton.backgroundColor = [UIColor paperColorGray];
    [self.theNewGameButton setTitle:@"New Game" forState:UIControlStateNormal];
    [self.theNewGameButton addTarget:self action:@selector(startNewGameInstance) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.self.theNewGameButton];
    
    
}

- (void)startNewGameInstance {
//    [[UIStoryboard storyboardWithName:@"mainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"gameScreenStoryboardID"];
    [self performSegueWithIdentifier:@"gameScreenSegue" sender:self];
    
}

- (void)setPreviousGameStatusText:(NSString *)text {
    self.previousGameStatusTextLabel.text = text;

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    HPDGameScreenViewController *gameInstanceVC = (HPDGameScreenViewController *)segue.destinationViewController;
    gameInstanceVC.firstScreenVC = self;
    [super prepareForSegue:segue sender:sender];
}

@end
