//
//  BaseViewModel.swift
//  FT
//
//  Created by Artak Gevorgyan on 07 Oct, 2023
//  Copyright © 2023 Artak Gevorgyan. All rights reserved.
//

import Foundation

protocol VMToVCExchange: AnyObject {
    func dataFetched<T>(type: T.Type, data: T?, observerName: String)
    func invalidDataErrorReceived<T>(fieldType: T.Type, data: [String: String])
    func errorReceived(error: LXNetworkError)
}

protocol BaseVCCoordinatorProtocol: CoordinatorBaseProtocol {

    func openLoginView()
}

class BaseVM {
    
    weak var baseDelegate: VMToVCExchange?
    weak var baseCoordinator: BaseVCCoordinatorProtocol?
    
//    let isLoading = BehaviorRelay(value: false)
//    let error = PublishSubject<Error>()
    
//    let pinVM = PublishSubject<PINViewModel>()
//    let pinSuccess = PublishSubject<Bool>()
//    
//    var disposeBag = DisposeBag()
//    
//    lazy var activity: ActivityIndicator = {
//        let act = ActivityIndicator()
//        act.asSharedSequence().drive(isLoading).disposed(by: disposeBag)
//        return act
//    }()
//    
    init() {
        
    }
//    
    deinit {
//        isLoading.accept(false)
    }
}

extension BaseVM: VMToVCExchange {
    
    func dataFetched<T>(type: T.Type, data: T?, observerName: String) {
        
    }

    func invalidDataErrorReceived<T>(fieldType: T.Type, data: [String: String]) {

    }
    func errorReceived(error: LXNetworkError) {

    }

}
