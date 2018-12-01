//
//  CharacterCollectionViewController.swift
//  StarWars
//
//  Created by ALEXIS-PC on 11/30/18.
//  Copyright © 2018 jvl.pe. All rights reserved.
//

import UIKit
import os

private let reuseIdentifier = "Cell"

class CharacterCell: UICollectionViewCell {
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func update(from starWar: StarWars) {
        //photoRoverImage.setImageFrom(urlString: photo.img_src!, whitDefaultNamed: "noimage", whitErrorNamed: "noimage")
        
        nameLabel.text = starWar.name!
        
    }
}

class CharacterCollectionViewController: UICollectionViewController {

    var results: [StarWars] = [StarWars]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Swapi.getStarWars(apiKey: "", responseHandler: handleResponse, errorHandler: handleError)
        //(apiKey: "", responseHandler: handleResponse, errorHandler: handleError)   // aqui se llama a la funcion que usa las clases.
    }

    func handleResponse(response: StarWarsResponse) {
        
        if let starWar = response.results { //reponse.name >>se pone el nombre del array en JSON
            self.results = starWar
            self.collectionView.reloadData()
        }
    }
    
    func handleError(error: Error) {
        let message = "Error on StarWars Request: \(error.localizedDescription)"
        os_log("%@", message)
    }
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return results.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CharacterCell
    
        // Configure the cell
        cell.update(from: results[indexPath.row])
        return cell
    }

   

}
