//
//  AddressRepository.swift
//  CepTableView
//
//  Created by Mairton Leal on 28/12/23.
//

import Foundation
import RxSwift

class AddressRepository {

    private let apiService: AddressService

    init(apiService: AddressService = AddressService()) {
        self.apiService = apiService
    }

    func getAddress(for cep: String) -> Observable<Address> {
        return apiService.getAddress(for: cep)
    }
}
