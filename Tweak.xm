static UIView* blackView(void) {

    // I stole this idea from @LaughingQuoll
    // Thanks tho

    CGRect screenBounds = [UIScreen mainScreen].bounds;

    CGRect frame = CGRectMake(-40.5, -10, screenBounds.size.width + 81, screenBounds.size.height+200); //this is the border which will cover the notch

    UIView *blackView = [[[UIView alloc] initWithFrame:frame] autorelease];
    blackView.layer.borderColor = [UIColor blackColor].CGColor;
    blackView.layer.borderWidth = 40.0f;

    [blackView setClipsToBounds:YES];
    [blackView.layer setMasksToBounds:YES];
    blackView.layer.cornerRadius = 75;

    return blackView;
}

@interface _UIStatusBar : UIView
@property (nonatomic, retain) UIColor *foregroundColor;
@property BOOL didRemoveNotch;
-(void)removeNotch;
@end

@interface SBControlCenterController
+ (id)sharedInstance;
- (UIWindow*)_controlCenterWindow;
@property(readonly, nonatomic, getter=isVisible) _Bool visible;
@end

// To Do : Add blackView to the control center

%hook _UIStatusBar

%property BOOL didRemoveNotch;

-(void)layoutSubviews {

    %orig;

    self.foregroundColor = [UIColor whiteColor];

    if(![[[UIApplication sharedApplication] keyWindow] isKindOfClass:%c(SBControlCenterWindow)] && !self.didRemoveNotch) {
        [self removeNotch];
    }
}

%new
-(void)removeNotch {

    
    [self setBackgroundColor:[UIColor blackColor]];

    UIView* notchHidingView = blackView();

    [self addSubview: notchHidingView];
    [self sendSubviewToBack: notchHidingView];

    self.didRemoveNotch = YES;

    //[notchHidingView release];
}

//Make the Statusbar slightly smaller

- (void)setFrame:(CGRect)frame {
    frame.size.height = 34;
    %orig(frame);
}
- (CGRect)bounds {
    CGRect frame = %orig;
    frame.size.height = 32;
    return frame;
}
%end