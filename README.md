# SecuredCalls SDK Integration Guide

This guide provides step-by-step instructions for integrating the SecuredCalls SDK into your iOS app using Swift Package Manager (SPM).

## 1. Download the SecuredCalls SDK

To integrate the SecuredCalls SDK, add the following URL to your Swift Package Manager:

https://github.com/expertstack-studios/securedcall-ios-sdk.git


## 2. Add Notification Extension

 &emsp; **a.** Open your app project in Xcode <br />
 &emsp; **b.** Select the main app target <img src="https://github.com/expertstack-studios/readme_assets/blob/main/images/ios_notification_service_extension.png" width="60" > <br />
 &emsp; **c.** Add a new target for the notification extension.  <br />
 &emsp; **d.** Replace the contents of the service file with the following code: <br />

```swift
import UserNotifications
import SecuredCalls

class NotificationService: UNNotificationServiceExtension {
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        Task {
            await SC.processNotificationAsync(request: request, withContentHandler: contentHandler)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        Task {
            await SC.timeoutAsync()
        }
    }
}
```
<br />


&emsp; **e.** Accept the mobile number from the user and persist it using the SecuredCalls SDK. Ensure the mobile number is provided in E.164 format (e.g., +61477878786).

```swift
let saveMobileNumberResponse = await SC.saveMobileNumberAsync(mobileNumber: mobileNumberToSave)
switch saveMobileNumberResponse {
    case .success:
        return true
    case .failure(let error):
        print("mobile number parsing error : \(error)")
        return false
}
```
<br />


&emsp; **f.** In your app's AppDelegate, add the following code to register the push notification token with the SecuredCalls SDK:


```swift
func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
) {
    let token = deviceToken.hexString
    Task {
        await SC.registerDeviceAsync(token: token)
    }
}
```
<br />


&emsp; **g.** As per your application workflow, request notification and contacts permissions using the SecuredCalls SDK's provided methods. Alternatively, you can use your own code to request permissions.

## Example Code to Request Permissions

```swift
func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
) -> Bool {
    
    Task {
        await SC.requestNotificationPermissionAsync()
        await SC.requestContactAccessAsync()
    }

    return true
}

```
<br />

&emsp; **h.** In your app's Info.plist file, add the following entries:

Privacy - User Notifications Usage Description

Privacy - Contacts Usage Description

## Additional Notes
Make sure to handle all necessary error cases and provide appropriate user feedback when permissions are not granted.
