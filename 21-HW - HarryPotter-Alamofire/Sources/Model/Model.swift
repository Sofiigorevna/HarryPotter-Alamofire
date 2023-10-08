//
//  Model.swift
//  21-HW - HarryPotter-Alamofire
//
//  Created by 1234 on 08.10.2023.
//

import Foundation

public struct Characters: Codable {
    let name: String?
    let actor: String?
    let house: String?
    let patronus: String?
    let image: String?
    let dateOfBirth: String?
    let ancestry: String?
    let eyeColour: String?
    let hairColour: String?

    enum CodingKeys: String, CodingKey {
        case image
        case name
        case actor
        case house
        case patronus
        case dateOfBirth
        case eyeColour
        case ancestry
        case hairColour
    }
}
