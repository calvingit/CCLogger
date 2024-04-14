//
//  OSLogOutputter.swift
//
//
//  Created by Calvin on 2024/4/13.
//

import Foundation
import os

@available(iOS 14.0, *)
public final class OSLogOutputter: LogOutputable {
    let lock = NSLock()
    
    private var loggers: [String: Logger] = [:]
    
    public init(){}

    func getLogger(_ category: String) -> Logger {
        if let logger = loggers[category] {
            return logger
        }
        
        lock.lock()
        let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: category)
        loggers[category] = logger
        lock.unlock()
        return logger
    }
    
    public func output(_ logString: String, category: String, level: LogLevel) {
        let logger = getLogger(category)
        switch level {
        case .debug:
            logger.debug("\(logString)")
        case .info:
            logger.info("\(logString)")
        case .warning:
            logger.warning("\(logString)")
        case .error:
            logger.fault("\(logString)")
        }
    }
}
