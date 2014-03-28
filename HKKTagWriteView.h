//
//  HKKTagWriteView.h
//  TagWriteViewTest
//
//  Created by kyokook on 2014. 1. 11..
//  Copyright (c) 2014 rhlab. All rights reserved.
//
/*
 本人修改了一下,每当点击完成按钮的时候当前输入的tag生成btntag,不会再自动生成新的btntag(也就是跟textview的效果一样) 感觉原生的效果需求不大,仅对于我哈 "         -   _ -  ||"
 */
#import <UIKit/UIKit.h>

@protocol HKKTagWriteViewDelegate;

@interface HKKTagWriteView : UIView

//
// appearance
//
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *tagBackgroundColor;
@property (nonatomic, strong) UIColor *tagForegroundColor;
@property (nonatomic, assign) int maxTagLength;
@property (nonatomic, assign) CGFloat tagGap;

//
// data
//
@property (nonatomic, readonly) NSArray *tags;
//改
@property (nonatomic, strong) NSString *text;
//改 (简单的占位符)
@property (nonatomic, strong) NSString *placeholder;
//
// control
//
@property (nonatomic, assign) BOOL focusOnAddTag;

@property (nonatomic, weak) id<HKKTagWriteViewDelegate> delegate;

- (void)clear;
- (void)setTextToInputSlot:(NSString *)text;

- (void)addTags:(NSArray *)tags;
- (void)removeTags:(NSArray *)tags;
- (void)addTagToLast:(NSString *)tag animated:(BOOL)animated;
- (void)removeTag:(NSString *)tag animated:(BOOL)animated;
- (id)initWithFrame:(CGRect)frame Andplaceholder:(NSString *)ThePlaceholder;

@end

@protocol HKKTagWriteViewDelegate <NSObject>
@optional
- (void)tagWriteViewDidBeginEditing:(HKKTagWriteView *)view;
- (void)tagWriteViewDidEndEditing:(HKKTagWriteView *)view;

- (void)tagWriteView:(HKKTagWriteView *)view didChangeText:(NSString *)text;
- (void)tagWriteView:(HKKTagWriteView *)view didMakeTag:(NSString *)tag;
- (void)tagWriteView:(HKKTagWriteView *)view didRemoveTag:(NSString *)tag;
@end


