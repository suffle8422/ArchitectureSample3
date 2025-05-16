//
//  Date+.swift
//  LocalModules
//
//  Created by Ibuki Onishi on 2025/05/16.
//

import Foundation

extension Date {
    package var formattedString: String {
        let dateFormatter = makeFormatter(dateFormat: "yyyy-MM-dd HH:mm:ss")
        return dateFormatter.string(from: self)
    }

    private func makeFormatter(dateFormat: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "ja_JP")
        return dateFormatter
    }
}
