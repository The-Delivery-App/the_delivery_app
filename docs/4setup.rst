Getting It Running
==================
 
Here's how to get the app running on your machine from scratch.
 
What you'll need first
----------------------
 
- `Flutter SDK <https://flutter.dev/docs/get-started/install>`_ (comes with Dart — you need SDK ^3.8.0 or higher)
- `Docker <https://docs.docker.com/get-docker/>`_ and Docker Compose
- `Serverpod CLI <https://docs.serverpod.dev>`_
 
1. Clone the repo

2. Start the database
    - The server needs PostgreSQL and Redis running. The easiest way is Docker:
        cd the_delivery_app_server
        docker compose up --build --detach
 
3. Start the server
    dart bin/main.dart
    - The server runs on port **8080** by default.
 
4. Run the app
    - Open a new terminal from the repo root: 
        cd the_delivery_app_flutter
        flutter pub get
        flutter run
    - Running on a physical device? You'll need to point the app at your machine's local IP address rather than localhost::
        flutter run --dart-define=SERVER_URL=http://192.168.x.x:8080/ 
5. Shutting everything down
    - Hit ``Ctrl-C`` to stop the server, then stop Docker:
    - docker compose stop
 
