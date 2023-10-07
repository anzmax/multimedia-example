import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        
        let musicVC = MusicViewController()
        let videoVC = VideoViewController()
        let tabBarController = UITabBarController()
        let musicNAV = UINavigationController(rootViewController: musicVC)
        let videoNAV = UINavigationController(rootViewController: videoVC)
        
        let musicImage = UIImage(systemName: "play.rectangle.fill")?
            .withTintColor(UIColor.lightGray, renderingMode: .alwaysOriginal)
        musicNAV.tabBarItem = UITabBarItem(title: "", image: musicImage, tag: 0)
        musicNAV.tabBarItem.selectedImage = musicImage
        //musicNAV.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        
        let videoImage = UIImage(systemName: "video.fill")?
            .withTintColor(UIColor.lightGray, renderingMode: .alwaysOriginal)
        videoNAV.tabBarItem = UITabBarItem(title: "", image: videoImage, tag: 1)
        videoNAV.tabBarItem.selectedImage = videoImage
        //videoNAV.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)

        tabBarController.viewControllers = [musicNAV, videoNAV]
        tabBarController.selectedIndex = 0
        window = UIWindow(windowScene: scene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

