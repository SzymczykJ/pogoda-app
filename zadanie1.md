# pogoda-app
##Polecenia Docker

a. Polecenie do zbudowania obrazu kontenera:
docker build -t pogoda-app .

b. Polecenie do uruchomienia kontenera:
docker run -d -p 8080:8080 --name pogoda-container pogoda-app

c. Polecenie do odczytu logów aplikacji:
docker logs pogoda-container

d. Polecenia do sprawdzenia liczby warstw i rozmiaru obrazu:
Sprawdzenie ilości warstw:
docker history pogoda-app

Polecenie do sprawdzenia rozmiaru:
docker images

