//
//  Storage.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 27.06.2022.
//

import Foundation
import CoreData

typealias AppData = (brands: [BrandModel],
                         products: [ProductModel],
                         grades: [GradeModel])

final class Storage: ObservableObject {
    
    static var shared: Storage = Storage()
    
    private init() {}
    
    private var cacheGrades: [GradeModel]?
    private var cacheBrands: [BrandModel]?
    private var cacheProducts: [ProductModel]?
    
    func store(grades: [GradeModel]) {
        cacheGrades = grades
        let context = PersistenceController.newBackgroundContext()
        context.perform {[weak self] in
            guard let self = self else { return }
            self.deleteGrades(context: context,
                              save: false)
            
            _ = GradesList(grades: grades,
                           context: context)
            
            try? context.save()
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    /**
     Returns a list of grades sorter by `priority` paremter
     - Returns: an array of `GradeModel` objects
     */
    
    func getGrades() -> [GradeModel] {
        if let cacheGrades = cacheGrades {
            return cacheGrades
        }
        let context = PersistenceController.viewContext
        let request: NSFetchRequest<GradesList> = GradesList.fetchRequest()
        return context.performAndWait {
            guard let dbModel = try? request.execute().first else {
                return []
            }
            let list = dbModel.grades?.map({
                GradeModel(dbModel: $0 as! Grade)
            }).sorted(by: { $0 < $1 })
            cacheGrades = list
            return list ?? []
        }
    }
    
    func store(brands: [BrandModel]) {
        cacheBrands = brands
        let context = PersistenceController.newBackgroundContext()
        context.perform {[weak self] in
            guard let self = self else { return }
            self.deleteBrands(context: context,
                              save: false)
            brands.forEach({
                _ = Brand(response: $0,
                          context: context)
            })
            
            try? context.save()
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    func getBrands() -> [BrandModel] {
        if let cacheBrands = cacheBrands {
            return cacheBrands
        }
        let context = PersistenceController.viewContext
        let request: NSFetchRequest<Brand> = Brand.fetchRequest()
        return context.performAndWait {
            let list = try? request.execute().map({ BrandModel(dbModel: $0) })
            cacheBrands = list?.sorted(by: {
                ($0.name ?? "").compare($1.name ?? "") == .orderedAscending
            })
            return list ?? []
        }
    }
    
    func store(products: [ProductModel]) {
        cacheProducts = products
        let context = PersistenceController.newBackgroundContext()
        context.perform {[weak self] in
            guard let self = self else { return }
            self.deleteProducts(context: context,
                                save: false)
            
            _ = ProductsList(products: products,
                             context: context)
            
            try? context.save()
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    func getProducts() -> [ProductModel] {
        if let cacheProducts = cacheProducts {
            return cacheProducts
        }
        let context = PersistenceController.viewContext
        let request: NSFetchRequest<ProductsList> = ProductsList.fetchRequest()
        return context.performAndWait {
            guard let dbModel = try? request.execute().first else {
                return []
            }
            let list = dbModel.products?.map({
                ProductModel(dbModel: $0 as! Product)
            })
            cacheProducts = list
            return list ?? []
        }
    }
    
    func store(data: AppData) {
        var brandsToStore = [BrandModel]()
        data.brands.forEach({
            var brand = $0
            brand.gradeModel = data.grades.first(where: {
                $0.originalName?.lowercased() == brand.grade?.lowercased()
            }) ?? GradeModel.unknown()
            brand.products = data.products.filter({
                $0.brandName?.lowercased() == brand.name?.lowercased()
            })
            brandsToStore.append(brand)
        })
        
        let context = PersistenceController.newBackgroundContext()
        
        deleteGrades(context: context,
                     save: false)
        deleteBrands(context: context,
                     save: false)
        deleteProducts(context: context,
                       save: false)
        
        cacheGrades = data.grades
        cacheBrands = brandsToStore
        cacheProducts = data.products
        
        context.perform {
            // GradesList
            _ = GradesList(grades: data.grades,
                           context: context)
            
            // Brands
            brandsToStore.forEach({
                _ = Brand(response: $0,
                          context: context)
            })
            
            // Products
            _ = ProductsList(products: data.products,
                             context: context)
            
            try? context.save()
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    func hasAllDataLoaded() -> Bool {
        let grades = getGrades()
        let brands = getBrands()
        let products = getProducts()
        
        return !grades.isEmpty && !brands.isEmpty && !products.isEmpty
    }
    
    // MARK: - Private
    private func deleteGrades(context: NSManagedObjectContext,
                              save: Bool) {
        let request: NSFetchRequest<GradesList> = GradesList.fetchRequest()
        let objects = try? context.fetch(request)
        objects?.forEach({
            context.delete($0)
        })
        if save {
            try? context.save()
        }
    }
    
    private func deleteBrands(context: NSManagedObjectContext,
                              save: Bool) {
        let request: NSFetchRequest<Brand> = Brand.fetchRequest()
        let objects = try? context.fetch(request)
        objects?.forEach({
            context.delete($0)
        })
        if save {
            try? context.save()
        }
    }
    
    private func deleteProducts(context: NSManagedObjectContext,
                                save: Bool) {
        let request: NSFetchRequest<ProductsList> = ProductsList.fetchRequest()
        let objects = try? context.fetch(request)
        objects?.forEach({
            context.delete($0)
        })
        if save {
            try? context.save()
        }
    }
}
