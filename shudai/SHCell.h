//
//  SHCell.h
//  shudai
//
//  Created by Miriam Castro on 16/12/13.
//  Copyright (c) 2013 Studio Apparte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgTweet;
@property (strong, nonatomic) IBOutlet UILabel *idTweet;
@property (strong, nonatomic) IBOutlet UILabel *textTweet;

@end
