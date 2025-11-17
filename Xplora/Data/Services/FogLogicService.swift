//
//  FogLogicService.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

import Foundation

protocol FogLogicService {
    func openedRegions(for countries: [Country]) -> [Region]
}

final class FogLogicServiceImpl: FogLogicService {
    func openedRegions(for countries: [Country]) -> [Region] {
        countries.flatMap { $0.regions.filter { $0.isVisited } }
    }
}
