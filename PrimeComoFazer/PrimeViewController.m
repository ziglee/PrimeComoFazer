//
//  PrimeViewController.m
//  PrimeComoFazer
//
//  Created by Cassio Landim on 17/08/12.
//  Copyright (c) 2012 SmartFingers. All rights reserved.
//

#import "PrimeViewController.h"
#import "EditarTemasTableViewController.h"
#import "Tema.h"

@interface PrimeViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation PrimeViewController

@synthesize managedObjectContext = __managedObjectContext;
@synthesize fetchedResultsController = __fetchedResultsController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *configurarButton = [[UIBarButtonItem alloc] initWithTitle:@"Configurar" style:UIBarButtonItemStyleBordered target:self action:@selector(configurar)];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:configurarButton, nil];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - Table view delegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Tema *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    //ObraDetalheViewController *detalheObra = [self.storyboard instantiateViewControllerWithIdentifier:@"ObraDetalhe"];
    //detalheObra.managedObjectContext = self.managedObjectContext;
    //detalheObra.detailItem = selectedObject;
    
    //[self.navigationController pushViewController:detalheObra animated:YES];
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil) {
        return __fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tema" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"titulo" ascending:YES];
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

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Tema *tema = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = tema.titulo;
}

#pragma mark -

- (void)configurar
{
    EditarTemasTableViewController *newController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditarTemas"];
    newController.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:newController animated:YES];
}

@end
