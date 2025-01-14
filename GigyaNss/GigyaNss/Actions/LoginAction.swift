//
//  LoginFlow.swift
//  GigyaNss
//
//  Created by Shmuel, Sagi on 25/02/2020.
//  Copyright © 2020 Gigya. All rights reserved.
//
import Gigya
import Flutter

class LoginAction<T: GigyaAccountProtocol>: Action<T> {
    
    init(businessApi: BusinessApiDelegate, jsEval: JsEvaluatorHelper) {        
        super.init()
        self.businessApi = businessApi
        self.jsEval = jsEval
    }

    override func next(method: ApiChannelEvent, params: [String: Any]?) {
        super.next(method: method, params: params)
        
        switch method {
        case .submit:
            guard let params = params else {
                return
            }

            let loginId = params["loginID"] as? String ?? ""
            let password = params["password"] as? String ?? ""
            
            businessApi?.callLogin(dataType: T.self, loginId: loginId, password: password, params: params, completion: delegate!.getMainLoginClosure(obj: T.self))
        default:
            break
        }
    }

    deinit {
        GigyaLogger.log(with: self, message: "deinit")
    }
}
