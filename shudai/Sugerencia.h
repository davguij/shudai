//
//  Sugerencia.h
//  shudai
//
//  Created by Miriam Castro on 30/11/13.
//  Copyright (c) 2013 Studio Apparte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sugerencia : NSObject{
    
}

@property (readonly, nonatomic) int idSugerencia;
@property (readwrite, nonatomic) NSString *nombreSugerencia;
@property (readwrite, nonatomic) NSMutableArray *comentariosSugerencia;
@property (readonly, nonatomic) int valoracionSugerencia;

-(id) initWithNombre:(NSString *)nombre
        stringComentarios:(NSMutableArray *)comentarios;

@end
