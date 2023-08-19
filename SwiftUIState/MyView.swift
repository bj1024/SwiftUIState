//


import SwiftUI

struct MyView: View {
  @ObservedObject var viewModel: ViewModel
  
  
  var body: some View {
    VStack{
      Text("count=\(viewModel.count)")
      ScrollViewReader { proxy in
        ScrollView {
          LazyVStack(alignment: .leading){
            ForEach(0..<viewModel.count, id: \.self) {
              Text("Row \($0 + 1)")
                .id($0 + 1)
            }
          }
          .onChange(of: viewModel.count) { _ in
            withAnimation {
              proxy.scrollTo(viewModel.count)
            }
          }
        }
      }

      Button(action: {
        self.viewModel.count += 1
      }) {
        Text("Increment")
      }
    }
  }
}

struct MyView_Previews: PreviewProvider {
  static var previews: some View {
    MyView(viewModel: ViewModel())
  }
}
