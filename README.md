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
La estructura del proyecto es la siguiente:

flutter_final_test/
│
├── lib/
│   ├── application/
│   │   ├── BLoC/
│   │   │   ├── connectivity/
│   │   │   │   ├── connectivity_bloc.dart
│   │   │   │   ├── connectivity_event.dart
│   │   │   │   └── connectivity_state.dart
│   │   │   ├── credit/
│   │   │   │   ├── credit_bloc.dart
│   │   │   │   ├── credit_event.dart
│   │   │   │   └── credit_state.dart
│   │   │   └── trending/
│   │   │       ├── trending_bloc.dart
│   │   │       ├── trending_event.dart
│   │   │       └── trending_state.dart
│   │   └── use_cases/
│   │       ├── credit/
│   │       │   └── get_credit_by_movie.dart
│   │       └── trending/
│   │           └── get_trendings.dart
│   ├── commons/
│   │   ├── failure.dart
│   │   ├── result.dart
│   │   └── use_case.dart
│   ├── domain/
│   │   ├── actor/
│   │   │   └── actor.dart
│   │   ├── movie/
│   │   │   └── movie.dart
│   │   ├── credit/
│   │   │   ├── credit/
│   │   │   │   └── credit_repository.dart
│   │   │   └── credit.dart
│   │   └── trending/
│   │       ├── repository/
│   │       │   └── trending_repository.dart
│   │       └── trending.dart
│   ├── infrastucture/
│   │   ├── datasources/
│   │   │   └── api/
│   │   │       ├── api_connection_manager_impl.dart
│   │   │       └── api_connection_manager.dart
│   │   ├── mappers/
│   │   │   ├── actor/
│   │   │   │   └── actor_mapper.dart
│   │   │   ├── credit/
│   │   │   │   └── credit_mapper.dart
│   │   │   ├── movie/
│   │   │   │   └── movie_mapper.dart
│   │   │   └── trending/
│   │   │       └── trending_mapper.dart
│   │   ├── presentation/
│   │   │   ├── config/
│   │   │   │   ├── router/
│   │   │   │   │   └── app_router.dart
│   │   │   │   └── theme/
│   │   │   │       └── app_theme.dart
│   │   │   ├── pages/
│   │   │   │   ├── detail/
│   │   │   │   │   ├── detail_page.dart
│   │   │   │   │   └── widgets/
│   │   │   │   │       ├── actor_card.dart
│   │   │   │   │       └── actor_grid.dart
│   │   │   │   ├── home/
│   │   │   │   │   ├── home_page.dart
│   │   │   │   │   └── widgets/
│   │   │   │   │       ├── movie_card.dart
│   │   │   │   │       ├── movie_grid.dart
│   │   │   │   │       └── movie_list.dart
│   │   │   │   └── landing/
│   │   │   │       └── landing_page.dart
│   │   │   └── widgets/
│   │   │       ├── bloc_listener/
│   │   │       │    └── network_listener.dart
│   │   │       └── shared/
│   │   │            ├── circular_progress_indicator.dart
│   │   │            ├── custom_app_bar.dart
│   │   │            ├── error_page.dart
│   │   │            ├── ipage.dart
│   │   │            └── loading_page.dart
│   │   ├── repositories/
│   │   │   ├── credit/
│   │   │   │   └── credit_repository_impl.dart
│   │   │   └── trending/
│   │   │       └── trending_repository_impl.dart
│   │   └── services/
│   │       ├── config/
│   │       │   └── setup_injections.dart
│   │       └── network/
│   │           └── network_manager_impl.dart
│   └── main.dart
├── pubspec.yaml
├── README.md
└── .env

## Uso 
    - 1. En la pantalla principal, verás una lista de películas populares. 
    - 2. Pulsa sobre una película para ver los detalles y el elenco. 
    - 3. Utiliza los botones de "Anterior" y "Siguiente" para navegar entre las páginas de películas.

## Arquitectura Hexagonal
![documents][hexadiagram.png]