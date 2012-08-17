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
@synthesize certoErradoControl;
@synthesize managedObjectContext = __managedObjectContext;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = [NSString stringWithFormat:@"Tirar Foto - %@", self.tema.titulo];
    
    if (self.foto != nil) {
        self.tituloField.text = self.foto.titulo;
        self.legendaField.text = self.foto.legenda;
        self.imageView.image = self.foto.imagem;
        self.certoErradoControl.selectedSegmentIndex = self.foto.correto.intValue ? 0 : 1;
    }
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
        
        if (self.foto == nil)
            self.foto = [NSEntityDescription insertNewObjectForEntityForName:@"Foto" inManagedObjectContext: self.managedObjectContext];
        
        self.foto.titulo = self.tituloField.text;
        self.foto.legenda = self.legendaField.text;
        self.foto.imagem = imageView.image;
        self.foto.tema = self.tema;
        self.foto.correto = [NSNumber numberWithInt: (self.certoErradoControl.selectedSegmentIndex == 0 ? 1 : 0)];
                
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
