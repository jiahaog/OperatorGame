//
//  HPDNewGameViewController.m
//  OperatorGame
//
//  Created by Goh Jia Hao on 31/12/14.
//  Copyright (c) 2014 Hippo Design. All rights reserved.
//

#import "HPDNewGameViewController.h"
#import "HPDGameScreenViewController.h"

@interface HPDNewGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *previousGameStatusTextLabel;

@end

@implementation HPDNewGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.previousGameStatusTextLabel.text = @"";
    // Do any additional setup after loading the view.
    
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

- (void)setPreviousGameStatusText:(NSString *)text {
    self.previousGameStatusTextLabel.text = text;

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    HPDGameScreenViewController *gameInstanceVC = (HPDGameScreenViewController *)segue.destinationViewController;
    gameInstanceVC.firstScreenVC = self;
    [super prepareForSegue:segue sender:sender];
}

@end
