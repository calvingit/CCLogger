//
//  ViewController.swift
//  Example
//
//  Created by zhangwen on 2024/4/14.
//

import UIKit
import CCLogger

class ViewController: UIViewController {
    
    let fileOutputter = FileOutputter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        CCLogger.shared.outputters = [
            //ConsoleOutputter(),
            fileOutputter,
        ]
        
        if #available(iOS 14.0, *) {
            CCLogger.shared.outputters.append(OSLogOutputter())
        }
        
        CCLogger.shared.log("this is a debug log test")
        CCLogger.shared.log("this is a info log test", level: .info)
        CCLogger.shared.log("this is a warning test", level: .warning)
        CCLogger.shared.log("this is a error test", level: .error)
        
        //testFileOutput()
    }

    func testFileOutput() {
        let filePath = fileOutputter.todayLogFileURL.standardizedFileURL.absoluteString

        print("File path: \(filePath)")
        
        if let cotent = try? String(contentsOf: fileOutputter.todayLogFileURL, encoding: .utf8) {
            print("File Content Start --- ")
            print("\(cotent)")
            print("File Content End --- ")
        }
    }

}

