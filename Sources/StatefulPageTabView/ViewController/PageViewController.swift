//
//	Using Swift 5.0
//
//	Created by Applevena.
//	Copyright © 2021 Applevena. All rights reserved.
//

import SwiftUI

struct PageViewController: UIViewControllerRepresentable {
	let viewModel: StatefulPageTabViewModel
	let controllers: [UIViewController]
	
	
	init(_ viewModel: StatefulPageTabViewModel, _ controllers: [UIViewController]) {
		self.viewModel = viewModel
		self.controllers = controllers
	}
	
	
	func makeCoordinator() -> PageViewCoordinator {
		return PageViewCoordinator(self)
	}
	
	func makeUIViewController(context: Context) -> UIPageViewController {
		let pageViewController: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
		
		setUp(pageViewController, context)
		
		return pageViewController
	}
	
	func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
		guard viewModel.selection != viewModel.previousSelection, !context.coordinator.isTransitioning else { return }
		
		updateDisplayedViewController(pageViewController, context)
	}
	
	
	private func setUp(_ pageViewController: UIPageViewController, _ context: Context) {
		guard let scrollView = pageViewController.view.subviews.first as? UIScrollView else { fatalError("Not Found UIQueuingScrollView") }
		
		pageViewController.dataSource = context.coordinator
		pageViewController.delegate = context.coordinator
		scrollView.delegate = context.coordinator
		
		pageViewController.setViewControllers([context.coordinator.controllers[viewModel.selection]], direction: .forward, animated: false)
		
		viewModel.xOffset = pageViewController.view.bounds.width
	}
	
	private func updateDisplayedViewController(_ pageViewController: UIPageViewController, _ context: Context) {
		let direction: UIPageViewController.NavigationDirection = viewModel.selection > viewModel.previousSelection ? .forward : .reverse
		
		pageViewController.setViewControllers([context.coordinator.controllers[viewModel.selection]], direction: direction, animated: true) { finished in
			if finished {
				viewModel.updatePreviousSelection()
				context.coordinator.isTransitioning = false
			}
		}
		
		context.coordinator.isTransitioning = true
	}
	
	
}
