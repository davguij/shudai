//
//  SHCell.m
//  shudai
//
//  Created by Miriam Castro on 16/12/13.
//  Copyright (c) 2013 Studio Apparte. All rights reserved.
//

#import "SHCell.h"

@implementation SHCell
@synthesize idTweet, imageView, textTweet;

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

@end
