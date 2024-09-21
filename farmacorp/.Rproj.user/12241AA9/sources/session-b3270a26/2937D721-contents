# Instalar y cargar las bibliotecas necesarias
if (!require("sf")) install.packages("sf")
if (!require("dplyr")) install.packages("dplyr")
if (!require("leaflet")) install.packages("leaflet")

library(sf)
library(dplyr)
library(leaflet)

# Función para cargar y procesar un archivo GeoJSON de nodos
load_and_process_node_geojson <- function(file_path) {
  data <- st_read(file_path)
  processed_data <- data %>%
    select(id, name, geometry) %>%
    mutate(lat = st_coordinates(geometry)[, 2],
           lon = st_coordinates(geometry)[, 1])
  return(processed_data)
}

# Función para cargar y procesar un archivo GeoJSON de vías
load_and_process_way_geojson <- function(file_path) {
  data <- st_read(file_path)
  processed_data <- data %>%
    select(id, name, geometry) %>%
    mutate(centroid = st_centroid(geometry)) %>%
    mutate(centroid_lat = st_coordinates(centroid)[, 2],
           centroid_lon = st_coordinates(centroid)[, 1])
  return(processed_data)
}

# Cargar y procesar el archivo GeoJSON de nodos
node_file <- "C:/Users/yoviajo/Documents/GitHub/inteligencia_ubicacion/farmacorp/geodat/farmacorp_ubic_node.geojson"
node_data <- load_and_process_node_geojson(node_file)

# Cargar y procesar el archivo GeoJSON de vías
way_file <- "C:/Users/yoviajo/Documents/GitHub/inteligencia_ubicacion/farmacorp/geodat/farmacorp_ubic_way.geojson"
way_data <- load_and_process_way_geojson(way_file)

# Verificar los resultados
print(node_data)
print(way_data)

# Definir un icono personalizado
custom_icon <- makeIcon(
  iconUrl = "https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-blue.png",
  iconWidth = 25,
  iconHeight = 41
)

# Crear un mapa interactivo con Leaflet y fondo CartoDB Positron
map <- leaflet() %>%
  addProviderTiles("CartoDB.Positron") %>%
  addMarkers(data = node_data, 
             lat = ~lat, 
             lng = ~lon, 
             popup = ~name, 
             icon = custom_icon) %>%
  addPolygons(data = way_data, 
              popup = ~name, 
              color = "blue", 
              fillColor = "blue", 
              fillOpacity = 0.5) %>%
  addMarkers(data = way_data, 
             lat = ~centroid_lat, 
             lng = ~centroid_lon, 
             popup = ~name, 
             icon = custom_icon)

# Mostrar el mapa
map