//
//  FotosTableViewController.m
//  PrimeComoFazer
//
//  Created by Cassio Landim on 21/08/12.
//  Copyright (c) 2012 SmartFingers. All rights reserved.
//

#import "FotosTableViewController.h"
#import "FotoDetalheViewController.h"
#import "FotoCell.h"
#import "Foto.h"

@interface FotosTableViewController ()
- (void)configureCell:(FotoCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation FotosTableViewController

@synthesize tema = _tema;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize fetchedResultsController = __fetchedResultsController;

- (void)viewDidLoad
{
    [super viewDidLoad];    
    
    self.title = self.tema.titulo;    
    self.tableView.rowHeight = 300;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationPortrait == interfaceOrientation;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    FotoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Foto *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    FotoDetalheViewController *newController = [self.storyboard instantiateViewControllerWithIdentifier:@"FotoDetalhe"];
    newController.foto = selectedObject;
    
    [self.navigationController pushViewController:newController animated:YES];
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

#pragma mark -

- (void)configureCell:(FotoCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Foto *foto = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.tituloLabel.text = foto.titulo;
    cell.imagemView.image = foto.imagem;
    cell.legendaView.text = foto.legenda;
    cell.certoErradoImageView.image = foto.correto.intValue == 0 ? [UIImage imageNamed:@"right2.png"] : [UIImage imageNamed:@"wrong2.png"];
}

@end
