# Pogoda App — Zadanie 2

Repozytorium zawiera aplikację pogodową z zadania 1 oraz workflow GitHub Actions realizujący zadanie 2.

## Workflow

Pipeline znajduje się w pliku:

`.github/workflows/docker-ghcr.yml`

Workflow:
- buduje obraz Dockera na podstawie `Dockerfile`,
- buduje obraz dla `linux/amd64` i `linux/arm64`,
- używa cache BuildKit w DockerHub,
- skanuje obraz skanerem Trivy,
- publikuje obraz do GitHub Container Registry tylko po pozytywnym przejściu skanu CVE.

## Obraz

Obraz został opublikowany w GHCR:

`ghcr.io/szymczykj/pogoda-app:sha-09ed3b1`

Sprawdzenie architektur:

`docker buildx imagetools inspect ghcr.io/szymczykj/pogoda-app:sha-09ed3b1`

Wynik potwierdził obsługę:

- `linux/amd64`
- `linux/arm64`

## Cache

Cache BuildKit jest przechowywany w publicznym repozytorium DockerHub:

`docker.io/szymczykjulia/zadanie2-cache:buildcache`

W workflow użyto cache typu `registry` oraz `mode=max`.

## Test CVE

Do testu CVE użyto Trivy. Workflow kończy się błędem, jeśli obraz zawiera podatności `HIGH` lub `CRITICAL`.

## Tagowanie

Obraz tagowany jest według schematu:

- `sha-<short_commit_sha>` dla uruchomień na gałęzi `main`,
- SemVer dla tagów Git `vX.Y.Z`.

Tag `latest` został wyłączony. Cache ma stały tag `buildcache`.

## Potwierdzenie

Workflow został uruchomiony i zakończył się sukcesem. Obraz został przesłany do GHCR, a cache zapisany w DockerHub.
