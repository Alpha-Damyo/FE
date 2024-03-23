import UIKit
import Flutter
import NaverThirdPartyLogin

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // let instance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    // // 네이버 앱으로 인증하는 방식을 활성화
    // instance?.isNaverAppOauthEnable = true
    // // SafariViewController에서 인증하는 방식을 활성화
    // instance?.isInAppOauthEnable = true
    
    // // 인증 화면을 iPhone의 세로 모드에서만 사용하기
    // instance?.isOnlyPortraitSupportedInIphone()
    
    // // 네이버 아이디로 로그인하기 설정
    // // 애플리케이션을 등록할 때 입력한 URL Scheme
    // instance?.serviceUrlScheme = kServiceAppUrlScheme
    // // 애플리케이션 등록 후 발급받은 클라이언트 아이디
    // instance?.consumerKey = kConsumerKey
    // // 애플리케이션 등록 후 발급받은 클라이언트 시크릿
    // instance?.consumerSecret = kConsumerSecret
    // // 애플리케이션 이름
    // instance?.appName = kServiceAppName

    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    // return true
  }

  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options)
    return true
  }
  
//카카오 로그인 구현 시 사용해야하는 오버라이딩 함수
// override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    
//     if (url.absoluteString.contains("thirdPartyLoginResult")) {
//         return NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
//     }
        
//     return super.application(app, open: url, options: options)
    
// }
//-----------------------------------------------------------------
  // override func application(
  //   _ application: UIApplication,
  //   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  // ) -> Bool {
  //   GeneratedPluginRegistrant.register(with: self)
  //   return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  // }
}

