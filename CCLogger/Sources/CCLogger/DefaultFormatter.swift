//
//  DefaultFormatter.swift
//
//
//  Created by Calvin on 2024/4/13.
//

import Foundation

public final class DefaultFormatter: LogFormatter {
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return formatter
    }()
    
    public func format(_ message: LogMessage) -> String {
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: message.timestamp))
        return "\(dateString) [\(message.level.description)] [\(message.category)] \(message.file)(\(message.line)) \(message.function): \(message.message)"
    }
    
}
