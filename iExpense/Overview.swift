//
//  Overview.swift
//  iExpense
//
//  Created by Edmond Podlegaev on 13.04.2023.
//

import SwiftUI

class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct Overview: View {
    @State private var user = User()

    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
        }
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview()
    }
}
