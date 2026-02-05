//
//  MapViewController.swift
//  Xplora


import MapKit
import UIKit

final class MapViewController: UIViewController {
    private let viewModel: MapViewModelInput & MapViewModelOutput

    private let mapView = MKMapView()
    private let addNoteButton = UIButton(type: .system)
    private let addNoteContainer = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
    private let tripNoteCard = TripNotePreviewCardView()
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
        setupTripNoteCard()
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
        mapView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            mapView.mapType = .mutedStandard
        } else {
            mapView.mapType = .standard
        }
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMapBackground(_:)))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        mapView.addGestureRecognizer(tapGesture)
        mapView.register(CountryVisitAnnotationView.self, forAnnotationViewWithReuseIdentifier: CountryVisitAnnotationView.reuseIdentifier)
        view.addSubview(mapView)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupAddNoteButton() {
        addNoteContainer.translatesAutoresizingMaskIntoConstraints = false
        addNoteContainer.clipsToBounds = true
        addNoteContainer.layer.cornerRadius = 16
        view.addSubview(addNoteContainer)

        addNoteButton.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.tinted()
        configuration.title = "Add a note to my trip"
        configuration.baseForegroundColor = .systemBlue
        configuration.baseBackgroundColor = UIColor.systemBlue.withAlphaComponent(0.22)
        configuration.cornerStyle = .medium
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        addNoteButton.configuration = configuration
        addNoteButton.addTarget(self, action: #selector(didTapAddNote), for: .touchUpInside)
        addNoteContainer.contentView.addSubview(addNoteButton)

        NSLayoutConstraint.activate([
            addNoteContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            addNoteContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addNoteContainer.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -32),
            addNoteButton.topAnchor.constraint(equalTo: addNoteContainer.contentView.topAnchor, constant: 6),
            addNoteButton.bottomAnchor.constraint(equalTo: addNoteContainer.contentView.bottomAnchor, constant: -6),
            addNoteButton.leadingAnchor.constraint(equalTo: addNoteContainer.contentView.leadingAnchor, constant: 8),
            addNoteButton.trailingAnchor.constraint(equalTo: addNoteContainer.contentView.trailingAnchor, constant: -8)
        ])
    }

    private func setupTripNoteCard() {
        tripNoteCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tripNoteCard)

        let widthConstraint = tripNoteCard.widthAnchor.constraint(equalToConstant: 273)
        widthConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            tripNoteCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            tripNoteCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            widthConstraint,
            tripNoteCard.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -32),
            tripNoteCard.heightAnchor.constraint(equalToConstant: 339)
        ])

        tripNoteCard.applyPresentationState(.hidden)
    }

    private func bindViewModel() {
        viewModel.onMarkersUpdated = { [weak self] markers in
            self?.renderMarkers(markers)
        }
        viewModel.onOverlaysUpdated = { [weak self] overlays in
            self?.renderOverlays(overlays)
        }
        viewModel.onNotePreviewModelChanged = { [weak self] model in
            guard let self else { return }
            if let model {
                self.showNotePreviewCard(model: model)
            } else {
                self.hideNotePreviewCard(animated: true)
            }
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

    private func showNotePreviewCard(model: TripNotePreviewViewModel) {
        tripNoteCard.configure(with: model)
        tripNoteCard.isUserInteractionEnabled = true
        tripNoteCard.applyPresentationState(.visible)
    }

    private func hideNotePreviewCard(animated: Bool) {
        guard !tripNoteCard.isHidden else { return }
        let animations = {
            self.tripNoteCard.alpha = 0
            self.tripNoteCard.transform = CGAffineTransform(translationX: 0, y: 10)
        }
        let completion: (Bool) -> Void = { _ in
            self.tripNoteCard.isUserInteractionEnabled = false
            self.tripNoteCard.applyPresentationState(.hidden)
        }
        if animated {
            UIView.animate(withDuration: 0.18, animations: animations, completion: completion)
        } else {
            animations()
            completion(true)
        }
    }

    @objc private func didTapMapBackground(_ recognizer: UITapGestureRecognizer) {
        viewModel.didTapOnMapBackground()
    }

    @objc private func didTapAddNote() {
        viewModel.didTapAddNote()
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is CountryVisitAnnotation else { return nil }
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: CountryVisitAnnotationView.reuseIdentifier, for: annotation)
        view.annotation = annotation
        return view
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? CountryVisitAnnotation else { return }
        viewModel.didSelectMarker(annotation.marker)
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return MKOverlayRenderer(overlay: overlay)
    }
}

extension MapViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: tripNoteCard) == true {
            return false
        }
        if touch.view is MKAnnotationView || touch.view?.superview is MKAnnotationView {
            return false
        }
        return true
    }
}
