//
//  ChanceCricketViewController.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MatchViewController.h"

@interface MatchViewController()

@property (nonatomic, strong) MatchEngine *matchEngine;
@property (nonatomic, strong) DieEngine *dieEngine;

- (void) onMatchEngineUpdate:(NSNotification *)notification;
- (void) updateScoreboard;

@end

@implementation MatchViewController

@synthesize runRateLabel = _runRateLabel;
@synthesize commentaryViewController = _commentaryViewController;
@synthesize pickerView = _pickerView;
@synthesize scoreboardTableViewController = _scoreboardTableViewController;
@synthesize dieLabel = _dieLabel;
@synthesize scoreLabel = _scoreLabel;
@synthesize oversLabel = _oversLabel;
@synthesize historyLabel = _historyLabel;
@synthesize matchEngine = _matchEngine;
@synthesize dieEngine = _dieEngine;
@synthesize matchID = _matchID;
@synthesize delegate = _delegate;

#define MATCH_ID @"123"

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if(self.matchEngine.currentMatch && !self.scoreboardTableViewController.isActive) [self.scoreboardTableViewController update];
    
    [self.commentaryViewController setIsActive:YES];
}


- (NSString *) matchID {
    if(!_matchID) _matchID = MATCH_ID;
    return _matchID;
}

- (void) setMatchID:(NSString *)matchID {
    _matchID = matchID;
    
    if(![self.view.subviews containsObject:self.scoreboardTableViewController.view]) [self.view addSubview:self.scoreboardTableViewController.view];
    [self.scoreboardTableViewController setDelegate:self];
    [self.matchEngine openMatch:_matchID inDocument:[self.delegate getFilenameWhereMatchExistsMatchVC:self]];
}

- (Inning *) inningForScoreboardTableView {
    return self.matchEngine.currentInning;
}

- (void) setInitialDieState {
    
//    NSLog(@"setInitialDieState - metaData: %@", self.matchEngine.currentMatch.metadata);
    NSDictionary *metaData = self.matchEngine.currentMatch.metadata;
    [self.dieEngine dieStateSetRollMode:[metaData valueForKey:DIE_ENGINE_CURRENT_ROLL_MODE] andLastRolledNumber:[metaData valueForKey:DIE_ENGINE_LAST_ROLLED_NUMBER]];
    
}

- (void) addDieStateToMetaData {
       
//    NSLog(@"Metadata exists: %@", self.matchEngine.currentMatch.metadata ? @"YES" : @"NO");
    // always see if it exists and create a copy of it 
    NSMutableDictionary *metaData = self.matchEngine.currentMatch.metadata ? [self.matchEngine.currentMatch.metadata mutableCopy] : [[NSMutableDictionary alloc] init];
    [metaData setValue:[NSNumber numberWithInt:self.dieEngine.rolledNumber] forKey:DIE_ENGINE_LAST_ROLLED_NUMBER];
    [metaData setValue:[NSNumber numberWithInt:self.dieEngine.rollMode] forKey:DIE_ENGINE_CURRENT_ROLL_MODE];
    self.matchEngine.currentMatch.metadata = [metaData copy];
    [self.matchEngine saveMatch];

//    NSLog(@"addDieStateToMetaData AFTER TRANSFORMATION - object: %@", self.matchEngine.currentMatch.metadata);
}

- (void)dieEngineDidRollWicketChance {
    [self.commentaryViewController showWicketChanceText];
    [self addDieStateToMetaData];
}

- (void)dieEngineDidRollBoundaryChance {
    [self.commentaryViewController showBoundaryChanceText];
    [self addDieStateToMetaData];
}

- (void)dieEngineDidRollDot {
    [self.matchEngine addDelivery];
    [self.commentaryViewController showDotText:self.matchEngine.currentDelivery];
}

- (void)dieEngineDidRollRuns:(int)runs {
    [self.matchEngine addDeliveryWithRuns:runs];
    [self.commentaryViewController showRunsText:runs forDelivery:self.matchEngine.currentDelivery];
}

- (void)dieEngineDidRollWicket {
    [self.matchEngine addDeliveryWithWicket];
    [self.commentaryViewController showWicketText:self.matchEngine.currentDelivery];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {   
    return [self.matchEngine.currentInning eligibleBowlerSet].count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return ((Bowler *)[[self.matchEngine.currentInning eligibleBowlerSet] objectAtIndex:row]).bowlerName;
}

- (DieEngine *) dieEngine {
    if(!_dieEngine) {
        _dieEngine = [[DieEngine alloc] init];
        _dieEngine.delegate = self;
    }
    return _dieEngine;
}

- (MatchEngine *) matchEngine {    
    if(!_matchEngine){
        _matchEngine = [[MatchEngine alloc] init];
        _matchEngine.isAutoSave = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMatchEngineMatchOpened:) name:MATCH_ENGINE_MATCH_OPENED object:_matchEngine];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMatchEngineUpdate:) name:MATCH_ENGINE_UPDATE object:_matchEngine];
    }
    return _matchEngine;
}

