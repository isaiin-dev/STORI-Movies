//
//  DispatchQueue+Extensions.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 05/11/24.
//

import Foundation

extension DispatchQueue {
    static func mainAsync(_ execute: @escaping () -> Void) {
        if Thread.isMainThread {
            execute()
        } else {
            DispatchQueue.main.async(execute: execute)
        }
    }
}
