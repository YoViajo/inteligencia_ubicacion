install.packages("rvest")
install.packages("dplyr")


# Carga de librerías
library(rvest)
library(dplyr)

# URL de la página a scrapear
url <- 'https://farmacorp.com/pages/sucursales'

# Leer el contenido de la página
pagina <- read_html(url)

# Extraer los nombres y los enlaces de las sucursales en Santa Cruz
sucursales <- pagina %>%
  html_nodes(".store-name a") %>%    # Selecciona los elementos de enlace (a) en la clase .store-name
  html_attr("href")                  # Extrae el atributo href que contiene los enlaces

# Convertir la lista de sucursales en un data frame
sucursales_df <- data.frame(Enlaces = sucursales)

# Mostrar el resultado
print(sucursales_df)
