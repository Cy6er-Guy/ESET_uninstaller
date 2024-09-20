
---

# Script de Désinstallation Silencieuse d'ESET Endpoint Security et Management Agent

## Description

Ce script PowerShell permet la désinstallation silencieuse d'ESET Endpoint Security et d'ESET Management Agent d'une machine Windows. Le script est conçu pour désinstaller ces logiciels sans redémarrage et réactiver le pare-feu Windows une fois les désinstallations terminées.

## Fonctionnalités

- Désinstalle **ESET Endpoint Security** silencieusement avec un mot de passe.
- Désinstalle **ESET Management Agent** silencieusement.
- Réactive le pare-feu Windows après la désinstallation.
- Vérifie si les logiciels ont été complètement désinstallés.

## Prérequis

- **Mot de passe** de désinstallation pour ESET Endpoint Security (à remplacer dans le script).
- Exécution du script avec des privilèges administrateur.

## Utilisation

1. Ouvrez PowerShell en mode **Administrateur**.
2. Modifiez la variable `$password` dans le script pour y inclure le mot de passe de désinstallation d'ESET Endpoint Security.
3. Exécutez le script en définissant la politique d'exécution avec la commande suivante :
   
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force
   ```

4. Exécutez le script en PowerShell :

   ```powershell
   ./NomDuScript.ps1
   ```

5. Le script désinstallera silencieusement ESET Endpoint Security et ESET Management Agent, réactivera le pare-feu et vérifiera la suppression des programmes.

## Remarque

- Si ESET Endpoint Security ou Management Agent n'est pas complètement supprimé, un message vous en informera.
- Veillez à utiliser ce script uniquement sur des systèmes où vous avez le droit de désinstaller ces logiciels.

## Avertissement

Ce script est fourni tel quel. L'auteur ne saurait être tenu responsable des dommages ou des pertes résultant de l'utilisation de ce script. Assurez-vous de comprendre ce que fait le script avant de l'exécuter.

---

