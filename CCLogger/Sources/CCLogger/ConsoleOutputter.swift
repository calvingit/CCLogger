//
//  ConsoleOutputter.swift
//
//
//  Created by Calvin on 2024/4/13.
//

import Foundation

public final class ConsoleOutputter: LogOutputable {
    public init(){}
    public func output(_ logString: String, category: String, level: LogLevel) {
        print(logString)
    }
}
