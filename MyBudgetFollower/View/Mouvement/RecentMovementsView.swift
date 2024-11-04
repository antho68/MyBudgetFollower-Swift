//
//  RecentMovementsView.swift
//  MyBudgetFollower
//
//  Created by Anthony Baumle on 30/09/2024.
//

import SwiftUI

struct RecentMovementsView: View {
	@State private var movements: [Movement] = []
	
	var body: some View {
		NavigationView {
			List(movements, id: \.id) { movement in
				NavigationLink(destination: MovementDetailView(movement: movement)) {
					VStack(alignment: .leading) {
						Text(movement.mouvementdescription ?? "Sans description")
						Text("Montant: \(movement.amount, specifier: "%.2f")")
							.font(.subheadline)
							.foregroundColor(.gray)
					}
				}
			}
			.navigationTitle("Mouvements récents")
		}
		.onAppear {
			// Appeler le service pour récupérer les mouvements récents
			fetchRecentMovements()
		}
	}
	
	// Simuler la récupération des mouvements (utiliser un service réel ici)
	func fetchRecentMovements() {
		// Récupérer les mouvements via MovementService (à implémenter selon l'API)
		// Exemple:
		// movementService.fetchRecentMovements { result in
		//    ...
		// }
	}
}

#Preview {
	
	@Previewable @State var tmpMovements: [Movement] = [
		Movement(id: 1, accountId: 1,
				 accountToId: nil, amount: 50.0, mouvementdescription: "Achat Café", date: Date()),
		Movement(id: 2, accountId: 2,
				 accountToId:nil,amount: 100.0, mouvementdescription: "Paiement Facture", date: Date())
	]
	
	return RecentMovementsView()
}
