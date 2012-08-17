//
//  UIImagePickerViewController.h
//  PrimeComoFazer
//
//  Created by Cassio Landim on 17/08/12.
//  Copyright (c) 2012 SmartFingers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tema.h"

@interface UIImagePickerViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tituloField;
@property (weak, nonatomic) IBOutlet UITextField *legendaField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) Tema *tema;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)takePicture:(id)sender;
- (IBAction)savePhoto:(id)sender;
- (IBAction)discardPhoto:(id)sender;

@end
