//
//  FacebookAuthApp.swift
//  FacebookAuth
//
//  Created by Viktor Golubenkov on 16.03.2021.
//

import SwiftUI
import FBSDKCoreKit

@main
struct FacebookAuthApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    ApplicationDelegate.initializeSDK(nil)
                })
                .onOpenURL(perform: { url in
                    ApplicationDelegate.shared.application(UIApplication.shared, open: url, sourceApplication: nil, annotation: UIApplication.OpenURLOptionsKey.annotation)
                })
        }
    }
}
