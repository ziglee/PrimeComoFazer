//
//  FotoDetalheViewController.m
//  PrimeComoFazer
//
//  Created by Cassio Landim on 21/08/12.
//  Copyright (c) 2012 SmartFingers. All rights reserved.
//

#import "FotoDetalheViewController.h"

@interface FotoDetalheViewController ()

@end

@implementation FotoDetalheViewController

@synthesize foto = _foto;
@synthesize imagemView = _imagemView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.foto.titulo;
    self.imagemView.image = self.foto.imagem;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
