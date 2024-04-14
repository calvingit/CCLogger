//
//  Logger.swift
//
//
//  Created by Calvin on 2024/4/13.
//

import Foundation

public protocol LogOutputable {
    func output(_ logString: String, category: String, level: LogLevel)
}

public protocol LogFormatter {
    func format(_ message: LogMessage) -> String
}

public enum LogLevel: Int {
    case debug, info, warning, error
}

extension LogLevel: CustomStringConvertible {
    public var description: String {
        switch self {
        case .debug: return "Debug"
        case .info: return "Info"
        case .warning: return "Warning"
        case .error: return "Error"
        }
    }
}

public struct LogMessage {
    let timestamp: TimeInterval
    let message: String
    let category: String
    let level: LogLevel
    let file: String
    let line: UInt
    let function: String
}

public class CCLogger {
    
    public static let shared = CCLogger(category: "General")
    
    public var logFormatter: LogFormatter = DefaultFormatter()
    
    public private(set) var category: String = ""
    
    public var outputters: [LogOutputable] = []
    
    public var logLevel: LogLevel = .debug
    
    private init() {}
    
    init(category: String) {
        self.category = category
    }
    
    public func log(_ message: String, level: LogLevel = .debug, file: String = #file, function: String = #function, line: UInt = #line) {
        
        if logLevel.rawValue > level.rawValue {
            return
        }
        
        let fileName = URL(fileURLWithPath:file).lastPathComponent
        let timestamp = Date().timeIntervalSince1970
        
        let message = LogMessage(
            timestamp: timestamp,
            message: message,
            category: category,
            level: level,
            file: fileName,
            line: line,
            function: function)
        
        for outputter in outputters {
            let logString = logFormatter.format(message)
            outputter.output(logString, category: category, level: level)
        }
    }
}
