import UIKit

class ViewController: UIViewController {

    let client = NetworkClient()
    var offset = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Empieza")
        get()
        print("Acaba")
    }




    func get() {
        offset += 1
        client.getCharacters(offset: offset) { result in
            switch result {
            case .success(let characters):
                print(characters.data?.results?.first as Any)
                // Refrescar la uitableview
                // self.tableview.reloadData()
            case .failure(let error):
                // Mostrar una alerta al usuarios con el errorDescription
                print(error.errorDescription)
            //                switch error {
            //                case .serverError(let description):
            //                    // Alerta al usuario que le haga li que sea
            //                    break
            //                case .dataError(let description):
            //                    // Redirigir al login
            //                    break
            //                case .serializationError(let description):
            //                    // Hacer n allamada al serivodr
            //                    break
            //                }
            }
        }
    }
}

