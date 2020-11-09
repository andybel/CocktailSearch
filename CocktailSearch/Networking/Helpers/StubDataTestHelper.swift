//
//  StubDataTestHelper.swift
//
//  Created by Andy Bell on 17.10.20.
//

import Foundation

class StubDataTestHelper {
    
    static func loadMockJsonData(for filename: String) throws -> Data {
        
        guard let path = Bundle.main.path(forResource: filename, ofType: "json") else {
            throw CSError.general("failed to load local resource: \(filename).json")
        }
        do {
            let fileStr = try String(contentsOfFile: path)
            if let fileData = fileStr.data(using: .utf8) {
                return fileData
            }
            throw CSError.general("Unable to convert filepath to data: \(path)")
        } catch {
            throw error
        }
    }
}

