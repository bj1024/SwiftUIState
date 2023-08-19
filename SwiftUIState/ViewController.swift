//


import UIKit
import SwiftUI
import Combine


class ViewController: UIViewController {
  let viewModel = ViewModel() // 共有データを持つ ViewModel を作成
  private var cancellables: Set<AnyCancellable> = []

  @IBOutlet weak var containerView: UIView!
  
  @IBOutlet weak var countLabel: UILabel!
  
  
  
  //タイマー作成
  var timer:  DispatchSourceTimer?
      
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
      .receive(on: DispatchQueue.main)
      .sink { [weak countLabel] newValue in
        print("count: \(newValue)")
        
        countLabel?.text = "\(newValue)"
      }
      .store(in: &cancellables)
    

  
    self.timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
    if let timer = self.timer {
      timer.schedule(deadline: DispatchTime.now(), repeating: 1.0)
      timer.setEventHandler {
        print("timer fired! count \(self.viewModel.count )")
        DispatchQueue.main.async {
          self.viewModel.count += 100
        }
      }
      timer.resume()
    }
  }


  
  override func viewWillDisappear(_ animated: Bool) {
    timer?.cancel()
    timer = nil
  }

  
}

