//
//  Tema.m
//  PrimeComoFazer
//
//  Created by Cassio Landim on 17/08/12.
//  Copyright (c) 2012 SmartFingers. All rights reserved.
//

#import "Tema.h"
#import "Foto.h"
#import "UIImageToDataTransformer.h"

@implementation Tema

@dynamic titulo;
@dynamic fotos;

+ (void)initialize {
    if (self == [Tema class]) {
        UIImageToDataTransformer *transformer = [[UIImageToDataTransformer alloc] init];
        [NSValueTransformer setValueTransformer:transformer forName:@"UIImageToDataTransformer"];
    }
}

@end
