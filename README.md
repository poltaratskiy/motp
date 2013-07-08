motp
====

MobileOTP for Indeed-ID. This app generates one time passwords for Indeed-ID to Windows login.
It uses http://motp.sourceforge.net algorithm.
To generate one time password you need the current epoch-time in a 10 second granularity, 16-symbol Secret-Init code and 4-digit PIN code.
Algorithm looks like otp = 
