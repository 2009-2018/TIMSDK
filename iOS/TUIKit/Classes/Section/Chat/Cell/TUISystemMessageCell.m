#import "TUISystemMessageCell.h"
#import "THeader.h"
#import "MMLayout/UIView+MMLayout.h"


@interface TUISystemMessageCell ()
@property (nonatomic, strong) UILabel *messageLabel;
@property TUISystemMessageCellData *systemData;
@end

@implementation TUISystemMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont systemFontOfSize:12];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.numberOfLines = 0;
        _messageLabel.backgroundColor = TSystemMessageCell_Background_Color;
        _messageLabel.layer.cornerRadius = 3;
        [_messageLabel.layer setMasksToBounds:YES];
        [self.container addSubview:_messageLabel];
    }
    return self;
}

- (void)fillWithData:(TUISystemMessageCellData *)data;
{
    [super fillWithData:data];
    self.systemData = data;
    //set data
    self.messageLabel.text = data.content;
    self.nameLabel.hidden = YES;
    self.avatarView.hidden = YES;
    self.retryView.hidden = YES;
    [self.indicator stopAnimating];
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.container.mm_center();
    self.messageLabel.mm_fill();
}

@end
