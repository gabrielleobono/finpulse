# Changelog — FinPulse Pro

Toutes les modifications notables apportées à ce projet sont documentées dans ce fichier. Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/) et ce projet adhère à [Semantic Versioning](https://semver.org/).

## [1.0.0] - 2026-09-30 (Production-Ready Release)

### ✨ Ajouté
- Configuration du pipeline CI/CD GitHub Actions (`ci.yml`) avec linting strict, tests automatisés et génération d'APK release.
- Suite complète de tests : 12 tests unitaires, 5 tests de widgets et 2 tests d'intégration bout-en-bout.
- Support natif de l'accessibilité avec balisage sémantique `Semantics` pour tous les lecteurs d'écran.
- Support bilingue complet Internationalisation (FR / EN) via fichiers ARB standardisés.
- Documentation README professionnelle avec badges CI, architecture technique et instructions de déploiement.

### ⚡ Optimisé
- Performances d'affichage garanties à 60fps constants grâce à l'usage de constructeurs `const` et d'une gestion fine des listeners de réactivité.
- Amélioration du défilement des listes avec `cacheExtent` et recyclage des cellules.

---

## [0.2.0] - 2026-09-20 (Feature Complete)

### ✨ Ajouté
- Implémentation des 5 écrans fondamentaux :
  - **Dashboard** : Solde net, revenus, dépenses et dernières transactions.
  - **Historique** : Filtrage dynamique par catégorie et recherche temps réel.
  - **Ajout Transaction** : Formulaire interactif avec validation numérique stricte.
  - **Analyses** : Calculateur de taux d'épargne et ventilation des dépenses.
  - **Paramètres** : Mode Sombre et sélecteur de langue.
- Persistance locale des données via `shared_preferences`.

### 🐛 Corrigé
- Correction d'un bug de recalcul du solde lors de la suppression d'une transaction.

---

## [0.1.0] - 2026-09-10 (Initial Scaffold)

### ✨ Ajouté
- Initialisation du squelette Flutter Material 3 avec `analysis_options.yaml` strict.
- Modélisation des classes de base `TransactionModel` et `CategoryItem`.
- Implémentation du pattern Repository et du `FinanceProvider` (Provider pattern).
