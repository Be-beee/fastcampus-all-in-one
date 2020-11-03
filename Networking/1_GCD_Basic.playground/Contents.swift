import UIKit

// MARK:- Queue: Main, Global, Custom

// - Main
DispatchQueue.main.async {
    let view = UIView()
    view.backgroundColor = .darkGray
    // UI작업
}

// - Global
DispatchQueue.global(qos: .userInteractive).async {
    // 제일 중요한 작업
}
DispatchQueue.global(qos: .userInitiated).async {
    // 거의 바로 해줘야할 작업, 사용자가 결과를 기다리는 작업
}
DispatchQueue.global(qos: .default).async {
    // 거의 사용하지 않는다
}
DispatchQueue.global(qos: .utility).async {
    // 시간이 좀 걸리는 일들, 사용자가 당장 기다리지 않는 것, 네트워킹, 큰 파일 불러올 때 등등
}
DispatchQueue.global(qos: .background).async {
    // 사용자한테 당장 인식될 필요가 없는 것들, 뉴스데이터 미리 받기, 위치 업데이트, 영상 다운 받기 등
}

// - Custom
let concurrentQueue = DispatchQueue(label: "concurrent", qos: .background, attributes: .concurrent)
let serialQueue = DispatchQueue(label: "serial", qos: .background)
// 사용자가 직접 디스패치큐를 만들어 사용할 수 있다.


// MARK:- 복합적인 상황

func downloadImageFromServer() -> UIImage {
    // Heavy Task
    
    return UIImage()
}
func updateUI(image: UIImage) {
    
}

DispatchQueue.global(qos: .background).async {
    // download
    let image = downloadImageFromServer()
    
    DispatchQueue.main.async {
        // update ui
        updateUI(image: image)
    }
}

// MARK:- Sync, Async

// Async

DispatchQueue.global(qos: .background).async {
    for i in 0...5 {
        print("😈 \(i)")
    }
}

DispatchQueue.global(qos: .userInteractive).async {
    for i in 0...5 {
        print("☺️ \(i)")
    }
}

// Sync

DispatchQueue.global(qos: .background).sync {
    for i in 0...5 {
        print("😈 \(i)")
    }
}

DispatchQueue.global(qos: .userInteractive).async {
    for i in 0...5 {
        print("☺️ \(i)")
    }
}
