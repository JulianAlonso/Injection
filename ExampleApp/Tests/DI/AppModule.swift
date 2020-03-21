@testable import App
import Injection

let appModule = {
    Module {
        component { storageComponent }
        component { serviceComponent }
        component { useCaseComponent }
    }
}
