//
//	Using Swift 5.0
//
//	Created by Applevena.
//	Copyright © 2021 Applevena. All rights reserved.
//

import SwiftUI

public struct Page {
	let view: AnyView
	
	
	public init<Content: View>(_ content: () -> Content) {
		self.view = AnyView(content())
	}
	
	
}
