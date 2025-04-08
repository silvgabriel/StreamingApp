//
//  String+Extension.swift
//  StreamingApp
//
//  Created by Gabriel Monteiro Camargo da Silva on 05/04/25.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
