import UIKit
import SnapKit

final class AppViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
    }
}

private extension AppViewController {
    func setupNavigationController() {
        navigationItem.title = "앱"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
