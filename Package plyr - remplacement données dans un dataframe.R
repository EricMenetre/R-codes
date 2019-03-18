############################################################################
############################################################################
###                                                                      ###
###       PACKAGE PLYR - REMPLACEMENT DE VALEURS DANS UN DATAFRAME       ###
###                                                                      ###
############################################################################
############################################################################

install.packages("plyr")
library(plyr)

#exemple de dataset
dataset <- data.frame (age = rnorm(100,50,10), taille = rnorm (100,180,10), sexe =factor (rep(c("femme","homme"), 50) ))
View(dataset)


### Ce package permet de remplacer des valeurs dans un dataframe. Vous pouvez par exemple renommer des conditions, 
### remplacer toutes les valurs supérieur à un chiffre par 0, NA, etc. 

#Dans l'exemple ci-dessous, toutes les valeurs de la variable taille du jeu de données dataset qui sont suppérieurs à 173 seront remplacées par NA
dataset$taille[dataset$taille < 173 ] = NA
View(dataset)

#La même commande peut également servir à remplacer du texte, comme ici femme par madame et homme par monsieur 
dataset$sexe <- revalue(dataset$sexe, c("femme" = "madame", "homme" = "monsieur"))
View(dataset)

# Pour plus d'informations : 

?plyr # Je n'ai utilisé que la fonction revalue mais d'autres fonctions du même type sont également disponibles
?revalue # Aide relative à cette commande
