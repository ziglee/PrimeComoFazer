//
//  UIImageToDataTransformer.m
//  PrimeComoFazer
//
//  Created by Cassio Landim on 17/08/12.
//  Copyright (c) 2012 SmartFingers. All rights reserved.
//

#import "UIImageToDataTransformer.h"

@implementation UIImageToDataTransformer

+ (BOOL)allowsReverseTransformation {
	return YES;
}

+ (Class)transformedValueClass {
	return [NSData class];
}

- (id)transformedValue:(id)value {
	return UIImagePNGRepresentation(value);
}

- (id)reverseTransformedValue:(id)value {
	return [[UIImage alloc] initWithData:value];
}

@end
