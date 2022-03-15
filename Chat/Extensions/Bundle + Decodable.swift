//
//  Bundle + Decodable.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 16.03.2022.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_type: T.Type, from file: String) -> T {
        guard let url = url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to open data")
        }
        
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Fail to decode")
        }
        
        return decodedData
    }
}
