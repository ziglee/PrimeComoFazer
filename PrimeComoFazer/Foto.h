//
//  Foto.h
//  PrimeComoFazer
//
//  Created by Cassio Landim on 17/08/12.
//  Copyright (c) 2012 SmartFingers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tema;

@interface Foto : NSManagedObject

@property (nonatomic, retain) id imagem;
@property (nonatomic, retain) NSString * legenda;
@property (nonatomic, retain) NSNumber * correto;
@property (nonatomic, retain) NSString * titulo;
@property (nonatomic, retain) NSNumber * posicao;
@property (nonatomic, retain) Tema *tema;

@end
