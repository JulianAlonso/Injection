import Foundation

func async(on queue: DispatchQueue = .main, _ work: @escaping () -> Void) {
    DispatchQueue.global(qos: .userInitiated).async {
        queue.async { work() }
    }
}

func delay(_ time: DispatchTimeInterval, on queue: DispatchQueue = .main, _ work: @escaping () -> Void) {
    DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + time) {
        queue.async { work() }
    }
}
