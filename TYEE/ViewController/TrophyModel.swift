//
//  TrophiesModel.swift
//  TYEE
//
//  Created by Sebastian Ottow on 08.09.22.
//

import Foundation
import UIKit

struct Trophies: Codable {

    var fishSpecies: String
    var fishLength: Double
    var fishWeight: Double
    var trophyImage: String
    var trophyCatchStyle: String
    var id: String
}
