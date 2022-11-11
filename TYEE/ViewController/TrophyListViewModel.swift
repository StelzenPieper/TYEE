//
//  TrophyListViewModel.swift
//  TYEE
//
//  Created by Sebastian Ottow on 08.09.22.
//

import Foundation
import UIKit
import Combine

protocol TrophyListViewModelDelegate: AnyObject {
    func didUpdateTrophies()
}

class TrophyListViewModel: ObservableObject {

//    @Published var loadingState: LoadingState = .success
//
//    enum LoadingState {
//        case isLoading(message: String)
//        case success
//        case fail(message: String)
//    }

    var trophies = [Trophies]() {
        didSet {
            self.delegate?.didUpdateTrophies()
        }
    }
    
    weak var delegate: TrophyListViewModelDelegate?

    init(model: [Trophies]?) {

        loadTrophies()
    }

    func addNewTrophy(newFishSpecies: String,
                      newFishLength: Double,
                      newFishWeight: Double,
                      newTrophyImage: String,
                      newTrophyCatchStyle: String) {

        let uuid = NSUUID()
        let keyValue = uuid.uuidString

        let newTrophyItem = Trophies(fishSpecies: newFishSpecies, fishLength: newFishLength, fishWeight: newFishWeight, trophyImage: newTrophyImage, trophyCatchStyle: newTrophyCatchStyle, id: keyValue)

        trophies.append(newTrophyItem)

        let encoder = JSONEncoder()

        if let encoded = try? encoder.encode(trophies) {

        UserDefaults.standard.set(encoded, forKey: "TrophiesArray")
        }
    }

    func loadTrophies() {
        if let storedTrophies = UserDefaults.standard.object(forKey: "TrophiesArray") as? Data {

            let decoder = JSONDecoder()

            if let decodedTrophies = try? decoder.decode([Trophies].self, from: storedTrophies) {

                self.trophies = decodedTrophies
            }
        }
    }
}
