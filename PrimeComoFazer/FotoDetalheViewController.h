//
//  FotoDetalheViewController.h
//  PrimeComoFazer
//
//  Created by Cassio Landim on 21/08/12.
//  Copyright (c) 2012 SmartFingers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Foto.h"

@interface FotoDetalheViewController : UIViewController

@property (strong, nonatomic) Foto *foto;

@property (nonatomic, weak) IBOutlet UIImageView *imagemView;

@end
