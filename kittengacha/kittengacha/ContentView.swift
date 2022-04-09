//
//  ContentView.swift
//  kittengacha
//
//  Created by Jonathan Pang on 4/9/22.
//
 
import SwiftUI
import MapKit
 
struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
   
    var body: some View {
        VStack {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .ignoresSafeArea()
                .onAppear {
                    viewModel.checkIfLocationServicesIsEnabled()
                }
            HStack {
                Button("Press") {
                    viewModel.checkIfLocationServicesIsEnabled()
                }
                .frame(width: UIScreen.main.bounds.width / 5 * 2, height: UIScreen.main.bounds.height / 32)
                Button("Press") {
                    viewModel.checkIfLocationServicesIsEnabled()
                }
                .frame(width: UIScreen.main.bounds.width / 5 * 2, height: UIScreen.main.bounds.height / 32)
            }
            
            
        }
        
        
    }
}
 
class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    @Published var region = MKCoordinateRegion()
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Not enabled")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                print("\(locationManager.location!.coordinate)")
            default:
                break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
