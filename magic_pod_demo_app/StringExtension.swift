//
//  StringExtension.swift
//  magic_pod_demo_app
//
//  Created by Masayuki Wakizaka on 2019/08/05.
//  Copyright © 2019 TRIDENT. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
