import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        
        let musicVC = MusicViewController()
        let videoVC = VideoViewController()
        let recordVC = RecordViewController()
        let tabBarController = UITabBarController()
        let musicNAV = UINavigationController(rootViewController: musicVC)
        let videoNAV = UINavigationController(rootViewController: videoVC)
        let recordNAV = UINavigationController(rootViewController: recordVC)
        
        let musicImage = UIImage(systemName: "play.rectangle.fill")?
            .withTintColor(UIColor.lightGray, renderingMode: .alwaysOriginal)
        musicNAV.tabBarItem = UITabBarItem(title: "", image: musicImage, tag: 0)
        musicNAV.tabBarItem.selectedImage = musicImage
        
        let videoImage = UIImage(systemName: "video.fill")?
            .withTintColor(UIColor.lightGray, renderingMode: .alwaysOriginal)
        videoNAV.tabBarItem = UITabBarItem(title: "", image: videoImage, tag: 1)
        videoNAV.tabBarItem.selectedImage = videoImage
        
        let recordImage = UIImage(systemName: "recordingtape")?
            .withTintColor(UIColor.lightGray, renderingMode: .alwaysOriginal)
        recordNAV.tabBarItem = UITabBarItem(title: "", image: recordImage, tag: 2)
        recordNAV.tabBarItem.selectedImage = recordImage

        tabBarController.viewControllers = [musicNAV, videoNAV, recordNAV]
        tabBarController.selectedIndex = 0
        window = UIWindow(windowScene: scene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

