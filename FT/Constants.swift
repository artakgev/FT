//
//  Constants.swift
//  FT
//
//  Created by Artak Gevorgyan on 07 Oct, 2023
//  Copyright © 2023 Artak Gevorgyan. All rights reserved.
//

import Foundation

struct Constants {
    enum Environment {
        case debugTest
        case debugProd
        case qaTest
        case qaProd
        case tfTest
        case tfProd
        case appStore
    }

    static var env: Environment {
#if DEBUG_TEST
        return .debugTest
#elseif DEBUG_PROD
        return .debugProd
#elseif QA_TEST
        return .qaTest
#elseif QA_PROD
        return .qaProd
#elseif TF_TEST
        return .tfTest
#elseif TF_PROD
        return .tfProd
#elseif APP_STORE
        return .appStore
#else
        return .debugTest
#endif
    }
    
    static var isTestEnv: Bool = (env == .debugTest || env == .qaTest || env == .tfTest)
    static var defaultLengthOfAmountField: Int = 15
    
}

extension Constants {
    
    static var apiVersion = "v1"
    
    static var baseUrl: String {
        switch env {
        case .debugTest,
                .qaTest,
                .tfTest:
//            return String(format: "%@/%@/%@/", "https://someURL/api",
//                          LanguageManager.shared.current.rawValue, apiVersion)
            return String(format: "%@/%@", "https://d3jbb8n5wk0qxi.cloudfront.net", "recipes.json")

        case .debugProd,
                .qaProd,
                .tfProd,
                .appStore:
            return String(format: "%@/%@", "https://d3jbb8n5wk0qxi.cloudfront.net", "recipes.json")
        }
    }
    static var malformedDataURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"

    static var baseAuthorization = "Authorization"
    
    static var authValue: String {
        return String(format: "Bearer %@", "")//DriverManager.shared.getJwt() ?? "")
    }
    
    static var responseDefaultKeyPath: String = "data"
}
