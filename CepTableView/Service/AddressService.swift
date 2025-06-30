//
//  AddressService.swift
//  CepTableView
//
//  Created by Mairton Leal on 28/12/23.
//

import Foundation
import RxSwift

class AddressService {
    
    var address: Address?
    
//    func fetchAddress(cep: String, completion: @escaping (Result<Address, Error>) -> Void) {
//            // Aqui você faria a chamada à API para obter os dados do endereço usando o CEP
//            // Neste exemplo, vamos simular uma chamada assíncrona
//
//            DispatchQueue.global().async {
//                // URL da API ViaCEP para consulta por CEP
//                let url = URL(string: "https://viacep.com.br/ws/\(cep)/json")!
//
//                do {
//                    let data = try Data(contentsOf: url)
//                    let decodedAddress = try JSONDecoder().decode(Address.self, from: data)
//
//                    DispatchQueue.main.async {
//                        self.address = decodedAddress
//                        completion(.success(decodedAddress))
//                    }
//                } catch {
//                    DispatchQueue.main.async {
//                        completion(.failure(error))
//                    }
//                }
//            }
//        }
    
    func getAddress(for cep: String) -> Observable<Address> {
        let apiURL = "https://viacep.com.br/ws/\(cep)/json"
              guard let url = URL(string: apiURL) else {
                  return Observable.error(NSError(domain: "URL invalida", code: 0, userInfo: nil))
              }
              
              return Observable.create { observer in
                  Task.init {
                         do {
                             let (data, _) = try await URLSession.shared.data(from: url)
                             
                             let address = try JSONDecoder().decode(Address.self, from: data)
                             observer.onNext(address)
                             observer.onCompleted()
                         } catch {
                             observer.onError(error)
                         }
                     }

                     return Disposables.create()
                 }
        }
}
