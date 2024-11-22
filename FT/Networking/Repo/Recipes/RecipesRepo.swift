//
//  RecipesRepo.swift
//  FT
//
//  Created by Areg on 11/14/23.
//  Copyright © 2023 Artak Gevorgyan. All rights reserved.
//

import Alamofire

enum RecipesRepoTargetType: LXTargetType {
    
    case getRecipes
    
    var baseURL: String {
        switch self {
        default:
            return LXGlobalRepoParams.baseURL.value
        }
    }
    
    var path: String {
        switch self {
        case .getRecipes:
            return ""
        }
    }
        
    var method: LXHTTPMethod {
        switch self {
        case .getRecipes:
            return .post
        }
    }
    
    var task: LXTask {
        switch self {
        case .getRecipes:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return [:]
        }
    }
}

class RecipesRepo: LXBaseRepository<RecipesRepoTargetType> {
    
    func getRecipes(completionHandler: @escaping ([Recipe]?, LXNetworkError?) -> Void) {
        return fetchData(target: .getRecipes,
                                 responseClass: [Recipe].self,
                         fromJsonFile: true) { result in
                    switch result {
                    case .success(let registerVerifyData):
                        completionHandler(registerVerifyData, nil)
                    case .failure(let error):
                        completionHandler(nil, error)
                    }
                }
    }    
}
