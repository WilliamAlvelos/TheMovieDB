//
//  ErrosEnum.swift
//  FastShop
//
//  Created by William Alvelos on 21/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import Foundation

enum Errors: Int, Error {
    case Unknown = 404
    case NoInternet = 401
    case AlamoFailure = 430
    case JSONReturnErro = 431
    case JSONNil = 432
    case JSONParseErro = 433

    var message: String {

        switch self {
        case .Unknown:
            return "Aconteceu um erro desconhecido, Tente Novamente"
        case .NoInternet:
            return "Verifique sua conexão com a Internet."
        case .AlamoFailure:
            return "Alamofire request failed"
        case .JSONReturnErro:
            return "Json request returned error"
        case .JSONNil:
            return "Não foi encontrado nada"
        case .JSONParseErro:
            return "Aconteceu um erro desconhecido, Tente Novamente"
        }
    }
    var _code: Int { return self.rawValue }
    
    static func validade(error: NSError) -> String {
        var message = ""
        
        switch error.code {
        case 3:
            message = "Não foi possivel acessar no momento"
            break
        case 4:
            message = "Verifique sua conexão com a Internet ou tente novamente mais tarde."
            break
        case -2102:
            message = "Verifique sua conexão com a Internet."
            break
        case -1009:
            message = "Verifique sua conexão com a Internet."
            break
        case 3840:
            message = "Serviço indisponível. Tente novamente mais tarde."
            break
        case -1001:
            message = "Verifique sua conexão com a Internet."
            break
        case Errors.NoInternet.rawValue:
            message = "Verifique sua conexão com a Internet."
            break
        case Errors.JSONReturnErro.rawValue:
            message = error.domain
            break
        case Errors.Unknown.rawValue:
            message = Errors.Unknown.message
            break
        default:
            print(error.code)
            message = "Verifique sua conexão com a Internet, ou tente novamente mais tarde."
            break
        }
        
        return message
    }
    
    
}

