//
//  TrophyListViewModel.swift
//  TYEE
//
//  Created by Sebastian Ottow on 08.09.22.
//

import UIKit
import RealmSwift


protocol TrophyListViewModelDelegate: AnyObject {
    func didUpdateTrophies()
}

class TrophyListViewModel: ObservableObject {
    
    let realm = try! Realm()

    var trophies = [Trophy]() {
        didSet {
            self.delegate?.didUpdateTrophies()
        }
    }
    
    weak var delegate: TrophyListViewModelDelegate?

    init(model: [Trophy]?) {

        loadTrophies()
    }
    
    func loadTrophies() {
        _ = realm.objects(Trophy.self)
    }

    func addTrophy(
        newSpecies: String,
        newLength: Double,
        newWeight: Double,
        newImagePath: String,
        newCatchStylePath: String
    ) {

        let newTrophy = Trophy(trophySpecies: newSpecies, trophyLength: newLength, trophyWeight: newWeight, trophyImagePath: newImagePath, trophyCatchStylePath: newCatchStylePath)
        
        try! realm.write {
            realm.add(newTrophy)
        }
    }
    
    func editTrophy(
        index: Int,
        editTrophySpecies: String,
        editTrophyLength: Double,
        editTrophyWeight: Double,
        editTrophyImagePath: String,
        editTrophyCatchStylePath: String
    ) {
        
        let trophies = realm.objects(Trophy.self)
        
        let trophyToEdit = trophies[index]
        
        try! realm.write {
            trophyToEdit.trophySpecies = editTrophySpecies
            trophyToEdit.trophyLength = editTrophyLength
            trophyToEdit.trophyWeight = editTrophyWeight
            trophyToEdit.trophyImagePath = editTrophyImagePath
            trophyToEdit.trophyCatchStylePath = editTrophyCatchStylePath
        }
    }
    
    func deleteTrophy(index: Int) {
        let trophies = realm.objects(Trophy.self)
        
        let trophyToDelete = trophies[index]
        
        try! realm.write {
            realm.delete(trophyToDelete)
        }
    }
}
