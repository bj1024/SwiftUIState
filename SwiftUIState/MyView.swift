//


import SwiftUI

struct MyView: View {
  @ObservedObject var viewModel: ViewModel


    var body: some View {
      VStack{
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Text("count=\(viewModel.count)")
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
