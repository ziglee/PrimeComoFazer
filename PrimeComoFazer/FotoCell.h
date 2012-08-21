//
//  FotoCell.h
//  PrimeComoFazer
//
//  Created by Cassio Landim on 21/08/12.
//  Copyright (c) 2012 SmartFingers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FotoCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *tituloLabel;
@property (nonatomic, weak) IBOutlet UITextView *legendaView;
@property (nonatomic, weak) IBOutlet UIImageView *imagemView;
@property (nonatomic, weak) IBOutlet UIImageView *certoErradoImageView;

@end
