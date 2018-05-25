//
//  FactCell.m
//  ProficiencyExcercise
//
//  Created by Mac_Admin on 24/05/18.
//  Copyright © 2018 Rahul. All rights reserved.
//

#import "FactCell.h"

@implementation FactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if (self.lblFactTitle == nil) {
            self.lblFactTitle = [[UILabel alloc] init];
        }
        self.lblFactTitle.backgroundColor = [UIColor clearColor];
        self.lblFactTitle.textAlignment = NSTextAlignmentLeft;
        self.lblFactTitle.numberOfLines = 0;
        self.lblFactTitle.lineBreakMode = NSLineBreakByWordWrapping;
        self.lblFactTitle.font = [UIFont boldSystemFontOfSize:self.lblFactTitle.font.pointSize];
        self.lblFactTitle.textColor = [UIColor darkTextColor];
        
        if (self.lblFactDesc == nil) {
            self.lblFactDesc = [[UILabel alloc] init];
        }
        self.lblFactDesc.backgroundColor = [UIColor clearColor];
        self.lblFactDesc.numberOfLines = 0;
        self.lblFactDesc.lineBreakMode = NSLineBreakByWordWrapping;
        self.lblFactDesc.textAlignment = NSTextAlignmentLeft;
        self.lblFactDesc.textColor = [UIColor grayColor];
        
        if (self.imgFact == nil) {
            self.imgFact = [[UIImageView alloc] init];
        }
        self.imgFact.layer.cornerRadius = 8.0;
        self.imgFact.clipsToBounds = TRUE;
        
        [self.contentView addSubview:self.lblFactTitle];
        [self.contentView addSubview:self.lblFactDesc];
        [self.contentView addSubview:self.imgFact];
        
        [self addLayoutConstraints];
    }
    
    return self;
}

-(void)addLayoutConstraints {
    
    self.lblFactTitle.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.lblFactDesc.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.imgFact.translatesAutoresizingMaskIntoConstraints = FALSE;
    
    //Dictionary with all the controls need to be display on the cell
    NSDictionary *views = @{@"lblFactTitle": self.lblFactTitle,
                            @"lblFactDesc": self.lblFactDesc,
                            @"imgFact": self.imgFact
                            };
    
    //Add constraints for image and title view
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[imgFact]-10-[lblFactTitle]-10-|" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[imgFact]-10-[lblFactDesc]-10-|" options:0 metrics:nil views:views]];
    
    // Vertical layouts
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[imgFact]->=10@999-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[lblFactTitle]-[lblFactDesc]->=10-|" options:0 metrics:nil views:views]];
    
    [self.imgFact addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imgFact(75)]" options:0 metrics:nil views:views]];
    [self.imgFact addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imgFact(75)]" options:0 metrics:nil views:views]];
    
    //Auto resize the height of the title label
    [self.lblFactTitle setContentHuggingPriority:999 forAxis:UILayoutConstraintAxisVertical];
    
}

- (void)dealloc {
    self.lblFactTitle = nil;
    self.lblFactDesc = nil;
    self.imgFact = nil;
}
@end
