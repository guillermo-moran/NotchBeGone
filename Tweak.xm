static UIView* blackView(void) {

    // I stole this idea from @LaughingQuoll
    // Thanks tho

    CGRect screenBounds = [UIScreen mainScreen].bounds;

    CGRect frame = CGRectMake(-40.5, -5, screenBounds.size.width + 81, screenBounds.size.height+2000); //this is the border which will cover the notch

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

@interface LayoutContext : NSObject
- (id)layoutState;
@end

@interface SBAppStatusBarSettingsAssertion : NSObject
- (void)invalidate;
- (void)acquire;
-(id)initWithStatusBarHidden:(BOOL)hidden atLevel:(NSUInteger)level reason:(NSString *)reason;
@property (nonatomic,readonly) NSUInteger level; 
@property (nonatomic,copy,readonly) NSString * reason;   
@end

SBAppStatusBarSettingsAssertion *assertion;

// To Do : Add blackView to the control center

%hook _UIStatusBar

%property BOOL didRemoveNotch;

-(void)layoutSubviews {

    %orig;

    self.foregroundColor = [UIColor whiteColor];

    if(![[[UIApplication sharedApplication] keyWindow] isKindOfClass:%c(SBControlCenterWindow)] && !self.didRemoveNotch) {
        [self removeNotch];
    }

	if (!assertion) {
		assertion = [[NSClassFromString(@"SBAppStatusBarSettingsAssertion") alloc] initWithStatusBarHidden:NO atLevel:5 reason:@"eggNotch"];
		[assertion acquire];
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
