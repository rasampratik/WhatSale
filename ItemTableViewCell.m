//
//  ItemTableViewCell.m
//  InventoryTrack
//
//  Created by hsk5260 on 10/18/12.
//  Copyright (c) 2012 hsk5260. All rights reserved.
//

#import "ItemTableViewCell.h"

@implementation ItemTableViewCell
@synthesize itemCostLabel = _itemCostLabel;
@synthesize itemNameLabel = _itemNameLabel;
@synthesize itemImageView = _itemImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
