//
//  EditarTemaTableViewController.m
//  PrimeComoFazer
//
//  Created by Cassio Landim on 17/08/12.
//  Copyright (c) 2012 SmartFingers. All rights reserved.
//

#import "EditarTemaTableViewController.h"
#import "UIImagePickerViewController.h"
#import "Foto.h"

@interface EditarTemaTableViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation EditarTemaTableViewController

@synthesize tema = _tema;
@synthesize tituloTextField = _tituloTextField;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize fetchedResultsController = __fetchedResultsController;

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(novaFoto:)];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:addButton, self.editButtonItem, nil];
    
    self.navigationController.title = self.tema.titulo;
    self.tituloTextField.text = self.tema.titulo;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tema.titulo = self.tituloTextField.text;
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Erro ao salvar obra." delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles:nil];
        [alert show];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationPortrait == interfaceOrientation;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Fotos";
}

#pragma mark - Table view delegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSUInteger fromIndex = fromIndexPath.row;
    NSUInteger toIndex = toIndexPath.row;
    
    if (fromIndex == toIndex) {
        return;
    }
    
    Foto *affectedObject = [self.fetchedResultsController.fetchedObjects objectAtIndex:fromIndex];
    affectedObject.posicao = [NSNumber numberWithInteger:toIndex];
    
    NSUInteger start, end;
    int delta;
    
    if (fromIndex < toIndex) {
        // move was down, need to shift up
        delta = -1;
        start = fromIndex + 1;
        end = toIndex;
    } else { // fromIndex > toIndex
        // move was up, need to shift down
        delta = 1;
        start = toIndex;
        end = fromIndex - 1;
    }
    
    for (NSUInteger i = start; i <= end; i++) {
        Foto *otherObject = [self.fetchedResultsController.fetchedObjects objectAtIndex:i];
        otherObject.posicao = [NSNumber numberWithInteger:delta + otherObject.posicao.intValue];
    }
    
    NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Foto *foto = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UIImagePickerViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TirarFoto"];
    controller.managedObjectContext = self.managedObjectContext;
    controller.foto = foto;
    controller.tema = self.tema;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Foto *foto = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = foto.titulo;
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil) {
        return __fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Foto" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tema == %@", self.tema];
    [fetchRequest setPredicate:predicate];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"posicao" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

#pragma mark -

- (void)novaFoto:(id)sender
{
    UIImagePickerViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TirarFoto"];
    controller.managedObjectContext = self.managedObjectContext;
    controller.tema = self.tema;
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
