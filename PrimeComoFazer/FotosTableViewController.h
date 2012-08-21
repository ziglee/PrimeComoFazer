//
//  FotosTableViewController.h
//  PrimeComoFazer
//
//  Created by Cassio Landim on 21/08/12.
//  Copyright (c) 2012 SmartFingers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tema.h"

@interface FotosTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) Tema *tema;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
