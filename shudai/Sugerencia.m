//
//  Sugerencia.m
//  shudai
//
//  Created by Miriam Castro on 30/11/13.
//  Copyright (c) 2013 Studio Apparte. All rights reserved.
//

#import "Sugerencia.h"

@implementation Sugerencia

@synthesize nombreSugerencia, valoracionSugerencia, idSugerencia, comentariosSugerencia;

-(id) init{
    
    return self;
}

-(id)initWithNombre:(NSString *)nombre stringComentarios:(NSMutableArray *)comentarios{
    
    nombreSugerencia = nombre;
    comentariosSugerencia = comentarios;
    
    return [self init];
}


@end
