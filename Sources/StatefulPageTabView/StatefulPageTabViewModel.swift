//
//	Using Swift 5.0
//
//	Created by Applevena.
//	Copyright © 2021 Applevena. All rights reserved.
//

import SwiftUI

public class StatefulPageTabViewModel: ObservableObject {
	@Published public var selection: Int
	@Published public private(set) var previousSelection: Int
	@Published public internal(set) var xOffset: CGFloat = 0
	
	init(selection: Int) {
		self._selection = Published<Int>(initialValue: selection)
		self._previousSelection = Published<Int>(initialValue: selection)
	}
	
	
	func updatePreviousSelection() {
		self.previousSelection = self.selection
	}
	
	
}


extension StatefulPageTabViewModel {
	public static func first() -> StatefulPageTabViewModel {
		return StatefulPageTabViewModel(selection: 0)
	}
	
	public static func custom(_ selection: Int) -> StatefulPageTabViewModel {
		return StatefulPageTabViewModel(selection: selection)
	}
	
	
}
