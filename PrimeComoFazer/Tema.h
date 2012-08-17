//
//  Tema.h
//  PrimeComoFazer
//
//  Created by Cassio Landim on 17/08/12.
//  Copyright (c) 2012 SmartFingers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Foto;

@interface Tema : NSManagedObject

@property (nonatomic, retain) NSString * titulo;
@property (nonatomic, retain) NSOrderedSet *fotos;
@end

@interface Tema (CoreDataGeneratedAccessors)

- (void)insertObject:(Foto *)value inFotosAtIndex:(NSUInteger)idx;
- (void)removeObjectFromFotosAtIndex:(NSUInteger)idx;
- (void)insertFotos:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeFotosAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInFotosAtIndex:(NSUInteger)idx withObject:(Foto *)value;
- (void)replaceFotosAtIndexes:(NSIndexSet *)indexes withFotos:(NSArray *)values;
- (void)addFotosObject:(Foto *)value;
- (void)removeFotosObject:(Foto *)value;
- (void)addFotos:(NSOrderedSet *)values;
- (void)removeFotos:(NSOrderedSet *)values;
@end