- (void) setMatchEngine:(MatchEngine *)matchEngine {
    if(matchEngine == nil) [[NSNotificationCenter defaultCenter] removeObserver:self];
    _matchEngine = matchEngine;
}

- (void) onMatchEngineMatchOpened:(NSNotification *)notification {
    
    // USE THIS METHOD TO INITIALISE ANY CONTENT ONCE THE MATCH HAS BEEN OPENED
    // can set the commentary field and the state of the die 
    
    [self setInitialDieState];
    self.dieLabel.text = [NSString stringWithFormat:@"%i", self.dieEngine.rolledNumber];
    
    [self onMatchEngineUpdate:notification];
}

- (void) onMatchEngineUpdate:(NSNotification *)notification {
    
    
    [self.scoreboardTableViewController update];
    [self updateScoreboard];
    [self addDieStateToMetaData];
    
    if(self.matchEngine.currentMatch.state == MATCH_STATE_COMPLETED) [self.delegate matchVC:self didFinish:self.matchEngine.currentMatch];
}

- (void) updateScoreboard {
    
    NSString *formattedScore = [[NSString alloc] initWithFormat:@"%i / %i", self.matchEngine.currentInning.wickets.count, self.matchEngine.currentInning.inningRuns.intValue];
    NSString *overHistory = self.matchEngine.currentOver.overHistory;
    NSString *formattedOvers = [Over fullFormattedStringForOvers:self.matchEngine.currentInning.overs];
    NSString *formattedRunRate = [[NSString alloc] initWithFormat:@"%.02f", [self.matchEngine.currentMatch runRate:self.matchEngine.currentInning]];
    
    self.scoreLabel.text = formattedScore;
    self.oversLabel.text = formattedOvers;
    self.historyLabel.text = overHistory;
    self.runRateLabel.text = formattedRunRate;
    if(!self.dieEngine.rolledNumber) self.dieLabel.text = [NSString stringWithFormat:@"%i", self.matchEngine.currentDelivery.deliveryRuns.intValue];
}

- (void) closePickerView {
    
    Bowler *bowler = [[self.matchEngine.currentInning eligibleBowlerSet] objectAtIndex:[self.pickerView selectedRowInComponent:0]];
    self.matchEngine.currentInning.currentRestingBowler = bowler;
    
    if(self.navigationItem.rightBarButtonItem) self.navigationItem.rightBarButtonItem = nil;
    if(self.pickerView.superview) [self.pickerView removeFromSuperview];
    self.pickerView.delegate = nil;
    self.pickerView = nil;
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void) selectionMadeFrom:(UIBarButtonItem *)sender {
    [self closePickerView];
}

- (void) openPickerView {
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 216)];
    self.pickerView.delegate = self;
    self.pickerView.showsSelectionIndicator = YES;
    
    UIBarButtonItem *completeButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(selectionMadeFrom:)];
    self.navigationItem.rightBarButtonItem = completeButton;
    [self.pickerView selectedRowInComponent:0];
    [self.view addSubview:self.pickerView];
    
}

- (void) selectBowler:(MatchEngine *)sender {
    [self openPickerView];
}

- (IBAction)buttonBowlerSelect:(id)sender {
    [self openPickerView];
}

- (IBAction)resetGame:(id)sender {
    [self.matchEngine resetCurrentGame];
}

// The user has pressed or gestured a dieRoll
- (IBAction)rollDie {
    
    if(!self.matchEngine.delegate) self.matchEngine.delegate = self;
    if([self.matchEngine.currentMatch.state isEqualToString:MATCH_STATE_CREATED] || 
       [self.matchEngine.currentMatch.state isEqualToString:MATCH_STATE_SCHEDULED]) self.matchEngine.currentMatch.state = MATCH_STATE_IN_PROGRESS;
    
    if([self.matchEngine.currentMatch.state isEqualToString:MATCH_STATE_IN_PROGRESS]) [self.dieEngine rollDie];
    self.dieLabel.text = [NSString stringWithFormat:@"%i", self.dieEngine.rolledNumber];    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    // we'll segue to ANY view controller that has a photographer @property
    if ([segue.destinationViewController respondsToSelector:@selector(setMatch:)]) {
        // use performSelector:withObject: to send without compiler checking
        // (which is acceptable here because we used introspection to be sure this is okay)
        [segue.destinationViewController performSelector:@selector(setMatch:) withObject:self.matchEngine.currentMatch];
    }
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.matchEngine closeCurrentMatch];
    
    [self.commentaryViewController setIsActive:NO];
    
    NSLog(@"Match VC - View Will Disappear");
}

- (void)viewDidUnload {
    
    NSLog(@"Match VC - View Did Unload");
    
    [self setDieLabel:nil];
    [self setScoreLabel:nil];
    [self setRunRateLabel:nil];
    [self setOversLabel:nil];
    [self setHistoryLabel:nil];
    [self setRunRateLabel:nil];
    [self setPickerView:nil];
    [self setCommentaryViewController:nil];
    [self setScoreboardTableViewController:nil];

    [super viewDidUnload];    
}
@end
