# ExplainMatch (Magneto) — Matching explicable con Neo4j

ExplainMatch es una solución para el reto **Profile Manager** que recomienda vacantes y explica el porqué del match.
El núcleo es un modelo en grafo (Neo4j): **Candidato → Skills → Roles → Vacantes**, con un ranking por cobertura ponderada y un endpoint de explicabilidad.

## Objetivo
Ayudar a un candidato a priorizar vacantes con **transparencia**:
- ranking (score)
- skills coincidentes (matched)
- skills faltantes (missing)
- contribución al score y “top reasons”

## Arquitectura (alto nivel)
- **Frontend:** React (Vite) (UI mínima para demo)
- **Backend:** Python (FastAPI)
- **DB:** Neo4j (grafo)
- **Infra:** Docker Compose

## Endpoints (plan Sprint 1)
- `GET /recommendations?candidate_id=<id>`
  - retorna Top N vacantes con `score` y `top_reasons`
- `GET /explain?candidate_id=<id>&vacancy_id=<id>`
  - retorna `score_total`, `matched_skills`, `missing_skills`, contribución y razones

## Cómo ejecutar (Sprint 1)
> En Sprint 1 se prioriza dejar el entorno reproducible con Docker Compose.
1. Levantar servicios:
   - `docker-compose up`
2. Cargar datos de prueba:
   - ejecutar `neo4j/seed.cypher` en Neo4j Browser (o vía script cuando esté listo)
3. Probar API:
   - Swagger: `http://localhost:8000/docs` (cuando la API esté implementada)

## Tablero y documentación
- Repo: https://github.com/theansw3r/explainmatch
- Board: https://github.com/users/theansw3r/projects/2
- Entrega 1: `/docs/entrega1/`

