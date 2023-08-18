//


import UIKit
import SwiftUI
import Combine


class ViewController: UIViewController {
  let viewModel = ViewModel() // 共有データを持つ ViewModel を作成
  private var cancellables: Set<AnyCancellable> = []


  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    // SwiftUIのビューをUIHostingControllerに埋め込む
    let swiftUIView = MyView(viewModel: viewModel)
    let hostingController = UIHostingController(rootView: swiftUIView)
    
    // レイアウト制約を追加してSwiftUIビューを表示
    addChild(hostingController)
    view.addSubview(hostingController.view)
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    hostingController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    hostingController.didMove(toParent: self)
    
    let label = UILabel()
    view.addSubview(label)

    // ViewModelのcountプロパティを監視して更新を受け取る
    viewModel.$count
        .sink { [weak label] newValue in
          print("count: \(newValue)")
          
            label?.text = "Count: \(newValue)"
        }
        .store(in: &cancellables)

    // ここでViewModelのcountを変更することができます
    viewModel.count = 10
    
    
  }
  
  
}

