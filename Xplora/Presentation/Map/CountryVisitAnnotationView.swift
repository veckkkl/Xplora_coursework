//
//  CountryVisitAnnotationView.swift
//  Xplora


import MapKit

final class CountryVisitAnnotationView: MKMarkerAnnotationView {
    static let reuseIdentifier = "CountryVisitAnnotationView"

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    private func configure() {
        canShowCallout = true
        markerTintColor = UIColor(named: "accent_orange") ?? .systemOrange
        glyphImage = UIImage(systemName: "mappin")
        titleVisibility = .visible
        subtitleVisibility = .visible
        displayPriority = .defaultHigh
    }
}
