//
//  Storage.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 27.06.2022.
//

import Foundation
import CoreData

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
            grades.forEach({
                _ = Grade(response: $0,
                          context: context)
            })
            
            try? context.save()
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    func getGrades() -> [GradeModel] {
        if let cacheGrades = cacheGrades {
            return cacheGrades
        }
        let context = PersistenceController.viewContext
        let request: NSFetchRequest<Grade> = Grade.fetchRequest()
        return context.performAndWait {
            let list = try? request.execute().map({ GradeModel(dbModel: $0) })
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
            products.forEach({
                _ = Product(response: $0,
                            context: context)
            })
            
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
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        return context.performAndWait {
            let list = try? request.execute().map({ ProductModel(dbModel: $0) })
            return list ?? []
        }
    }
    
    // MARK: - Private
    private func deleteGrades(context: NSManagedObjectContext,
                              save: Bool) {
        let request: NSFetchRequest<Grade> = Grade.fetchRequest()
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
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        let objects = try? context.fetch(request)
        objects?.forEach({
            context.delete($0)
        })
        if save {
            try? context.save()
        }
    }
}
