//
//  UIImagePickerViewController.m
//  PrimeComoFazer
//
//  Created by Cassio Landim on 17/08/12.
//  Copyright (c) 2012 SmartFingers. All rights reserved.
//

#import "UIImagePickerViewController.h"
#import "Foto.h"

@interface UIImagePickerViewController ()

@end

@implementation UIImagePickerViewController

@synthesize tema;
@synthesize imageView;
@synthesize tituloField;
@synthesize legendaField;
@synthesize managedObjectContext = __managedObjectContext;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = [NSString stringWithFormat:@"Tirar Foto - %@", self.tema.titulo];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationPortrait == interfaceOrientation;
}

#pragma mark Image picker delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)selectedImage editingInfo:(NSDictionary *)editingInfo {
    [self.imageView setImage:selectedImage];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark Actions

- (IBAction)takePicture:(id) sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }
    
    [imagePicker setDelegate:self];
    
    [self presentModalViewController:imagePicker animated:YES];
}

- (IBAction)savePhoto:(id)sender {
    if (imageView.image != nil) {
        Foto *foto = [NSEntityDescription insertNewObjectForEntityForName:@"Foto" inManagedObjectContext: self.managedObjectContext];
        foto.titulo = self.tituloField.text;
        foto.legenda = self.legendaField.text;
        foto.imagem = imageView.image;
        foto.tema = self.tema;
                
        NSError *error = nil;
        if (![self.managedObjectContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)discardPhoto:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
