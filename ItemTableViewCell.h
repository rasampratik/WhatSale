//
//  ItemTableViewCell.h
//  InventoryTrack
//
//  Created by hsk5260 on 10/18/12.
//  Copyright (c) 2012 hsk5260. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;

@end
