# Marvel App

Esta aplicación consta de una vista principal con el listado de super héroes de Marvel ordenados alfabeticamente paginando de 20 en 20 resultados cuando se hace scroll.
Al pulsar sobre un super héroe de la lista se muestra la pantalla detalle con todas sus características: Su nombre en la cabecera de la pantalla, foto, descripción (si la tiene), y los siguientes listados (si los tiene): comics, series, stories, eventos y urls.

Para el desarrollo se ha aplicado la arquitectura VIPER que usamos en el Centro Experto de ATSistemas ya que encaja con el paradigma Clean Architecture y que consigue sistemas con las siguientes caracteristicas: 
- Independencia de los frameworks: los frameworks y librerias de terceros solo son usados como herramientas y la arquitectura no depende de ellos porque en tal caso se introducen limitaciones y se depende de que el mantenimiento del framework se haga correctamente.
- Independencia de cualquier agente externo: Las reglas de negocio no saben nada de la implementación de cualquier elemento exterior.
- Testable: la logica de negocio puede ser probada sin necesidad de interfaz gráfica, base de datos, conexión con la API o cualquier otro elemento externo.

Se ha desarrollado con UIKit y para añadir frameworks externos se ha usado Cocoapods.
