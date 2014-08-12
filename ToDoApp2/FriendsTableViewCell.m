

#import "FriendsTableViewCell.h"

@implementation FriendsTableViewCell;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.newestFriend = [[UILabel alloc] init];
        self.newestFriend.frame = CGRectMake(0, 0, 320, 78);
        self.newestFriend.backgroundColor = [self randomColor];
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
-( UIColor *)randomColor{
    CGFloat red = arc4random() % 255 / 255.0;
    CGFloat blue = arc4random() % 255 / 255.0;
    CGFloat green = arc4random() % 255 / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
