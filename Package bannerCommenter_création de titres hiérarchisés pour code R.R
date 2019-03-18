
###########################################################################
###########################################################################
###                                                                     ###
###              UTILISATION DU PACKAGE - BANNERCOMMENTER-              ###
###                                                                     ###
###########################################################################
###########################################################################

#Ce package permet de créer des bannières de titre et sous-titre suivant une hiérarchie pour 
#commenter votre code R de manière très simple et ordonnée

install.packages("bannerCommenter") # Commande permettant d'installer le package
library("bannerCommenter") # commande permettant de charger le paquet

section("Utilisation du package - bannerCommenter-") # titre figurant au dessus 
banner("Possibilités") # titre figurant au dessous


##################################################################
##                         Possibilités                         ##
##################################################################

block("test - utilisez ceci pour vos commentaires longs")
###  test - utilisez ceci pour vos commentaires longs

open_box("test")
##--------
##  test  
##--------

boxup("Eliminate per participant et condition")
##----------------------------------------------------------------
##                              test                             -
##----------------------------------------------------------------

banner("test")
##################################################################
##                             test                             ##
##################################################################


section("test")
############################################################################
############################################################################
###                                                                      ###
###                                 TEST                                 ###
###                                                                      ###
############################################################################
############################################################################

# Pour plus d'informations : 
?banner

