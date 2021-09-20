//
//  Mappable.swift
//  exercise2films
//
//  Created by David on 16/9/21.
//

import Foundation

protocol Mappable: Codable {
    init?(withJsonData: Data?)
}

extension Mappable {
    init?(withJsonData: Data?) {
        guard let data = withJsonData else { return nil }
        
        do {
            self = try JSONDecoder().decode(Self.self, from: data)
        } catch {
            return nil
        }
    }
}
