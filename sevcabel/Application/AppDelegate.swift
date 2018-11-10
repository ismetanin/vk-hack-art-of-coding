//
//  AppDelegate.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 09/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit
import SwiftyVK
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        VKSdk.initialize(withAppId: "6747854")?.register(self)
        VK.setUp(appId: "6747854", delegate: self)
        initializeRootView()
        return true
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
        return true
    }

    // MARK: - Private methods

    private func initializeRootView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = TabBar()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }

}

extension AppDelegate: SwiftyVKDelegate {

    func vkNeedsScopes(for sessionId: String) -> Scopes {
        return [Scopes.email, Scopes.offline, Scopes.wall]
    }

    func vkNeedToPresent(viewController: VKViewController) {
        // Called when SwiftyVK wants to present UI (e.g. webView or captcha)
        // Should display given view controller from current top view controller
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }

    func vkTokenCreated(for sessionId: String, info: [String : String]) {
        // Called when user grants access and SwiftyVK gets new session token
        // Can be used to run SwiftyVK requests and save session data
        print(sessionId)
    }

    func vkTokenUpdated(for sessionId: String, info: [String : String]) {
        // Called when existing session token has expired and successfully refreshed
        // You don't need to do anything special here
    }

    func vkTokenRemoved(for sessionId: String) {
        // Called when user was logged out
        // Use this method to cancel all SwiftyVK requests and remove session data
    }

}

extension AppDelegate: VKSdkDelegate {

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        UserDefaults.standard.isUserAuthorized = true
        try? VK.sessions.default.logIn(rawToken: result.token.accessToken, expires: 0)
        NotificationCenter.default.post(name: .userAuthorized, object: nil)
    }

    func vkSdkUserAuthorizationFailed() {

    }

}

