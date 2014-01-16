//
//  SHViewController.m
//  shudai
//
//  Created by Miriam Castro on 01/12/13.
//  Copyright (c) 2013 Studio Apparte. All rights reserved.
//

#import "SHViewController.h"
#import "Sugerencia.h"
#import "SH2ViewController.h"


@interface SHViewController ()

@end

@implementation SHViewController

@synthesize listaSugerencias, tablaSugerencias, txtBuscar, txtClicado;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    listaSugerencias = [[NSMutableArray alloc] init];
    
    //for (int i=0; i < 5; i++) {
        
       // NSString *sugTemporal = [[NSString alloc]initWithFormat:@"Sugerencia %d", i ];
        
        Sugerencia *miSugerencia = [[Sugerencia alloc] initWithNombre:@"Rajoy"
                                                    stringComentarios:NULL];
        Sugerencia *sugerenciaDOS =[[Sugerencia alloc] initWithNombre:@"Madrid"
                                                    stringComentarios:NULL];
        Sugerencia *sugerenciaTres = [[Sugerencia alloc] initWithNombre:@"Agosto"
                                                      stringComentarios:NULL];
        Sugerencia *sugerenciaCuatro = [[Sugerencia alloc] initWithNombre:@"Depeche_Mode"
                                                    stringComentarios:NULL];
        Sugerencia *sugerenciaCinco = [[Sugerencia alloc] initWithNombre:@"Rolling_Stones"
                                                    stringComentarios:NULL];
        Sugerencia *sugerenciaSeis = [[Sugerencia alloc] initWithNombre:@"LG"
                                                    stringComentarios:NULL];
        Sugerencia *sugerenciaSiete = [[Sugerencia alloc] initWithNombre:@"Tomates"
                                                    stringComentarios:NULL];
    
        [listaSugerencias addObject:miSugerencia];
        [listaSugerencias addObject:sugerenciaDOS];
        [listaSugerencias addObject:sugerenciaTres];
        [listaSugerencias addObject:sugerenciaCuatro];
        [listaSugerencias addObject:sugerenciaCinco];
        [listaSugerencias addObject:sugerenciaSeis];
        [listaSugerencias addObject:sugerenciaSiete];
    
        
    //}
}


- (IBAction)btnBuscar:(id)sender {
    
    //NSString *campoTexto = [txtBuscar text];
    //NSLog(@"%@", campoTexto);
    
    //[self performSegueWithIdentifier:@"segundaVista" sender:campoTexto];
    
    
    
    
}

- (IBAction)cerrarTeclado:(id)sender {
    
    [sender resignFirstResponder]; //cerrar teclado
}






#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [listaSugerencias count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Sugerencia *sugerenciaActual = [ listaSugerencias objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [sugerenciaActual nombreSugerencia];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    Sugerencia *sugerenciaClicada = [listaSugerencias objectAtIndex:indexPath.row];
    
    //txtBuscar.text = [sugerenciaClicada nombreSugerencia];
    
    
    txtClicado = [sugerenciaClicada nombreSugerencia];
    
   
    
    [self performSegueWithIdentifier:@"segundaVista" sender:self.txtClicado];
    

}





#pragma mark - Navigation
 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segundaVista"])
    {
        NSString *texto = txtBuscar.text;
        
        
        if ([texto isEqualToString:@""]) {
            SH2ViewController *viewController = segue.destinationViewController;
            viewController.campo2Texto = self.txtClicado;
            NSLog(@"%@", self.txtClicado);
            
        }else{
            SH2ViewController *viewController = segue.destinationViewController;
            viewController.campo2Texto = texto;
        }
//        NSLog(@"Funciona!");
//        NSLog(@"%@", self.txtClicado);
        
    }
 
 
}
 



@end
