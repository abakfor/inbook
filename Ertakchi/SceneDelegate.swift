//
//  SceneDelegate.swift
//  Ertakchi
//
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    static var shared: SceneDelegate?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        SceneDelegate.shared = self
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        if let token = UD.token, token.replacingOccurrences(of: " ", with: "") != "" {
            let vc = MainTabBarController()
            window?.rootViewController = vc
        } else {
            let vc = StartingViewController()
            window?.rootViewController = vc
        }
        setMode()
        window?.makeKeyAndVisible()
    }
    
    func setMode() {
        let viewMode = UD.mode ?? ""
        if !viewMode.isEmpty {
            if viewMode == "light" {
                window?.overrideUserInterfaceStyle = .light
            } else if viewMode == "dark" {
                window?.overrideUserInterfaceStyle = .dark
            } else if viewMode == "system" {
                let mode = Functions.getDeviceMode()
                if mode == .light {
                    window?.overrideUserInterfaceStyle = .light
                } else if mode == .dark {
                    window?.overrideUserInterfaceStyle = .dark
                } else {
                    window?.overrideUserInterfaceStyle = .light
                }
            }
        } else {
            let mode = Functions.getDeviceMode()
            if mode == .light {
                window?.overrideUserInterfaceStyle = .light
            } else if mode == .dark {
                window?.overrideUserInterfaceStyle = .dark
            } else {
                window?.overrideUserInterfaceStyle = .light
            }
            UD.mode = "system"
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func windowScene(_ windowScene: UIWindowScene, didUpdate previousCoordinateSpace: UICoordinateSpace, interfaceOrientation previousInterfaceOrientation: UIInterfaceOrientation, traitCollection previousTraitCollection: UITraitCollection) {
        if #available(iOS 13.0, *) {
            if previousTraitCollection.hasDifferentColorAppearance(comparedTo: windowScene.traitCollection) {
                let mode = UD.mode
                if mode == "system" {
                    if windowScene.traitCollection.userInterfaceStyle == .dark {
                        window?.overrideUserInterfaceStyle = .dark
                    } else {
                        window?.overrideUserInterfaceStyle = .light
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }


}

