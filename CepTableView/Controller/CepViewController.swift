//
//  CepViewController.swift
//  ViaCepApp
//
//  Created by Mairton Leal on 27/12/23.
//

import UIKit
import RxSwift

class CepViewController: UIViewController {

   
    
    @IBOutlet weak var labelTableView: UITableView!
    @IBOutlet weak var cepTextField: UITextField!
    @IBOutlet weak var buttonPesquisar: UIButton!
    
//    private let viewModel = AddressViewModel()
    private var dataSource: UniqueViewDataSource<AddressCellFactory>?
    private let viewModel = AddressViewModel(cepRepository: AddressRepository(apiService: AddressService()))
       private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfigurations()
       
        _ = viewModel.layout.subscribe { event in
            if case .next(let rows) = event {
                self.dataSource?.update(models: rows)
                self.labelTableView.reloadData()
            }
        }
        carregarDadosNaUI()
    }

    
    @IBAction func searchButton(_ sender: UIButton) {
        guard let cep = cepTextField.text else { return }
        viewModel.fetchAddress(for: cep)
//        viewModel.fetchAddress(cep: cep) { result in
//            switch result {
//            case .success(let address):
//                self.exibirAlerta()
//                self.updatelUI(with: address)
//                
//            case .failure(_):
//                print("Erro na chamada")
//            }
//            
//        }
    }
    
    func carregarDadosNaUI() {
             let observableAddress = viewModel.address

             _ = observableAddress
              .observe(on: MainScheduler.instance)
              .subscribe(onNext: { address in
                 self.updateUI(with: address)
             }, onError: { error in
                 print("Erro: \(error)")
             }, onCompleted: {
                 print("Observação concluída.")
             }).disposed(by: disposeBag)
         }
   
    func exibirAlerta() {
        let alertController = UIAlertController(
            title: "Busca concluida", message: "Pesquisa Realizada",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func updateUI(with address: Address) {
//        logradouro.text = address.bairro
//        complemento.text = address.complemento
//        bairro.text = address.bairro
//        uf.text = address.uf
//        localidade.text = address.localidade
        viewModel.createLayout(result: address)
    }
    
    func setupConfigurations(){
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Api Via Cep"
        buttonPesquisar.setTitle("Pequisar", for: .normal)
        buttonPesquisar.tintColor = .blue
        
        self.dataSource = UniqueViewDataSource.make(tableView: labelTableView)
        labelTableView.dataSource = dataSource
        labelTableView.delegate = dataSource
        //dataSource?.delegate = self
        labelTableView.tableFooterView?.isHidden = true
    }
    
  
  
}

