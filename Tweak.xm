@interface SBLockScreenManager
-(BOOL)attemptUnlockWithPasscode:(id)arg1;
@end


static id passcode = nil;

%hook SBLockScreenManager
	-(BOOL)attemptUnlockWithPasscode:(id)arg1 {
		if(passcode != nil && arg1 != passcode) {
			return [self attemptUnlockWithPasscode:passcode];
		} else if(passcode != nil){
			return %orig;
		}

		BOOL ans = %orig;
		
		if (ans) {
			passcode = arg1;
			[passcode retain];
			return ans;
		} 
		return ans;
	}
%end