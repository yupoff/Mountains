//
//  PostDetailTableViewController.m
//  Mountains
//
//  Created by Тимур Аюпов on 04.06.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "Post.h"
#import "PostDetailTableViewController.h"
#import "PostTableViewCell.h"
#import "SendCommentTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@import Firebase;

static const int kSectionSend = 2;
static const int kSectionComments = 1;
static const int kSectionPost = 0;

@interface PostDetailTableViewController ()
@property (strong, nonatomic) NSMutableArray< FIRDataSnapshot * > *comments;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *detailLabel;
@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) FIRDatabaseReference *postRef;
@property (strong, nonatomic) FIRDatabaseReference *commentsRef;

@end

@implementation PostDetailTableViewController

FIRDatabaseHandle _refHandle;

- (void)viewDidLoad
{
    [super viewDidLoad];
    FIRDatabaseReference *ref = [FIRDatabase database].reference;
    self.postRef = [[ref child:@"posts"] child:_postKey];
    self.commentsRef = [[ref child:@"post-comments"] child:_postKey];
    self.comments = [[NSMutableArray alloc] init];
    self.post = [[Post alloc] init];

    UINib *postNib = [UINib nibWithNibName:@"PostTableViewCell" bundle:nil];
    UINib *commentNib = [UINib nibWithNibName:@"CommentTableViewCell" bundle:nil];
    UINib *sendCommentNib = [UINib nibWithNibName:@"SendCommentTableViewCell" bundle:nil];
    [self.tableView registerNib:postNib forCellReuseIdentifier:@"PostTableViewCell"];
    [self.tableView registerNib:commentNib forCellReuseIdentifier:@"CommentTableViewCell"];
    [self.tableView registerNib:sendCommentNib forCellReuseIdentifier:@"SendCommentTableViewCell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setEstimatedRowHeight:150.0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.comments removeAllObjects];
    // [START child_event_listener]
    // Listen for new comments in the Firebase database
    [_commentsRef
        observeEventType:FIRDataEventTypeChildAdded
               withBlock:^(FIRDataSnapshot *snapshot) {
                 [self.comments addObject:snapshot];
                 [self.tableView insertRowsAtIndexPaths:@[
                     [NSIndexPath indexPathForRow:[self.comments count] - 1 inSection:1]
                 ]
                                       withRowAnimation:UITableViewRowAnimationAutomatic];
               }];
    // Listen for deleted comments in the Firebase database
    [_commentsRef
        observeEventType:FIRDataEventTypeChildRemoved
               withBlock:^(FIRDataSnapshot *snapshot) {
                 int index = [self indexOfMessage:snapshot];
                 [self.comments removeObjectAtIndex:index];
                 [self.tableView deleteRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:index inSection:1] ]
                                       withRowAnimation:UITableViewRowAnimationAutomatic];
               }];
    // [END child_event_listener]

    // [START post_value_event_listener]
    _refHandle = [_postRef observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *_Nonnull snapshot) {
      NSDictionary *postDict = snapshot.value;
      // [START_EXCLUDE]
      [_post setValuesForKeysWithDictionary:postDict];
      [self.tableView reloadData];
      self.navigationItem.title = _post.title;
      // [END_EXCLUDE]
    }];
    // [END post_value_event_listener]
}

- (int)indexOfMessage:(FIRDataSnapshot *)snapshot
{
    int index = 0;
    for (FIRDataSnapshot *comment in _comments)
    {
        if ([snapshot.key isEqualToString:comment.key])
        {
            return index;
        }
        ++index;
    }
    return -1;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [self.postRef removeObserverWithHandle:_refHandle];
    [self.commentsRef removeAllObservers];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == kSectionPost || section == kSectionSend)
    {
        return 1;
    }
    else if (section == kSectionComments)
    {
        return [_comments count];
    }
    NSAssert(NO, @"Unexpected section");
    return 0;
}

- (void)didTapSend:(NSString *)commentText
{
    NSString *uid = [FIRAuth auth].currentUser.uid;
    [[[[FIRDatabase database].reference child:@"users"] child:uid]
        observeSingleEventOfType:FIRDataEventTypeValue
                       withBlock:^(FIRDataSnapshot *_Nonnull snapshot) {
                         NSDictionary *user = snapshot.value;
                         NSString *username = user[@"username"];
                         NSDictionary *comment = @{ @"uid" : uid,
                                                    @"author" : username,
                                                    @"text" : commentText };
                         [[_commentsRef childByAutoId] setValue:comment];
                       }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == kSectionPost)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"PostTableViewCell"];
        PostTableViewCell *postcell = (PostTableViewCell *)cell;
        postcell.authorLabel.text = _post.author;
        postcell.postTitle.text = _post.title;
        postcell.postBody.text = _post.body;
        [postcell.photoView sd_setImageWithURL:[NSURL URLWithString:_post.photoUrl]];
        NSString *imageName = [_post.stars objectForKey:[self getUid]] ? @"ic_star" : @"ic_star_border";
        [postcell.starButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        postcell.numStarsLabel.text = [NSString stringWithFormat:@"%d", _post.starCount];
        postcell.postKey = _postKey;
    }
    else if (indexPath.section == kSectionComments)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell"];
        CommentTableViewCell *commentCell = (CommentTableViewCell *)cell;
        NSDictionary *comment = _comments[indexPath.row].value;
        commentCell.authorLabel.text = comment[@"author"];
        commentCell.commentTextLabel.text = comment[@"text"];
    }
    else if (indexPath.section == kSectionSend)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SendCommentTableViewCell"];
        SendCommentTableViewCell *sendCommentCell = (SendCommentTableViewCell *)cell;
        sendCommentCell.output = self;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (NSString *)getUid
{
    return [FIRAuth auth].currentUser.uid;
}

@end
