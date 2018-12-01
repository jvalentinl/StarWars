//
//  StarWarsResponse.swift
//  StarWars
//
//  Created by ALEXIS-PC on 11/30/18.
//  Copyright © 2018 jvl.pe. All rights reserved.
//

import Foundation

class StarWarsResponse: Codable {
    //var status: String // solo si tiene antes del encabezado
    //var totalResults: Int? // solo si tiene antes del encabezado
    var code: String?
    var message: String?
    var results: [StarWars]?
}
