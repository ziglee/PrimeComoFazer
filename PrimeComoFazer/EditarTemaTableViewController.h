//
//  EditarTemaTableViewController.h
//  PrimeComoFazer
//
//  Created by Cassio Landim on 17/08/12.
//  Copyright (c) 2012 SmartFingers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tema.h"

@interface EditarTemaTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *tituloTextField;

@property (strong, nonatomic) Tema *tema;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
