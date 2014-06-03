//
//  StandingsTableViewCell.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StandingsTableViewCell.h"

@implementation StandingsTableViewCell

@synthesize teamNameLabel = _teamNameLabel;
@synthesize matchesLabel = _matchesLabel;
@synthesize winsLabel = _winsLabel;
@synthesize lossesLabel = _lossesLabel;
@synthesize pointsLabel = _pointsLabel;
@synthesize netRunRateLabel = _netRunRateLabel;
@synthesize tiesLabel = _tiesLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) formatBold {
    
    self.teamNameLabel.text = [NSString stringWithFormat:@"Team"];
    self.matchesLabel.text = [NSString stringWithFormat:@"M"];
    self.winsLabel.text = [NSString stringWithFormat:@"W"];
    self.lossesLabel.text = [NSString stringWithFormat:@"L"];
    self.tiesLabel.text = [NSString stringWithFormat:@"T"];
    self.pointsLabel.text = [NSString stringWithFormat:@"Pts"];
    self.netRunRateLabel.text = [NSString stringWithFormat:@"NRR"];
    
    self.teamNameLabel.font = [UIFont boldSystemFontOfSize:self.teamNameLabel.font.pointSize];
    self.matchesLabel.font = [UIFont boldSystemFontOfSize:self.matchesLabel.font.pointSize];
    self.winsLabel.font = [UIFont boldSystemFontOfSize:self.winsLabel.font.pointSize];
    self.lossesLabel.font = [UIFont boldSystemFontOfSize:self.lossesLabel.font.pointSize];
    self.tiesLabel.font = [UIFont boldSystemFontOfSize:self.tiesLabel.font.pointSize];
    self.pointsLabel.font = [UIFont boldSystemFontOfSize:self.pointsLabel.font.pointSize];
    self.netRunRateLabel.font = [UIFont boldSystemFontOfSize:self.netRunRateLabel.font.pointSize];
}

- (void) formatNormal {
    self.teamNameLabel.font = [UIFont systemFontOfSize:self.teamNameLabel.font.pointSize];
    self.matchesLabel.font = [UIFont systemFontOfSize:self.matchesLabel.font.pointSize];
    self.winsLabel.font = [UIFont systemFontOfSize:self.winsLabel.font.pointSize];
    self.lossesLabel.font = [UIFont systemFontOfSize:self.lossesLabel.font.pointSize];
    self.tiesLabel.font = [UIFont systemFontOfSize:self.tiesLabel.font.pointSize];
    self.pointsLabel.font = [UIFont systemFontOfSize:self.pointsLabel.font.pointSize];
    self.netRunRateLabel.font = [UIFont systemFontOfSize:self.netRunRateLabel.font.pointSize];
}

- (void) renderCell:(id)cell withData:(id)data atIndexPath:(NSIndexPath *)indexPath {
    if(data && [data isKindOfClass:[Seed class]] && indexPath.row != 0){
        Seed *seed = data;
        
//        self.teamNameLabel.text = [NSString stringWithFormat:@"%i. %@", indexPath.row, seed.tournamentTeam.team.teamName];
        self.teamNameLabel.text = [NSString stringWithFormat:@"%i. %@, Seed: %@", indexPath.row, seed.tournamentTeam.team.teamShortName, seed.seedNumber];
        self.matchesLabel.text = [NSString stringWithFormat:@"%i", [seed numberOfMatchesPlayed]];
        self.winsLabel.text = [NSString stringWithFormat:@"%i", [seed numberOfWins]];
        self.lossesLabel.text = [NSString stringWithFormat:@"%i", [seed numberOfLosses]];
        self.tiesLabel.text = [NSString stringWithFormat:@"%i", [seed numberOfTies]];
        self.pointsLabel.text = [NSString stringWithFormat:@"%i", [seed numberOfPoints]];
        self.netRunRateLabel.text = [NSString stringWithFormat:@"%0.3f", [seed netRunRate]];
        [self formatNormal];
    }else{
        [self formatBold];
    }
    
}

@end
