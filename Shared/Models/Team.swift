//
//  Team.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 02.05.2022.
//

import Foundation


struct Team: Decodable {
    
    struct Section: Decodable, Identifiable {
        
        struct Member: Decodable, Identifiable {
            private enum CodingKeys: String, CodingKey {
                case name
                
            }
            
            var id = UUID()
            let name: String
        }
        
        
        private enum CodingKeys: String, CodingKey {
            case name, members
        }
        
        var id = UUID()
        let name: [String: String]
        let members: [Member]
    }
    
    
    let sections: [Section]
}


