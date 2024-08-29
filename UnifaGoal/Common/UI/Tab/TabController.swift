import UIKit

class TabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        setupViewControllers()
    }
    
    private func setupAppearance() {
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = tabBar.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBar.insertSubview(blurView, at: 0)
        
        
        tabBar.layer.masksToBounds = true
        tabBar.isTranslucent = true
        tabBar.layer.cornerRadius = 25
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupViewControllers() {
        let controllers = createControllers(controllers: [
            .allNews,
            .topStories,
            .mostPopular,
            .search
        ])
        
        viewControllers = controllers
    }
    
    private func createControllers(controllers: [Controllers]) -> [UIViewController] {
        var viewControllers: [UIViewController] = []
        
        for controller in controllers {
            guard let viewController = viewController(for: controller) else {
                print("Couldnt create controller")
                return []
            }
            
            viewController.title = controller.title
            viewController.viewModel = controller.viewModel
            
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.tabBarItem = UITabBarItem(title: controller.title, image: controller.tabImage, selectedImage: nil)
            viewControllers.append(navigationController)
        }
        
        return viewControllers
    }
    
    private func viewController(for identifier: Controllers) -> ViewController? {
        let storyboard = UIStoryboard(name: identifier.rawValue, bundle: nil)
        
        let viewController: ViewController?
        switch identifier {
        case .allNews:
            viewController = storyboard.instantiateViewController(withIdentifier: identifier.rawValue) as! AllNewsViewController
        case .topStories:
            viewController = storyboard.instantiateViewController(withIdentifier: identifier.rawValue) as! TopStoriesViewController
        case .mostPopular:
            viewController = storyboard.instantiateViewController(withIdentifier: identifier.rawValue) as! MostPopularViewController
        case .search:
            viewController = storyboard.instantiateViewController(withIdentifier: identifier.rawValue) as! SearchViewController
        }
        return  viewController
    }
}

enum Controllers: String {
    case allNews = "AllNewsViewController"
    case topStories = "TopStoriesViewController"
    case mostPopular = "MostPopularViewController"
    case search = "SearchViewController"
    
    var title: String {
        switch self {
        case .allNews:
            "All News"
        case .topStories:
            "Top Stories"
        case .mostPopular:
            "Most Popular"
        case .search:
            "Search"
        }
    }
    
    var viewModel: ViewModel {
        switch self {
        case .allNews:
            AllNewsViewModel()
        case .topStories:
            TopStoriesViewModel()
        case .mostPopular:
            MostPopularViewModel()
        case .search:
            SearchViewModel()
        }
    }
    
    var tabImage: UIImage {
        switch self {
        case .allNews:
            UIImage(systemName: "newspaper.fill") ?? UIImage()
        case .topStories:
            UIImage(systemName: "star.fill") ?? UIImage()
        case .mostPopular:
            UIImage(systemName: "flame.fill") ?? UIImage()
        case .search:
            UIImage(systemName: "magnifyingglass") ?? UIImage()
        }
    }
}
