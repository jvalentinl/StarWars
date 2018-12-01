//
//  Swapi.swift
//  StarWars
//
//  Created by ALEXIS-PC on 11/30/18.
//  Copyright © 2018 jvl.pe. All rights reserved.
//

import Foundation
import os
import Alamofire

class Swapi {
    static let baseCountryUrl = "https://restcountries.eu/rest"
    static let countryAllUrl = "\(baseCountryUrl)/v2/all"
    static let NasaUrl = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=hDzy5RN4nn8NGSWfRVhsKRrvExMA4taGDJ9fmoEE"
    
    static let basePhotoRoverUrl = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=709e80fb-ea18-42cc-8521-db8a6090aa14"
    //https://restcountries.eu/rest/v2/all
    //sol=1000&api_key=hDzy5RN4nn8NGSWfRVhsKRrvExMA4taGDJ9fmoEE
   
    static let baseStarWarUrl = "https://swapi.co/api/people"
    
    static private func get<T: Decodable>(
        from urlString: String,
        parameters: [String : String],
        responseType: T.Type,
        responseHandler: @escaping ((T) -> Void),
        errorHandler: @escaping ((Error) -> Void)){
        //validar URL
        guard let url = URL(string: urlString) else {
            let message = "Error on URL"
            os_log("%@", message)
            return
        }
        //make the resquest
        Alamofire.request(url, parameters: parameters).validate()
            .responseJSON(completionHandler: {response in
                switch response.result {
                case .success(_):
                    do {
                        let decoder = JSONDecoder()
                        if let data = response.data {
                            let dataResponse = try decoder.decode(responseType, from: data)
                            responseHandler(dataResponse)
                        }
                        
                    } catch {
                        errorHandler(error)
                    }
                case .failure(let error):
                    errorHandler(error)
                }
            })
    }
    // crear funciones para usar el get q se ha creado para cada modelo a usar
    // to results StarWars
    static func getStarWars(
        apiKey: String,
        responseHandler: @escaping ((StarWarsResponse) -> Void),
        errorHandler: @escaping  ((Error) -> Void)
        ) {
        let parameters = ["apiKey" : apiKey]
        
        self.get(from: baseStarWarUrl,
                 parameters: parameters,
                 responseType: StarWarsResponse.self,
                 responseHandler: responseHandler,
                 errorHandler: errorHandler)
    }
}
