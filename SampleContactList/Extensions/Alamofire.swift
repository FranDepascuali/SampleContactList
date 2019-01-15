//
//  Alamofire.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 13/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

// Taken from https://gist.github.com/maoyama/ff16f1ce80b8cf45f854e7bbb1d5f32f
import Foundation
import ReactiveSwift
import ReactiveCocoa
import Alamofire
import SwiftyJSON
//import Result

protocol RequestServiceType {

    func request(URL: String) -> SignalProducer<JSON, NoError>
}

struct RequestService: RequestServiceType {

    func request(URL: String) -> SignalProducer<JSON, NoError> {
        return SignalProducer.init { observer, lifetime in
            Alamofire.request(URL)
                .responseJSON { (responseData) -> Void in
                    if((responseData.result.value) != nil) {
                        let swiftyJsonVar = JSON(responseData.result.value!)
                        print(swiftyJsonVar)
                        observer.send(value: swiftyJsonVar)
                        observer.sendCompleted()
                    }
            }
        }
    }

}





//private let defaultSessionError = NSError(domain: "Reactivity.Alamofiew.SessionManager.dataWithRequest",
//                                          code: 1,
//                                          userInfo: nil)
//
//extension SessionManager : ReactiveExtensionsProvider {
//}
//
//extension Reactive where Base: SessionManager {
//
//    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> SignalProducer<(Data, URLResponse), AnyError> {
//        return SignalProducer { [base = self.base] observer, lifetime in
//            let dataRequest = base.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
//            dataRequest.response { (dataResponce) in
//                if let data = dataResponce.data, let responce = dataResponce.response {
//                    observer.send(value: (data, responce))
//                    observer.sendCompleted()
//                } else {
//                    observer.send(error: AnyError(dataResponce.error ?? defaultSessionError))
//                }
//            }
//            lifetime.observeEnded {
//                dataRequest.cancel()
//            }
//            dataRequest.resume()
//        }
//    }
//
//}
