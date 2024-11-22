//
//  RecipesVC.swift
//  FT
//
//  Created by Artak Gevorgyan on 16.11.24.
//

import UIKit

class SplashVC: BaseVC, BaseVCProtocol {
    
    // MARK: - Public properties
        
    var vm = SplashVM()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.vm.openRecipesView()
    }

    // MARK: - Override methods
    
    func initUIElements() {
    }

    // MARK: - VMToVCExchange protocol methods

    override func dataFetched<T>(type: T.Type, data: T?, observerName: String) {
    }

    override func invalidDataErrorReceived<T>(fieldType: T.Type, data: [String: String]) {
        
    }
    
}

