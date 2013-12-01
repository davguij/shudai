//
//  SHViewController.h
//  shudai
//
//  Created by Miriam Castro on 01/12/13.
//  Copyright (c) 2013 Studio Apparte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    //Variables
    IBOutlet UITableView *tablaSugerencias;
}

@property (readonly,nonatomic) NSMutableArray *listaSugerencias;
@property (nonatomic, retain) UITableView *tablaSugerencias;



@end
