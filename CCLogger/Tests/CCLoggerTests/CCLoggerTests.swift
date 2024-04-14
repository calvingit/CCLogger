import XCTest
@testable import CCLogger

final class CCLoggerTests: XCTestCase {
    
    func testConsoleOutput() throws {
        CCLogger.shared.outputters = [ConsoleOutputter()]
        CCLogger.shared.log("this is a debug log test")
        CCLogger.shared.log("this is a info log test", level: .info)
        CCLogger.shared.log("this is a warning test", level: .warning)
        CCLogger.shared.log("this is a error test", level: .error)
    }
    
    func testFileOutput() throws {
        let fileOutputter = FileOutputter()
        let filePath = fileOutputter.todayLogFileURL.standardizedFileURL.absoluteString
        
        CCLogger.shared.outputters = [fileOutputter]
        CCLogger.shared.log("this is a debug log test")
        CCLogger.shared.log("this is a info log test", level: .info)
        CCLogger.shared.log("this is a warning test", level: .warning)
        CCLogger.shared.log("this is a error test", level: .error)
        
        print("File path: \(filePath)")
        
        if let cotent = try? String(contentsOf: fileOutputter.todayLogFileURL, encoding: .utf8) {
            print("File Content Start --- ")
            print("\(cotent)")
            print("File Content End --- ")
        }
    }
    
    @available(iOS 14.0, *)
    func testOSLogOutput() throws {
        CCLogger.shared.outputters = [OSLogOutputter()]
        CCLogger.shared.log("this is a debug log test")
        CCLogger.shared.log("this is a info log test", level: .info)
        CCLogger.shared.log("this is a warning test", level: .warning)
        CCLogger.shared.log("this is a error test", level: .error)
    }
    
}
