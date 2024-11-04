//
//  MovementDetailView.swift
//  MyBudgetFollower
//
//  Created by Anthony Baumle on 30/09/2024.
//

import SwiftUI

struct MovementDetailView: View {
	var movement: Movement
	
	var body: some View {
		VStack {
			Text("Montant: \(movement.amount, specifier: "%.2f")")
			Text("Description: \(movement.mouvementdescription ?? "Sans description")")
			Text("Date: \(movement.date.formatted(date: .long, time: .shortened) )")
		}
		.padding()
		.navigationTitle("Détail du mouvement")
	}
}

#Preview {
	MovementDetailView(movement: Movement(id: 1, accountId: 1,accountToId: nil, amount: 50.0, mouvementdescription:"Achat Café", date: Date()))
}
