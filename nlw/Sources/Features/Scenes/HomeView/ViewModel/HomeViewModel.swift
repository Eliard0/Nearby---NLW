//
//  HomeViewModel.swift
//  nlw
//
//  Created by Eliardo Venancio on 14/12/24.
//

import Foundation
import CoreLocation

class HomeViewModel {
    private let baseURL = "http:/127.0.0.1:3333"
    var useLatitude = -23.561187293883442
    var userLongitude = -46.656451388116494
    
    var didUpdateCategories: (() -> Void)?
    var didUpdatePlaces: (() -> Void)?
    
    var places: [Place] = []
    var filterPlaces: [Place] = []
    
    func fetchInitialData(completion: @escaping ([Category]) -> Void) {
        fetchCategories { categories in
            if let foodCategory = categories.first(where: {$0.name == "Alimentação"}){
                self.fetchPlaces(for: foodCategory.id, userLocation: CLLocationCoordinate2D(latitude: self.useLatitude, longitude: self.userLongitude))
            }
        }
    }
    
    private func fetchCategories(completion: @escaping ([Category]) -> Void) {
        guard let url = URL(string: "\(baseURL)/categories") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("deu erro")
                return
            }
            
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let categories = try JSONDecoder().decode([Category].self, from: data)
                DispatchQueue.main.sync {
                    completion(categories)
                }
            } catch {
                completion([])
            }
            
        }.resume()
    }
    
    private func fetchPlaces(for categoryID: String, userLocation: CLLocationCoordinate2D) {
        guard let url = URL(string: "\(baseURL)/markets/category/\(categoryID)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("deu erro")
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                self.places = try JSONDecoder().decode([Place].self, from: data)
                DispatchQueue.main.sync {
                    self.didUpdatePlaces?()
                }
            } catch {
                print("error")
            }
            
        }.resume()
    }
}
