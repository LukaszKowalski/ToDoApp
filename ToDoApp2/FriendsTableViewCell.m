

#import "FriendsTableViewCell.h"

@implementation FriendsTableViewCell;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.newestFriend = [[UILabel alloc] init];
        self.newestFriend.frame = CGRectMake(0, 0, 320, 78);
        self.newestFriend.textAlignment = NSTextAlignmentCenter;
    
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

- (void)friendIsTapped{
//    ToDoViewController *controller = [[ToDoViewController alloc] init];
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
}

@end
