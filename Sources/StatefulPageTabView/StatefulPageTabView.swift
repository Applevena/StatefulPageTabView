//
//	Using Swift 5.0
//
//	Created by Applevena.
//	Copyright © 2021 Applevena. All rights reserved.
//

import SwiftUI

public struct StatefulPageTabView: View {
	let viewModel: StatefulPageTabViewModel
	let controllers: [UIHostingController<AnyView>]
	
	
	public init(viewModel: StatefulPageTabViewModel = .first(), @PageBuilder _ pages: () -> [Page]) {
		self.viewModel = viewModel
		self.controllers = pages().map { UIHostingController(rootView: $0.view) }
	}
	
	
	public var body: some View {
		PageViewController(viewModel, controllers)
	}
	
	
}
