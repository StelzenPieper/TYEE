//
//  TrophiesModel.swift
//  TYEE
//
//  Created by Sebastian Ottow on 08.09.22.
//

import UIKit
import RealmSwift


class Trophy: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var trophySpecies = "Beispeilspezies"
    @Persisted var trophyLength = 10.0
    @Persisted var trophyWeight = 2.5
    @Persisted var trophyImagePath = "BeispielImagePath"
    @Persisted var trophyCatchStylePath = "BeispielCatchIconPath"
    
    convenience init(
        trophySpecies: String,
        trophyLength: Double,
        trophyWeight: Double,
        trophyImagePath: String,
        trophyCatchStylePath: String
    ) {
        self.init()
        self.trophySpecies = trophySpecies
        self.trophyLength = trophyLength
        self.trophyWeight = trophyWeight
        self.trophyImagePath = trophyImagePath
        self.trophyCatchStylePath = trophyCatchStylePath
    }
    
}
