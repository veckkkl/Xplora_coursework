//
//  MapViewController.swift
//  Xplora


import MapKit
import SnapKit
import UIKit

final class MapViewController: UIViewController {
    private let viewModel: MapViewModelInput & MapViewModelOutput

    private let mapView = MKMapView()
    private let addNoteButton = UIButton(type: .system)
    private let addNoteContainer = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
    private var didSetInitialCamera = false

    init(viewModel: MapViewModelInput & MapViewModelOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupMapView()
        setupAddNoteButton()
        bindViewModel()
        viewModel.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setPlanetCameraIfNeeded()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setupMapView() {
        mapView.mapType = .hybridFlyover
        mapView.showsCompass = true
        mapView.showsScale = false
        mapView.showsBuildings = false
        mapView.showsUserLocation = true
        mapView.isRotateEnabled = true
        mapView.isPitchEnabled = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.cameraBoundary = nil
        mapView.cameraZoomRange = nil
        mapView.delegate = self
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: CountryVisitAnnotationView.reuseIdentifier)
        view.addSubview(mapView)

        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupAddNoteButton() {
        addNoteContainer.clipsToBounds = true
        addNoteContainer.layer.cornerRadius = 16
        view.addSubview(addNoteContainer)

        var configuration = UIButton.Configuration.tinted()
        configuration.title = "Add a note to my trip"
        configuration.baseForegroundColor = .systemBlue
        configuration.baseBackgroundColor = UIColor.systemBlue.withAlphaComponent(0.22)
        configuration.cornerStyle = .medium
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        addNoteButton.configuration = configuration
        addNoteButton.addTarget(self, action: #selector(didTapAddNote), for: .touchUpInside)
        addNoteContainer.contentView.addSubview(addNoteButton)

        addNoteContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().inset(16)
        }

        addNoteButton.snp.makeConstraints { make in
            make.top.equalTo(addNoteContainer.contentView.snp.top).offset(6)
            make.bottom.equalTo(addNoteContainer.contentView.snp.bottom).offset(-6)
            make.leading.equalTo(addNoteContainer.contentView.snp.leading).offset(8)
            make.trailing.equalTo(addNoteContainer.contentView.snp.trailing).offset(-8)
        }
    }

    private func bindViewModel() {
        viewModel.onMarkersUpdated = { [weak self] markers in
            self?.renderMarkers(markers)
        }
        viewModel.onOverlaysUpdated = { [weak self] overlays in
            self?.renderOverlays(overlays)
        }
    }

    private func setPlanetCameraIfNeeded() {
        guard !didSetInitialCamera else { return }
        guard mapView.bounds.width > 0 else { return }
        didSetInitialCamera = true
        setPlanetCamera()
    }

    private func setPlanetCamera() {
        let center = CLLocationCoordinate2D(latitude: 20, longitude: 0)
        let camera = MKMapCamera(lookingAtCenter: center, fromDistance: 20_000_000, pitch: 0, heading: 0)
        mapView.setCamera(camera, animated: false)
    }

    private func renderMarkers(_ markers: [CountryVisitMarker]) {
        let removable = mapView.annotations.filter { !($0 is MKUserLocation) }
        mapView.removeAnnotations(removable)
        let annotations = markers.map { CountryVisitAnnotation(marker: $0) }
        mapView.addAnnotations(annotations)
    }

    private func renderOverlays(_ overlays: [MKOverlay]) {
        mapView.removeOverlays(mapView.overlays)
        guard !overlays.isEmpty else { return }
        mapView.addOverlays(overlays)
    }

    @objc private func didTapAddNote() {
        viewModel.didTapAddNote()
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CountryVisitAnnotation else { return nil }
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: CountryVisitAnnotationView.reuseIdentifier, for: annotation)
        view.annotation = annotation

        if let markerView = view as? MKMarkerAnnotationView {
            markerView.canShowCallout = true
            markerView.markerTintColor = UIColor(named: "accent_orange") ?? .systemOrange
            markerView.glyphImage = UIImage(systemName: "mappin")
            markerView.titleVisibility = .hidden
            markerView.subtitleVisibility = .hidden
            let previewModel = viewModel.previewModel(for: annotation.marker)
            let calloutView = TripNoteCalloutView(model: previewModel)
            calloutView.onTap = { [weak self] in
                self?.viewModel.didSelectMarker(annotation.marker)
            }
            markerView.detailCalloutAccessoryView = calloutView
        }

        return view
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return MKOverlayRenderer(overlay: overlay)
    }
}
