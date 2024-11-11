# Flutter Final Test

## Descripción
Este proyecto es una aplicación de prueba final creada con Flutter. La aplicación muestra una lista de películas populares con detalles y actores. La aplicación está diseñada para practicar y demostrar habilidades en Flutter, Bloc, y manejo de estados.

## Características
- Listado de películas populares.
- Detalles de cada película, incluyendo puntuación de usuarios y elenco.
- Paginación para navegar entre múltiples páginas de películas.
- Manejo de estado utilizando Bloc.

## Instalación
Sigue estos pasos para clonar y ejecutar el proyecto en tu entorno local:

1. Clona el repositorio:
    ```bash
    git clone https://github.com/jav1212/flutter_final_test.git
    ```
2. Navega al directorio del proyecto:
    ```bash
    cd flutter_final_test
    ```
3. Instala las dependencias:
    ```bash
    flutter pub get
    ```
4. Crea un archivo `.env` en la raíz del proyecto y agrega tu API_KEY:
    ```env
    API_KEY=449a79e6936db938259c1bdb7d87fcd1
    API_IMAGE=https://image.tmdb.org/t/p/original/
    API_URL=https://api.themoviedb.org/3/
    APP_NAME=Technical
    ```
5. Ejecuta la aplicación:
    ```bash
    flutter run
    ```

## Dependencias
  - get: ^4.6.6
  - get_it: ^7.6.4
  - go_router: ^13.0.0
  - dio: ^5.3.3
  - equatable: ^2.0.5
  - flutter_bloc: ^8.1.3
  - google_fonts: ^6.2.1
  - flutter_dotenv: ^5.1.0
  - connectivity_plus: ^5.0.2
  - bloc: ^8.1.2

## Estructura del Proyecto
$ tree
flutter_final_test/  <br />
    │ <br />
    ├── lib/ <br />
    │   ├── application/ <br />
    │   │   ├── BLoC/ <br />
    │   │   │   ├── connectivity/ <br />
    │   │   │   │   ├── connectivity_bloc.dart <br />
    │   │   │   │   ├── connectivity_event.dart <br />
    │   │   │   │   └── connectivity_state.dart <br />
    │   │   │   ├── credit/ <br />
    │   │   │   │   ├── credit_bloc.dart <br />
    │   │   │   │   ├── credit_event.dart <br />
    │   │   │   │   └── credit_state.dart <br />
    │   │   │   └── trending/ <br />
    │   │   │       ├── trending_bloc.dart <br />
    │   │   │       ├── trending_event.dart <br />
    │   │   │       └── trending_state.dart <br />
    │   │   └── use_cases/ <br />
    │   │       ├── credit/ <br />
    │   │       │   └── get_credit_by_movie.dart <br />
    │   │       └── trending/ <br />
    │   │           └── get_trendings.dart <br />
    │   ├── commons/ <br />
    │   │   ├── failure.dart <br />
    │   │   ├── result.dart <br />
    │   │   └── use_case.dart <br />
    │   ├── domain/ <br />
    │   │   ├── actor/ <br />
    │   │   │   └── actor.dart <br />
    │   │   ├── movie/ <br />
    │   │   │   └── movie.dart <br />
    │   │   ├── credit/ <br />
    │   │   │   ├── credit/ <br />
    │   │   │   │   └── credit_repository.dart <br />
    │   │   │   └── credit.dart <br />
    │   │   └── trending/ <br />
    │   │       ├── repository/ <br />
    │   │       │   └── trending_repository.dart <br />
    │   │       └── trending.dart <br />
    │   ├── infrastucture/ <br />
    │   │   ├── datasources/ <br />
    │   │   │   └── api/ <br />
    │   │   │       ├── api_connection_manager_impl.dart <br />
    │   │   │       └── api_connection_manager.dart <br />
    │   │   ├── mappers/ <br />
    │   │   │   ├── actor/ <br />
    │   │   │   │   └── actor_mapper.dart <br />
    │   │   │   ├── credit/ <br />
    │   │   │   │   └── credit_mapper.dart <br />
    │   │   │   ├── movie/ <br />
    │   │   │   │   └── movie_mapper.dart <br />
    │   │   │   └── trending/ <br />
    │   │   │       └── trending_mapper.dart <br />
    │   │   ├── presentation/ <br />
    │   │   │   ├── config/ <br />
    │   │   │   │   ├── router/ <br />
    │   │   │   │   │   └── app_router.dart <br />
    │   │   │   │   └── theme/ <br />
    │   │   │   │       └── app_theme.dart <br />
    │   │   │   ├── pages/ <br />
    │   │   │   │   ├── detail/ <br />
    │   │   │   │   │   ├── detail_page.dart <br />
    │   │   │   │   │   └── widgets/ <br />
    │   │   │   │   │       ├── actor_card.dart <br />
    │   │   │   │   │       └── actor_grid.dart <br />
    │   │   │   │   ├── home/ <br />
    │   │   │   │   │   ├── home_page.dart <br />
    │   │   │   │   │   └── widgets/ <br />
    │   │   │   │   │       ├── movie_card.dart <br />
    │   │   │   │   │       ├── movie_grid.dart <br />
    │   │   │   │   │       └── movie_list.dart <br />
    │   │   │   │   └── landing/ <br />
    │   │   │   │       └── landing_page.dart <br />
    │   │   │   └── widgets/ <br />
    │   │   │       ├── bloc_listener/ <br />
    │   │   │       │    └── network_listener.dart <br />
    │   │   │       └── shared/ <br />
    │   │   │            ├── circular_progress_indicator.dart <br />
    │   │   │            ├── custom_app_bar.dart <br />
    │   │   │            ├── error_page.dart <br />
    │   │   │            ├── ipage.dart <br />
    │   │   │            └── loading_page.dart <br />
    │   │   ├── repositories/ <br />
    │   │   │   ├── credit/ <br />
    │   │   │   │   └── credit_repository_impl.dart <br />
    │   │   │   └── trending/ <br />
    │   │   │       └── trending_repository_impl.dart <br />
    │   │   └── services/ <br />
    │   │       ├── config/ <br />
    │   │       │   └── setup_injections.dart <br />
    │   │       └── network/ <br />
    │   │           └── network_manager_impl.dart <br />
    │   └── main.dart <br />
    ├── pubspec.yaml <br />
    ├── README.md <br />
    └── .env <br />

## Uso 
    - 1. En la pantalla principal, verás una lista de películas populares. 
    - 2. Pulsa sobre una película para ver los detalles y el elenco. 
    - 3. Utiliza los botones de "Anterior" y "Siguiente" para navegar entre las páginas de películas.

## Arquitectura Hexagonal
![README][documents/hexadiagram.png]