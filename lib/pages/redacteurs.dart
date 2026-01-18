import 'package:flutter/material.dart';
import '../modele/redacteur.dart';
import '../database/database_manager.dart';

class RedacteurInterface extends StatefulWidget {
  const RedacteurInterface({super.key});

  @override
  _RedacteurInterfaceState createState() => _RedacteurInterfaceState();
}

class _RedacteurInterfaceState extends State<RedacteurInterface> {
  final DatabaseManager _dbManager = DatabaseManager();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  
  List<Redacteur> _redacteurs = [];

  @override
  void initState() {
    super.initState();
    _loadRedacteurs();
  }

  // Charger tous les rédacteurs depuis la base de données
  Future<void> _loadRedacteurs() async {
    final redacteurs = await _dbManager.getAllRedacteurs();
    setState(() {
      _redacteurs = redacteurs;
    });
  }

  // Ajouter un rédacteur
  Future<void> _ajouterRedacteur() async {
    if (_nomController.text.isEmpty || 
        _prenomController.text.isEmpty || 
        _emailController.text.isEmpty) {
      _showSnackBar('Veuillez remplir tous les champs');
      return;
    }

    final nouveauRedacteur = Redacteur.sansId(
      nom: _nomController.text,
      prenom: _prenomController.text,
      email: _emailController.text,
    );

    await _dbManager.insertRedacteur(nouveauRedacteur);
    
    // Réinitialiser les champs
    _nomController.clear();
    _prenomController.clear();
    _emailController.clear();
    
    // Recharger la liste
    await _loadRedacteurs();
    
    _showSnackBar('Rédacteur ajouté avec succès');
  }

  // Modifier un rédacteur
  Future<void> _modifierRedacteur(Redacteur redacteur) async {
    _nomController.text = redacteur.nom;
    _prenomController.text = redacteur.prenom;
    _emailController.text = redacteur.email;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modifier le rédacteur'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nomController,
                  decoration: const InputDecoration(labelText: 'Nom'),
                ),
                TextField(
                  controller: _prenomController,
                  decoration: const InputDecoration(labelText: 'Prénom'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_nomController.text.isEmpty || 
                    _prenomController.text.isEmpty || 
                    _emailController.text.isEmpty) {
                  _showSnackBar('Veuillez remplir tous les champs');
                  return;
                }

                final redacteurModifie = Redacteur(
                  id: redacteur.id,
                  nom: _nomController.text,
                  prenom: _prenomController.text,
                  email: _emailController.text,
                );

                await _dbManager.updateRedacteur(redacteurModifie);
                
                // Réinitialiser les champs
                _nomController.clear();
                _prenomController.clear();
                _emailController.clear();
                
                // Recharger la liste
                await _loadRedacteurs();
                
                Navigator.pop(context);
                _showSnackBar('Rédacteur modifié avec succès');
              },
              child: const Text('Sauvegarder'),
            ),
          ],
        );
      },
    );
  }

  // Supprimer un rédacteur
  Future<void> _supprimerRedacteur(Redacteur redacteur) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Text(
              'Êtes-vous sûr de vouloir supprimer ${redacteur.prenom} ${redacteur.nom} ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _dbManager.deleteRedacteur(redacteur.id!);
                await _loadRedacteurs();
                Navigator.pop(context);
                _showSnackBar('Rédacteur supprimé avec succès');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Supprimer',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text("Gestion des Rédacteurs",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Formulaire d'ajout
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Ajouter un nouveau rédacteur',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nomController,
                      decoration: const InputDecoration(
                        labelText: 'Nom',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _prenomController,
                      decoration: const InputDecoration(
                        labelText: 'Prénom',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _ajouterRedacteur,
                      icon: const Icon(Icons.add),
                      label: const Text('Ajouter un Rédacteur'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Liste des rédacteurs
            Expanded(
              child: _redacteurs.isEmpty
                  ? const Center(
                      child: Text(
                        'Aucun rédacteur enregistré',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _redacteurs.length,
                      itemBuilder: (context, index) {
                        final redacteur = _redacteurs[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 0),
                          child: ListTile(
                            title: Text(
                              '${redacteur.prenom} ${redacteur.nom}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(redacteur.email),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () =>
                                      _modifierRedacteur(redacteur),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () =>
                                      _supprimerRedacteur(redacteur),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dbManager.close();
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}