//
//  PurchaseManager.swift
//  033DramaSlayer
//
//  Created by Владимир on 17.01.2025.
//


import Foundation
import StoreKit
import Combine
import ApphudSDK

final class PurchaseManager: NSObject {
    
    // MARK: - Properties
    
    private let paywallID = "main"
    private(set) var availableProducts: [ApphudProduct] = []
    
    var isProAccessAvailable: Bool {
        return true
//        Apphud.hasPremiumAccess()
    }
    
    // MARK: - Purchase Methods
    
    @MainActor
    func purchase(product: ApphudProduct, completion: @escaping (Result<Bool, Error>) -> Void) {
        Apphud.purchase(product) { result in
            if let error = result.error {
                debugPrint("Purchase error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            if let subscription = result.subscription, subscription.isActive() {
                debugPrint("Subscription is active: \(subscription.productId)")
                completion(.success(true))
            } else if let purchase = result.nonRenewingPurchase, purchase.isActive() {
                debugPrint("Non-renewing purchase is active: \(purchase.productId)")
                completion(.success(true))
            } else if Apphud.hasActiveSubscription() {
                debugPrint("Active subscription exists")
                completion(.success(true))
            } else {
                debugPrint("Purchase failed: No active subscription or purchase")
                completion(.success(false))
            }
        }
    }
    
    // MARK: - Paywalls
    
    @MainActor
    func fetchPaywalls(completion: @escaping () -> Void) {
        Apphud.paywallsDidLoadCallback { paywalls, _ in
            guard let paywall = paywalls.first(where: { $0.identifier == self.paywallID }) else {
                debugPrint("Paywall not found with ID: \(self.paywallID)")
                completion()
                return
            }
            
            Apphud.paywallShown(paywall)
            self.availableProducts = paywall.products
            
            debugPrint("Fetched products: \(self.availableProducts.map { $0.productId })")
            completion()
        }
    }
    
    // MARK: - Restore Purchases
    
    @MainActor
    func restorePurchases(completion: @escaping (Result<Bool, Error>) -> Void) {
        debugPrint("Restore started")
        
        Apphud.restorePurchases { subscriptions, _, error in
            if let error = error {
                debugPrint("Restore failed: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            if let subscription = subscriptions?.first, subscription.isActive() {
                debugPrint("Subscription restored and active: \(subscription.productId)")
                completion(.success(true))
            } else if Apphud.hasActiveSubscription() {
                debugPrint("Active subscription exists")
                completion(.success(true))
            } else {
                debugPrint("No active subscription found during restore")
                completion(.success(false))
            }
        }
    }
}
