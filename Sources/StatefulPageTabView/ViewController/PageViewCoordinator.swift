//
//	Using Swift 5.0
//
//	Created by Applevena.
//	Copyright © 2021 Applevena. All rights reserved.
//

import UIKit

class PageViewCoordinator: NSObject {
	let viewModel: StatefulPageTabViewModel
	var controllers: [UIViewController]
	var isTransitioning: Bool = false
	
	
	init(_ parent: PageViewController) {
		self.viewModel = parent.viewModel
		self.controllers = parent.controllers
	}
	
	
}


extension PageViewCoordinator: UIPageViewControllerDataSource {
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		guard let index = controllers.firstIndex(of: viewController), 0..<controllers.count ~= index - 1 else { return nil }
		
		return controllers[index - 1]
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		guard let index = controllers.firstIndex(of: viewController), 0..<controllers.count ~= index + 1 else { return nil }
		
		return controllers[index + 1]
	}
	
	
}


extension PageViewCoordinator: UIPageViewControllerDelegate {
	func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		guard finished, completed, let displayedVC = pageViewController.viewControllers?.first, let newIndex = controllers.firstIndex(of: displayedVC) else { return }
		
		viewModel.selection = newIndex
		viewModel.updatePreviousSelection()
	}
	
	
}


extension PageViewCoordinator: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		viewModel.xOffset = scrollView.contentOffset.x
	}
	
	
}
