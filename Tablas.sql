CREATE TABLE  "USUARIO" (
  "EMAIL" VARCHAR2(255) NOT NULL PRIMARY KEY,
	"RUN" NUMBER(7) NOT NULL UNIQUE,
	"PASSWORD" VARCHAR2(31) NOT NULL,
	"NOMBRE" VARCHAR2(127) NOT NULL,
	"ROL" NUMBER(8) UNIQUE,
	"ESTILO" NUMBER(1)
  )
/*
email: barbaciega_elpirata@orbedeconfusion.com
run: 1940986
password: doncangrejo
nombre: patricio
rol: 20147358
estilo: 1

INSERT INTO USUARIO (EMAIL, RUN, PASSWORD,NOMBRE,ROL,ESTILO)
VALUES ("barbaciega_elpirata@orbedeconfusion.com", 1940986, "doncangrejo","patricio",20147358,1);
*/
CREATE TABLE "CONTENIDO" (
  "ID" NUMBER(10) NOT NULL PRIMARY KEY,
  "RELEVANCIA_TIPOA" NUMBER(2) NOT NULL,
  "RELEVANCIA_TIPOB" NUMBER(2) NOT NULL,
  "RELEVANCIA_TIPOC" NUMBER(2) NOT NULL,
  "RELEVANCIA_TIPOD" NUMBER(2) NOT NULL,
  "COMENTARIO" VARCHAR2(255),
  "TITULO" VARCHAR2(255),
  "RTF" CLOB
)



CREATE TABLE "ASIGNATURA"(
  "ID" NUMBER(10) NOT NULL PRIMARY KEY,
  "SIGLA" CHAR(6) NOT NULL,
  "SEMESTRE" NUMBER(1) NOT NULL,
  "ANIO" NUMBER(4) NOT NULL,
  "NOMBRE" VARCHAR2(255) NOT NULL,
  "SEDE" CHAR(2) NOT NULL
)

CREATE TABLE "TAG" (
  "ID" NUMBER(10) NOT NULL PRIMARY KEY,
  "NOMBRE" VARCHAR2(63) NOT NULL UNIQUE
)


CREATE TABLE "UNIDAD" (
  "ID" NUMBER(10) NOT NULL,
  "ASIGNATURA_ID" NUMBER(10) NOT NULL,
  "JERARQUIA" NUMBER(3) NOT NULL,
  "TITULO" VARCHAR2(255),
  CONSTRAINT "UNIDAD_PK" PRIMARY KEY ("ID", "ASIGNATURA_ID"),
  CONSTRAINT "ASIGNATURA_ID_FK" FOREIGN KEY ("ASIGNATURA_ID") REFERENCES ASIGNATURA("ID")
)

CREATE TABLE "MENSAJE" (
 "ID" NUMBER(10) NOT NULL PRIMARY KEY,
 "ASUNTO" VARCHAR2(255) NOT NULL,
 "MENSAJE" CLOB,
 "FECHA" DATE,
 "REMITENTE_EMAIL" VARCHAR2(255),
 CONSTRAINT "REMITENTE_EMAIL_FK" FOREIGN KEY ("REMITENTE_EMAIL") REFERENCES USUARIO("EMAIL")
)

CREATE TABLE "MENSAJE_RECEPTOR" (
  "USUARIO_EMAIL" VARCHAR2(255) NOT NULL,
  "MENSAJE_ID" NUMBER(10) NOT NULL,
  "LEIDO" NUMBER(1) NOT NULL,
  CONSTRAINT "MENSAJE_RECEPTOR_PK" PRIMARY KEY ("USUARIO_EMAIL", "MENSAJE_ID"),
  CONSTRAINT "USUARIO_EMAIL_FK" FOREIGN KEY ("USUARIO_EMAIL") REFERENCES USUARIO("EMAIL"),
  CONSTRAINT "MENSAJE_ID_FK" FOREIGN KEY ("MENSAJE_ID") REFERENCES MENSAJE("ID")
)


CREATE TABLE "UNIDAD_CONTENIDO"(
  "UNIDAD_ID" NUMBER(10) NOT NULL,
  "ASIGNATURA_ID" NUMBER(10) NOT NULL,
  "CONTENIDO_ID" NUMBER(10) NOT NULL,
  CONSTRAINT "UNIDAD_CONTENIDO_PK" PRIMARY KEY ("UNIDAD_ID", "ASIGNATURA_ID", "CONTENIDO_ID"),
  CONSTRAINT "UNIDAD_CONTENIDO_UNIDAD_FK" FOREIGN KEY ("UNIDAD_ID", "ASIGNATURA_ID") REFERENCES UNIDAD("ID", "ASIGNATURA_ID"),
  CONSTRAINT "CONTENIDO_ID_CONTENIDO_FK" FOREIGN KEY ("CONTENIDO_ID") REFERENCES CONTENIDO("ID")
)

CREATE TABLE "TAG_CONTENIDO" (
  "TAG_ID" NUMBER(10) NOT NULL,
  "CONTENIDO_ID" NUMBER(10) NOT NULL,
  CONSTRAINT "TAG_CONTENIDO_PK" PRIMARY KEY ("TAG_ID", "CONTENIDO_ID"),
  CONSTRAINT "TAG_ID_FK" FOREIGN KEY ("TAG_ID") REFERENCES TAG("ID"),
  CONSTRAINT "CONTENIDO_ID_FK" FOREIGN KEY ("CONTENIDO_ID") REFERENCES CONTENIDO("ID")
)

CREATE TABLE "USUARIO_ASIGNATURA" (
  "USUARIO_EMAIL" VARCHAR2(255) NOT NULL,
  "ASIGNATURA_ID" NUMBER(10) NOT NULL,
  "PERMISO" NUMBER(1) NOT NULL,
  CONSTRAINT "USUARIO_ASIGNATURA_PK" PRIMARY KEY ("USUARIO_EMAIL", "ASIGNATURA_ID"),
  CONSTRAINT "USUARIO_EMAIL_ASIGNATURA_FK" FOREIGN KEY ("USUARIO_EMAIL") REFERENCES USUARIO("EMAIL"),
  CONSTRAINT "ASIGNATURA_ID_USUARIO_FK" FOREIGN KEY ("ASIGNATURA_ID") REFERENCES ASIGNATURA("ID")
)


CREATE TABLE "FEEDBACK" (
  "USUARIO_EMAIL" VARCHAR2(255) NOT NULL,
  "CONTENIDO_ID" NUMBER(10) NOT NULL,
  "UNIDAD_ID" NUMBER(10) NOT NULL,
  "ASIGNATURA_ID" NUMBER(10) NOT NULL,
  "USUARIO_ESTILO" NUMBER(1) NOT NULL,
  "LAIK" NUMBER(1) NOT NULL,
  "FECHA" DATE NOT NULL,
  CONSTRAINT "FEEDBACK_PK" PRIMARY KEY ("USUARIO_EMAIL", "CONTENIDO_ID", "UNIDAD_ID", "ASIGNATURA_ID"),
  CONSTRAINT "USUARIO_EMAIL_FEEDBACK_FK" FOREIGN KEY ("USUARIO_EMAIL") REFERENCES USUARIO("EMAIL"),
  CONSTRAINT "CONTENIDO_ID_FEEDBACK_FK" FOREIGN KEY ("CONTENIDO_ID", "UNIDAD_ID", "ASIGNATURA_ID") REFERENCES UNIDAD_CONTENIDO("CONTENIDO_ID", "UNIDAD_ID", "ASIGNATURA_ID")
)
