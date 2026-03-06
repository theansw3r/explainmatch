// 1) Constraints (evita duplicados)
CREATE CONSTRAINT candidate_id IF NOT EXISTS FOR (c:Candidate) REQUIRE c.id IS UNIQUE;
CREATE CONSTRAINT vacancy_id  IF NOT EXISTS FOR (v:Vacancy)  REQUIRE v.id IS UNIQUE;
CREATE CONSTRAINT role_name   IF NOT EXISTS FOR (r:Role)     REQUIRE r.name IS UNIQUE;
CREATE CONSTRAINT skill_name  IF NOT EXISTS FOR (s:Skill)    REQUIRE s.name IS UNIQUE;

// 2) Skills
MERGE (:Skill {name:"Python"});
MERGE (:Skill {name:"SQL"});
MERGE (:Skill {name:"Docker"});
MERGE (:Skill {name:"PowerBI"});
MERGE (:Skill {name:"Excel"});
MERGE (:Skill {name:"Git"});

// 3) Roles + requisitos (pesos)
MERGE (r1:Role {name:"Data Analyst"})
MERGE (r2:Role {name:"Backend Developer"})
MERGE (r3:Role {name:"Data Engineer"});

// Data Analyst
MATCH (r:Role {name:"Data Analyst"}), (sql:Skill {name:"SQL"}), (pbi:Skill {name:"PowerBI"}), (excel:Skill {name:"Excel"}), (py:Skill {name:"Python"})
MERGE (r)-[:REQUIRES {weight:0.40}]->(sql)
MERGE (r)-[:REQUIRES {weight:0.25}]->(pbi)
MERGE (r)-[:REQUIRES {weight:0.20}]->(excel)
MERGE (r)-[:REQUIRES {weight:0.15}]->(py);

// Backend Developer
MATCH (r:Role {name:"Backend Developer"}), (py:Skill {name:"Python"}), (git:Skill {name:"Git"}), (docker:Skill {name:"Docker"})
MERGE (r)-[:REQUIRES {weight:0.50}]->(py)
MERGE (r)-[:REQUIRES {weight:0.25}]->(git)
MERGE (r)-[:REQUIRES {weight:0.25}]->(docker);

// Data Engineer
MATCH (r:Role {name:"Data Engineer"}), (py:Skill {name:"Python"}), (sql:Skill {name:"SQL"}), (docker:Skill {name:"Docker"}), (git:Skill {name:"Git"})
MERGE (r)-[:REQUIRES {weight:0.35}]->(sql)
MERGE (r)-[:REQUIRES {weight:0.30}]->(py)
MERGE (r)-[:REQUIRES {weight:0.20}]->(docker)
MERGE (r)-[:REQUIRES {weight:0.15}]->(git);

// 4) Vacantes (asociadas a roles)
MERGE (v1:Vacancy {id:101, title:"Junior Data Analyst", company:"Empresa A", location:"Remoto"})
MERGE (v2:Vacancy {id:102, title:"Backend Python Dev", company:"Empresa B", location:"Medellín"})
MERGE (v3:Vacancy {id:103, title:"Data Engineer Jr", company:"Empresa C", location:"Remoto"})
MERGE (v4:Vacancy {id:104, title:"Data Analyst (PowerBI)", company:"Empresa D", location:"Bogotá"});

MATCH (v:Vacancy {id:101}), (r:Role {name:"Data Analyst"}) MERGE (v)-[:IS_ROLE]->(r);
MATCH (v:Vacancy {id:104}), (r:Role {name:"Data Analyst"}) MERGE (v)-[:IS_ROLE]->(r);
MATCH (v:Vacancy {id:102}), (r:Role {name:"Backend Developer"}) MERGE (v)-[:IS_ROLE]->(r);
MATCH (v:Vacancy {id:103}), (r:Role {name:"Data Engineer"}) MERGE (v)-[:IS_ROLE]->(r);

// 5) Candidatos + skills
MERGE (c1:Candidate {id:1, name:"Candidato Demo 1", seniority:"Junior"});
MERGE (c2:Candidate {id:2, name:"Candidato Demo 2", seniority:"Junior"});

// Candidato 1: fuerte en análisis
MATCH (c:Candidate {id:1}), (sql:Skill {name:"SQL"}), (excel:Skill {name:"Excel"}), (pbi:Skill {name:"PowerBI"})
MERGE (c)-[:HAS_SKILL {level:"advanced"}]->(sql)
MERGE (c)-[:HAS_SKILL {level:"intermediate"}]->(excel)
MERGE (c)-[:HAS_SKILL {level:"intermediate"}]->(pbi);

// Candidato 2: más backend/data
MATCH (c:Candidate {id:2}), (py:Skill {name:"Python"}), (git:Skill {name:"Git"}), (docker:Skill {name:"Docker"}), (sql:Skill {name:"SQL"})
MERGE (c)-[:HAS_SKILL {level:"advanced"}]->(py)
MERGE (c)-[:HAS_SKILL {level:"intermediate"}]->(git)
MERGE (c)-[:HAS_SKILL {level:"intermediate"}]->(docker)
MERGE (c)-[:HAS_SKILL {level:"basic"}]->(sql);
