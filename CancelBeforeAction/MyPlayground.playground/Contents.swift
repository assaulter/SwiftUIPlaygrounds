//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import SwiftUI

// 連打された場合に、以前のタスクをキャンセルする方法
// 参考：https://zenn.dev/treastrain/articles/3effccd39f4056
// キャンセル処理を、SwiftUIのtaskに任せる
struct ContentView: View {
    
    @State private var triggers: Bool?
    
    var body: some View {
        VStack {
            Button("Action!") {
                if triggers == nil {
                    triggers = true
                } else {
                    triggers?.toggle()
                }
            }
        }
        .task(id: triggers) {
            guard triggers != nil else { return }
            do {
                try await exec()
            } catch {
                // ...
            }
        }
    }
    
    private func exec() async throws -> String {
        print("exec before")
        try await Task.sleep(nanoseconds: 2_000_000_000) // wait 2 sec
        print("exec after")
        return "hogehoge"
    }
}

// Present the view controller in the Live View window
let host: UIHostingController = .init(rootView: ContentView())
PlaygroundPage.current.liveView = host
