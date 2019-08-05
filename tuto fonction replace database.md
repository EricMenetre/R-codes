---
title: "replace.data function"
author: "Eric M"
date: "15 mars 2019"
output: html_document
---

Fonction permettant de prendre les valeurs d'une base de donnée et les insérer dans une seconde ne comportant pas le même nombre de lignes. Imaginons une base de données 

```{r}
x <- rnorm(500, mean = 5)
y <- rnorm(500, mean = 1000)
z <- rnorm(500, mean = -5000)

df <- data.frame(x,y,z)
head(df, 5)
dim.data.frame(df)

```
comportant 500 lignes et 3 colonnes

Ainsi q'une seconde base de données n'ayant pas le même nombre de colonnes ni le même nombre de lignes 

```{r}

a <- rnorm(20, mean = 0)
b <- rnorm(20, mean = 300000)
df.small <- data.frame(a,b)
head(df.small,5)
dim.data.frame(df.small)

```
contenant 20 lignes et 2 colonnes

Afin de pouvoir prendre les données d'une colonne de la petite base de données pour les mettre dans la grande (la fonction marche que dans ce sens là), il faut une information commune dans les deux bases de données, que nous appelerons une colonne ID. Attention, la colonne ID doit également être la colonne de destination des données.

``` {r}
df$id <- 1:500
head(df,2)
df.small$id <- c(1, 9, 14, 16, 17, 31, 36, 38, 40, 89, 100, 109, 114, 116, 117, 131, 136, 138, 140, 189 ) # simulation de 20 valeurs extraites de la grande base de données
head(df.small,2)
```

Et voici la fonction permettant de faire le remplacement. N'hésitez pas à la modifier selon vos besoin mais laissez toujours une copie propore sur L ! Pour l'utiliser, la première étape est de copier le code ci-dessous dans votre script et de l'exécuter. Rien ne se passe, c'est normal. Cette étape est équivalente à celle du chargement d'un package : library(nom.du.package)

```{r}
replace.data <- function(from, to, col.to, col.code.subj.from, col.from, save.xlsx = FALSE, suppress.original = FALSE) {

  #for loop pour le remplacement 
  for (i in 1:dim(from)[1]) {
  for (j in 1:dim(to)[1]) {
    if (to[j, col.to] == from[i,col.code.subj.from]) {
      to[j,col.to] <- from[i,col.from]
    } 
  }
}
  final_data <- to
  # Sauvegarde en xlsx
  if (save.xlsx == TRUE ) {
    library(xlsx)
    write.xlsx(final_data, "d:/final_data.xlsx" )
  }
  if (supress.original == TRUE) {
    to <<- to
  }
  View(final_data)
  final_data <<- final_data
  return("Enjoy !")
}

```


Afin d'appliquer la fonction à votre jeu de données, vous devez utiliser la syntaxe suivante : 

replace.data(from = , 
              to = , 
              col.to = , 
              col.code.subj.from = , 
              col.from = ,
              save.xlsx = FALSE)

En cas de besoin, utilisez la fonction args() pour avoir un rappel des arguments contenus dans la fonction
```{r}
args(replace.data)

```

Les arguments sont les suivants : 

- from : base de données depuis laquelle les données doivent être prises
- to : base de données de destination 
- col.to : *numéro* de la colonne du dataframe to dans lequel les données doivent être insérées
- col.code.subj.from : *numéro* de la colonne contenant l'ID de chaque ligne de la petite base de données 
- col.from : *numéro* de colonne contenant les données à copier
- save.xlsx : argument TRUE/FALSE permettant d'enregistrer la base de données sur le dossier racine du disque C. Attention, pour utiliser cette option, il vous faudra au préalable avoir installé le package xlsx
- supress.original = argument TRUE/FALSE permettant de choisir si on souhaite écraser le dataframe original ou créer un nouveau 

En pratique avec les deux data frame crées ci-dessus : 

```{r}

# replace.data(from = df.small, 
#               to = df, 
#               col.to = 4, 
#               col.code.subj.from = 3, 
#               col.from = 2,
#               save.xlsx = FALSE
#               suppress.original = FALSE)

```

La commande ne peut pas être exécutée dans un fichier R Markdown mais en copiant le code ci-dessus dans un script R, Après avoir exécuté la commande, on remarque que : 

- un onglet s'ouvre montrant un data frame nommé final_data représentant le grand dataframe
- les données de la colonne ID du grand dataframe correspondant à la colonne ID du petit dataframe ont été remplacées par les données de la colonne b du petit dataframe ! 
- un nouveau data frame s'est créé dans l'environnement R (en haut à droite de l'écran)
- Selon les arguments optionnels, un fichier .xlsx a été créé dans le dossier racine du disque C nommé final_data.xlsx et le dataframe original (ici df) a été modifié

N'hésitez pas à me contacter en cas de problème ! 

Eric 



