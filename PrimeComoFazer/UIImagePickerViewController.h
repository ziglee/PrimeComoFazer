//
//  UIImagePickerViewController.h
//  PrimeComoFazer
//
//  Created by Cassio Landim on 17/08/12.
//  Copyright (c) 2012 SmartFingers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tema.h"
#import "Foto.h"

@interface UIImagePickerViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *tituloField;
@property (strong, nonatomic) IBOutlet UITextField *legendaField;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *certoErradoControl;

@property (strong, nonatomic) Tema *tema;
@property (strong, nonatomic) Foto *foto;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)takePicture:(id)sender;
- (IBAction)savePhoto:(id)sender;
- (IBAction)discardPhoto:(id)sender;

@end
