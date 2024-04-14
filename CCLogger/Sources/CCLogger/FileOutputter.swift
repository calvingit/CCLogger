//
//  FileOutputter.swift
//
//
//  Created by Calvin on 2024/4/13.
//

import Foundation

private let lastCleanupDateKey = "LastCleanupDate"

public final class FileOutputter: LogOutputable {

    private var logDirectory: URL?
    
    private let writingQueue = DispatchQueue(label: "file.logger", attributes: .concurrent)

    public init(){}

    init(_ logDirectory: URL? = nil) {
        self.logDirectory = logDirectory
        startCleanupIfNeeded()
    }
    
    public lazy var todayLogFileURL: URL = {
        let directory = logDirectory ?? cachesDirectoryURL
        let logFileURL = logFileURL(in: directory, for: Date())
        if FileManager.default.fileExists(atPath: logFileURL.path) {
            return logFileURL
        }
        
        do {
            var isDir : ObjCBool = false
            let isExistDirectory = FileManager.default.fileExists(atPath: directory.standardizedFileURL.absoluteString, isDirectory:&isDir)
            if !isExistDirectory {
                try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
            }
            try "".write(to: logFileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Error creating log directory: \(error)")
        }
        return logFileURL
    }()
    
    private let cachesDirectoryURL: URL = {
        let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return cachesURL.appendingPathComponent("Logs")
    }()
    
    private func logFileURL(in directory: URL, for date: Date) -> URL {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let fileName = "\(dateFormatter.string(from: date)).log"
        return directory.appendingPathComponent(fileName)
    }
        
    private func startCleanupIfNeeded() {
        guard let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date()) else {
            return
        }
        
        let lastCleanupDate = UserDefaults.standard.object(forKey: lastCleanupDateKey) as? Date
        
        if lastCleanupDate == nil || (lastCleanupDate ?? Date()) < sevenDaysAgo {
            cleanupLogFiles(expirationDate: sevenDaysAgo)
            UserDefaults.standard.set(Date(), forKey: lastCleanupDateKey)
        }
    }
    
    private func cleanupLogFiles(expirationDate: Date) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileManager = FileManager.default
                let logFiles = try fileManager.contentsOfDirectory(at: self.logDirectory ?? self.cachesDirectoryURL, includingPropertiesForKeys: [.creationDateKey], options: .skipsHiddenFiles)
                
                for logFile in logFiles {
                    let resourceValues = try (logFile as NSURL).resourceValues(forKeys: [.creationDateKey])
                    let creationDate = resourceValues[.creationDateKey] as? Date
                    if let creationDate, creationDate < expirationDate {
                        try fileManager.removeItem(at: logFile)
                    }
                }
            } catch {
                print("Error cleaning up log files: \(error)")
            }
        }
    }

    public func output(_ logString: String, category: String, level: LogLevel) {
        let logContent = "[\(category)] \(logString)\n"
        writingQueue.asyncAndWait {
            do {
                let fileHandle = try FileHandle(forWritingTo: self.todayLogFileURL)
                defer {
                    fileHandle.closeFile()
                }
                fileHandle.seekToEndOfFile()
                fileHandle.write(logContent.data(using: .utf8)!)
            } catch {
                print("Error writing log to file: \(error)")
            }
        }
    }
    
}
