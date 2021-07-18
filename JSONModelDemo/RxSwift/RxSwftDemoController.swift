//
//  RxSwftDemoController.swift
//  JSONModelDemo
//
//  Created by JIANLE CHEN on 2021/7/4.
//

import UIKit

class RxSwftDemoController: UIViewController {
    
    // MARK: - Get & Set
    lazy var disposeBag = DisposeBag()
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "RxSwiftDemo"
        
        setupUI()
        setupLayout()
        
        test()
    }
    
    // MARK: - SetupUI
    func setupUI() {
    }
    
    // MARK: - Layout
    func setupLayout() {
 
    }
    
    // MARK: - Private func
    private func test() {
        getRepo(repo: "ReactiveX/RxSwift").subscribe { (json) in
            print(json)
        } onFailure: { (error) in
            print(error)
        } onDisposed: {
            print("Disposed")
        }.disposed(by: disposeBag)
    }
    
    private func getRepo(repo: String) -> Single<[String: Any]> {
        return Single<[String: Any]>.create { (single) -> Disposable in
            let url = URL(string: "https://api.github.com/repos/\(repo)")!
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    single(.failure(error))
                    return
                }
                
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                      let result = json as? [String: Any] else {
                    single(.failure(DataError.parseError))
                    return
                }
                
                single(.success(result))
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    // MARK: - Public func

    // MARK: - deinit
    deinit {
        print(#function)
    }

}
