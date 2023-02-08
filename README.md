# Marvel App

[English]:

This application consists of a main view with a listing of Marvel superheroes ordered alphabetically with 20 results per page when scrolling. When tapping on a superhero in the list, the detail screen is displayed with all its characteristics: its name in the header of the screen, photo, description (if it has one), and the following lists (if it has them): comics, series, stories, events, and URLs.

For development, the VIPER architecture has been applied, which we use at the ATSistemas Expert Center, as it fits with the Clean Architecture paradigm and achieves systems with the following characteristics:

Independence from frameworks: third-party frameworks and libraries are only used as tools and the architecture does not depend on them because in that case, limitations are introduced and it depends on the framework's maintenance being done correctly.
Independence from any external agent: business rules do not know anything about the implementation of any external element.
Testable: business logic can be tested without a graphical interface, database, API connection or any other external element.

It has been developed with UIKit
Cocoapods: to add external frameworks
The closure pattern has been changed to Combine for the communication between Providers, Interactors, and Presenters of the data downloaded from the API.


[Español]:

Esta aplicación consta de una vista principal con el listado de super héroes de Marvel ordenados alfabeticamente paginando de 20 en 20 resultados cuando se hace scroll.
Al pulsar sobre un super héroe de la lista se muestra la pantalla detalle con todas sus características: Su nombre en la cabecera de la pantalla, foto, descripción (si la tiene), y los siguientes listados (si los tiene): comics, series, stories, eventos y urls.

Para el desarrollo se ha aplicado la arquitectura VIPER que usamos en el Centro Experto de ATSistemas ya que encaja con el paradigma Clean Architecture y que consigue sistemas con las siguientes caracteristicas: 
- Independencia de los frameworks: los frameworks y librerias de terceros solo son usados como herramientas y la arquitectura no depende de ellos porque en tal caso se introducen limitaciones y se depende de que el mantenimiento del framework se haga correctamente.
- Independencia de cualquier agente externo: Las reglas de negocio no saben nada de la implementación de cualquier elemento exterior.
- Testable: la logica de negocio puede ser probada sin necesidad de interfaz gráfica, base de datos, conexión con la API o cualquier otro elemento externo.

Se ha desarrollado en Swift con UIKit.
Para añadir frameworks externos se ha usado Cocoapods.
Se ha cambiado del patrón closure a Combine para la comunicación entre los Providers, Interactors y Presenters de los datos descargados de la API.


