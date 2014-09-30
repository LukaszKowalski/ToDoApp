

#import "FriendsTableViewCell.h"

@implementation FriendsTableViewCell;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.newestFriend = [[UILabel alloc] init];
        self.newestFriend.frame = CGRectMake(0, 0, 300, 70);
        self.newestFriend.textAlignment = NSTextAlignmentCenter;
        self.newestFriend.textColor = [UIColor whiteColor];
        self.newestFriend.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
        [self.contentView addSubview:self.newestFriend];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
