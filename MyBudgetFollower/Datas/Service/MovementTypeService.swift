//
//  MovementService.swift
//  MyBudgetFollower
//
//  Created by Anthony Baumle on 30/09/2024.
//

import Supabase
import Foundation

class MovementService {
	let client: SupabaseClient
	
	static let shared = MovementService(client: SupabaseClient(
		supabaseURL: URL(string: "https://tegpfqpzlcepfermqecy.supabase.co")!,
		supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRlZ3BmcXB6bGNlcGZlcm1xZWN5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjc2NzYxODMsImV4cCI6MjA0MzI1MjE4M30.EkYfV-u0qTcSEjAGbUViMt-G7x0aUZvzIXVszfKBAyg"
	))

	init(client: SupabaseClient) {
		self.client = client
	}

	func fetchAllMovements() async -> [Movement] {
		var movements: [Movement] = []
		
		do {
			movements = try await client
				.from("MOUVEMENT")  // Assurez-vous que la table se nomme bien "movements" dans Supabase
				.select()
				.execute()
				.value
		} catch {
			print("Erreur lors de la récupération des mouvement : \(error)")
		}
		
		return movements
	}
	
	func lazyfetchAllMovements(startRange: Int, endRange: Int) async -> [Movement] {
		var movements: [Movement] = []
		
		do {
			movements = try await client
				.from("MOUVEMENT")  // Assurez-vous que la table se nomme bien "movements" dans Supabase
				.select()
				.order("date", ascending: false)
				.range(from: startRange, to: endRange)
				.execute()
				.value
		} catch {
			print("Erreur lors de la récupération des mouvement : \(error)")
		}
		
		return movements
	}
	
	// Mettre à jour un compte existant
	func updateMovement(movement: Movement) async {
		do {
			try await client
				.from("MOUVEMENT")
				.update(movement)
				.eq("id", value: movement.id)
				.execute()
		} catch {
			print("Erreur lors de la mise à jour du mouvement : \(error)")
		}
	}
		
	// Créer un nouveau compte
	func createMovement(movement: Movement) async {
		do {
			try await client
				.from("MOUVEMENT")
				.insert(movement)
				.execute()
		} catch {
			print("Erreur lors de la création du mouvement : \(error)")
		}
	}
	
	// Créer plusieurs comptes
	func createMovements(movements: [Movement]) async {
		do {
			try await client
				.from("MOUVEMENT")
				.insert(movements)
				.execute()
		} catch {
			print("Erreur lors de la création des mouvements : \(error)")
		}
	}
	
	// Supprimer un compte
	func deleteMovement(movementID: Int) async {
		do {
			try await client
				.from("MOUVEMENT")
				.delete()
				.eq("id", value: movementID)
				.execute()
		} catch {
			print("Erreur lors de la suppression du mouvement : \(error)")
		}
	}
	
	// Get highest ID
	func getHighestId() async -> Int {
		
		var highestMovement: [Movement]
		var id = 0
		do {
			highestMovement = try await client
			  .from("MOUVEMENT")
			  .select()
			  .order("id", ascending: false)
			  .limit(1)
			  .execute()
			  .value
			
			if (!highestMovement.isEmpty && highestMovement.first != nil)
			{
				id = highestMovement.first!.id
			}
			
		} catch {
			print("Erreur lors de la reception de l'ID le plus grande : \(error)")
		}
		
		return id
	}
}
