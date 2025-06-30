//
//  AddressViewModel.swift
//  CepTableView
//
//  Created by Mairton Leal on 28/12/23.
//

import Foundation
import RxSwift

class AddressViewModelFactory {
    static func create() -> AddressViewModelProtocol {
        return AddressViewModel()
    }
}

protocol AddressViewModelProtocol {
    func createLayout(result: Address)
    var layout: PublishSubject<[VModel]> { get }
}

class AddressViewModel: AddressViewModelProtocol {
    var layout: PublishSubject<[VModel]> = PublishSubject()
    private let cepRepository: AddressRepository

        var address: Observable<Address> {
            return addressSubject.asObservable()
        }

        private let addressSubject = PublishSubject<Address>()

        init(cepRepository: AddressRepository = AddressRepository()) {
            self.cepRepository = cepRepository
        }
    
//    
//    var address: Address?
//    
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
    
    func fetchAddress(for cep: String) {
           cepRepository.getAddress(for: cep)
               .subscribe(onNext: {[weak self] address in
                   self?.addressSubject.onNext(address)
               }, onError: { error in
                   print("Ocorreu um erro \(error.localizedDescription)")
               })
               .disposed(by: disposeBag)
       }

       private let disposeBag = DisposeBag()
    
    
    func createLayout(result: Address) {
        var rows: [VModel] = []
        rows.append(
            CellModels.Text(text: result.uf,
                            color: UIColor.black,
                            alignment: .center,
                            constraintTop: 8.0,
                            constraintBottom: 16.0)
        )
        rows.append(
            CellModels.Text(text: result.logradouro,
                            color: UIColor.black,
                            alignment: .center,
                            constraintTop: 8.0,
                            constraintBottom: 16.0)
        )
        rows.append(
            CellModels.Text(text: result.bairro,
                            color: UIColor.black,
                            alignment: .center,
                            constraintTop: 8.0,
                            constraintBottom: 16.0)
        )
        
        
        layout.onNext(rows)

    }
    
}
