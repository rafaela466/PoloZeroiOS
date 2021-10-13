//
//  CodableBundleExtention.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 03/02/2021.
//

import Foundation

extension Bundle{
    func decode<T: Codable> (_ file: String) -> T {
        //1. Locate the JSON file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        //2. Create a property for the data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to locate \(file) from bundle.")
        }
        
        //3. Create a decoder
        let decoder = JSONDecoder()
        
        //4. Create a property for the decoded data
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to locate \(file) from bundle.")
        }
        
        //5. Return thge ready-to-use data
        return decodedData
    }
}
