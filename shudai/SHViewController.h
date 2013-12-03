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
@property (strong, nonatomic) IBOutlet UITextField *txtBuscar;
- (IBAction)btnBuscar:(id)sender;
- (IBAction)cerrarTeclado:(id)sender;

- (void)llamadaTwitter:(NSString *)busqueda;


@end
