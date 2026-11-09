# biblioteca-libros

Microservicio de libros del proyecto guía de DSY1107, **tal como queda al terminar L8**, ya separado
en su propio repositorio. Node plano, sin dependencias: `libros.mjs` sirve `datos/catalogo.json` en el
puerto **3001**, con 300 ms de latencia simulada. Cualquier `GET` responde **200** con la lista de libros.

| Archivo | Qué es |
|---|---|
| `libros.mjs` | El servidor HTTP. Relee `datos/catalogo.json` en cada petición |
| `datos/catalogo.json` | El catálogo que se sirve |
| `datos/prestamos.json` | Lo deja `sembrar.mts` junto al catálogo, con `sub` de ejemplo. Ningún servicio lo lee: los préstamos viven en Postgres, en `biblioteca-prestamos` |
| `sembrar.mts` | El seed de L4: arma el catálogo con Google Books y las sinopsis con un modelo (o `--respaldo`, sin conexión) |
| `Dockerfile` | La imagen que construye `biblioteca-plataforma/compose.yml` |
| `.env.example` | Los nombres que lee `sembrar.mts`. Solo hace falta para sembrar |

## Cómo usarlo

Necesitas **Node 24.15.0 o superior**. Los mismos comandos sirven en Windows (PowerShell), macOS y Linux:

```bash
cd $HOME/DSY1107/l10/biblioteca-libros
node libros.mjs
```

En otra terminal:

```bash
curl.exe -i http://localhost:3001/libros
```

En macOS y Linux, `curl` sin el `.exe`. Tiene que responder **200** con un arreglo JSON de libros.

Con todo el sistema, desde `biblioteca-plataforma`: `docker compose up -d --build --wait`. Mira el README de
ese repositorio.

## Volver a sembrar

Copia `.env.example` a `.env` (Windows: `Copy-Item .env.example .env`; macOS y Linux: `cp .env.example .env`),
pon tus dos `sub` y corre:

```bash
node --env-file=.env sembrar.mts --respaldo
```

Sin `--respaldo`, y con las dos API keys puestas, arma el catálogo de verdad. Después de sembrar, `git status`
marca los dos JSON de `datos/` como modificados: es lo esperado.
