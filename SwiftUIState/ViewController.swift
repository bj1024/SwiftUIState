//


import UIKit
import SwiftUI
import Combine


class ViewController: UIViewController {
  let viewModel = ViewModel() // 共有データを持つ ViewModel を作成
  private var cancellables: Set<AnyCancellable> = []

  @IBOutlet weak var containerView: UIView!
  
  @IBOutlet weak var countLabel: UILabel!
  
  var timer: Timer?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    // SwiftUIのビューをUIHostingControllerに埋め込む
    let swiftUIView = MyView(viewModel: viewModel)
    let hostingController = UIHostingController(rootView: swiftUIView)
    
    // レイアウト制約を追加してSwiftUIビューを表示
    addChild(hostingController)
    containerView.addSubview(hostingController.view)
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    hostingController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
    hostingController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    hostingController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
    hostingController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    hostingController.didMove(toParent: self)
    
    viewModel.count = 100
    
    // ViewModelのcountプロパティを監視して更新を受け取る
    viewModel.$count
      .sink { [weak countLabel] newValue in
        print("count: \(newValue)")
        
        countLabel?.text = "\(newValue)"
      }
      .store(in: &cancellables)
    

    
    // タイマーをセットアップし、1秒ごとに `updateTimer` メソッドを呼び出す
    timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    
  }

  @objc func updateTimer() {
    viewModel.count += 1
    
  }

  
  override func viewWillDisappear(_ animated: Bool) {
    timer?.invalidate()
    timer = nil
  }

  
}

