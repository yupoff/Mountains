//
//  CollectionTableViewCell.m
//  Mountains
//
//  Created by Тимур Аюпов on 10.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "CollectionTableViewCell.h"

@interface CollectionTableViewCell () < UIScrollViewDelegate, UICollectionViewDelegate >
{
    NSArray *pageImages;
    NSArray *pageSections;
    NSMutableArray *pageViews;
    NSInteger selectedPage;
}
@end

@implementation CollectionTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    pageImages = @[ [UIImage imageNamed:@"TestImage"],
                    [UIImage imageNamed:@"TestImage"],
                    [UIImage imageNamed:@"TestImage"] ];
    self.scrollView.delegate = self;
    selectedPage = -1;

    NSInteger pageCount = pageImages.count;

    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = pageCount;

    pageViews = [NSMutableArray array];
    for (int i = 0; i < pageCount; ++i)
    {
        [pageViews addObject:[NSNull null]];
    }

    CGSize pagesScrollViewSize = self.scrollView.frame.size;
    self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * pageImages.count, pagesScrollViewSize.height);

    [self loadVisiblePages];
}

- (void)loadVisiblePages
{
    // First, determine which page is currently visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));

    if (selectedPage != page)
    {
        selectedPage = page;
    }
    // Update the page control
    self.pageControl.currentPage = page;

    // Work out which pages we want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;

    // Purge anything before the first page
    for (NSInteger i = 0; i < firstPage; i++)
    {
        [self purgePage:i];
    }
    for (NSInteger i = firstPage; i <= lastPage; i++)
    {
        [self loadPage:i];
    }
    //    for (NSInteger i=lastPage+1; i < pageImages.count; i++) {
    //        [self purgePage:i];
    //    }
}

- (void)loadPage:(NSInteger)page
{
    if (page < 0 || page >= pageImages.count)
    {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }

    // Load an individual page, first seeing if we've already loaded it
    UIView *pageView = [pageViews objectAtIndex:page];
    if ((NSNull *)pageView == [NSNull null])
    {
        CGRect frame = self.scrollView.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        frame = CGRectInset(frame, 0.0f, 0.0f);

        UIImageView *newPageView = [[UIImageView alloc] initWithImage:[pageImages objectAtIndex:page]];
        newPageView.contentMode = UIViewContentModeScaleAspectFill;
        newPageView.frame = frame;
        [self.scrollView addSubview:newPageView];
        [pageViews replaceObjectAtIndex:page withObject:newPageView];
    }
}

- (void)purgePage:(NSInteger)page
{
    if (page < 0 || page >= pageImages.count)
    {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }

    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [pageViews objectAtIndex:page];
    if ((NSNull *)pageView != [NSNull null])
    {
        [pageView removeFromSuperview];
        [pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Load the pages which are now on screen
    [self loadVisiblePages];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
