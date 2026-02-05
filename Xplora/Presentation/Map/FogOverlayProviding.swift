//
//  FogOverlayProviding.swift
//  Xplora


import MapKit

protocol FogOverlayProviding {
    func makeOverlays(visitedCountryCodes: Set<String>) -> [MKOverlay]
}

struct EmptyFogOverlayProvider: FogOverlayProviding {
    func makeOverlays(visitedCountryCodes: Set<String>) -> [MKOverlay] {
        return []
    }
}
