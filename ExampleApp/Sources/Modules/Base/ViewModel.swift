import Combine
import SwiftUI

protocol ViewModel: ObservableObject where ObjectWillChangePublisher.Output == Void {
    associatedtype State
    associatedtype Action

    var state: State { get }
    func handle(action: Action)
}

@dynamicMemberLookup
final class AnyViewModel<State, Action>: ObservableObject {

    private let _objectWillChange: () -> AnyPublisher<Void, Never>
    private let _state: () -> State
    private let _handle: (Action) -> Void

    var objectWillChange: AnyPublisher<Void, Never> { _objectWillChange() }

    var state: State { _state() }

    func handle(action: Action) { _handle(action) }

    subscript<Value>(dynamicMember keyPath: KeyPath<State, Value>) -> Value {
        state[keyPath: keyPath]
    }

    init<V: ViewModel>(_ viewModel: V) where V.State == State, V.Action == Action {
        self._objectWillChange = { viewModel.objectWillChange.eraseToAnyPublisher() }
        self._state = { viewModel.state }
        self._handle = viewModel.handle
    }

}

extension ViewModel {
    var any: AnyViewModel<State, Action> { AnyViewModel(self) }
}

extension AnyViewModel: Identifiable where State: Identifiable {
    var id: State.ID {
        state.id
    }
}
