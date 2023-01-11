--CREATE database sketching;

-- -----------------------------------------------------
-- Table  sketching . layer 
-- -----------------------------------------------------
CREATE TABLE layer (
  idlayer int NOT NULL,
  updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (idlayer));
-- -----------------------------------------------------
-- Table  sketching . entity 
-- -----------------------------------------------------
CREATE TABLE entity (
   identity  int NOT NULL,
   layer  INT NOT NULL,
  PRIMARY KEY ( identity ),
  FOREIGN KEY ( layer ) REFERENCES  layer ( idlayer ) ON DELETE CASCADE ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table  sketching . param
-- -----------------------------------------------------
CREATE TABLE  param  (
   idparam  int NOT NULL,
   value  DOUBLE PRECISION NOT NULL,   
  PRIMARY KEY ( idparam ) );


-- -----------------------------------------------------
-- Table  sketching . objtype 
-- -----------------------------------------------------
CREATE TABLE  objtype  (
   idobjtype  int NOT NULL,
   name  VARCHAR(45) NOT NULL,
   freedegree  INT NOT NULL,
  PRIMARY KEY ( idobjtype ));


-- -----------------------------------------------------
-- Table  sketching . object 
-- -----------------------------------------------------
CREATE TABLE  object  (
   idobject  int NOT NULL,
   objtype  SMALLINT NOT NULL,
   idparent int,
   name VARCHAR(45),
  PRIMARY KEY ( idobject ),
  FOREIGN KEY ( objtype ) REFERENCES  objtype  ( idobjtype ) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY ( idobject ) REFERENCES  entity  ( identity )  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY ( idparent ) REFERENCES  object  ( idobject )  ON DELETE CASCADE ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table  sketching . objparam
-- -----------------------------------------------------
CREATE TABLE  objparam  (
   idobject  int NOT NULL,
   idparam  int NOT NULL,   
   num  INT NULL,
  PRIMARY KEY ( idobject, idparam ),
  FOREIGN KEY ( idparam ) REFERENCES  param  ( idparam )   ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY ( idobject ) REFERENCES  object  ( idobject ) ON DELETE CASCADE ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table  sketching . constrtype 
-- -----------------------------------------------------
CREATE TABLE  constrtype  (
   idconstrtype  smallint NOT NULL,
   name  VARCHAR(45) not NULL,
   is_parametric  boolean not NULL,
  PRIMARY KEY ( idconstrtype ));


-- -----------------------------------------------------
-- Table  sketching . constraint 
-- -----------------------------------------------------
CREATE TABLE  "constraint"  (
   idconstraint  int NOT NULL,
   constrtype  SMALLint NOT NULL,
  PRIMARY KEY ( idconstraint ),
  FOREIGN KEY ( constrtype ) REFERENCES  constrtype  ( idconstrtype ) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY ( idconstraint ) REFERENCES  entity  ( identity ) ON DELETE CASCADE ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table  sketching . constrinfo 
-- -----------------------------------------------------
CREATE TABLE  constrinfo  (
   idconstraint  int NOT NULL,
   idobject  int NOT NULL,
  PRIMARY KEY ( idconstraint ,  idobject ),
  FOREIGN KEY ( idconstraint ) REFERENCES  "constraint"  ( idconstraint ) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY ( idobject ) REFERENCES  object  ( idobject ) ON DELETE CASCADE ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table  sketching . constrparam 
-- -----------------------------------------------------
CREATE TABLE  constrparam  (
   idconstraint  int NOT NULL,
   idparam  int NOT NULL,
  PRIMARY KEY ( idconstraint ,  idparam ),
  FOREIGN KEY ( idconstraint ) REFERENCES  "constraint"  ( idconstraint ) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY ( idparam ) REFERENCES  param  ( idparam ) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO  "objtype" ("idobjtype","name","freedegree") VALUES (1,'Point',2);
INSERT INTO  "objtype" ("idobjtype","name","freedegree") VALUES (2,'Segment',4);
INSERT INTO  "objtype" ("idobjtype","name","freedegree") VALUES (3,'Circle',3);
INSERT INTO  "objtype" ("idobjtype","name","freedegree") VALUES (4,'Arc',5); 

INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (0,'Fixed',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (1,'Equal',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (2,'Vertical',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (3,'Horizontal',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (4,'Distance',true);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (5,'Angle',true);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (6,'Parallel',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (7,'Ortho',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (8,'Tangent',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (9,'Coincident',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (10,'Midpoint',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (11,'Collinear',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (12,'Dimension',true);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (13,'Symmetric',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (14,'Concentric',false);
INSERT INTO "constrtype" ("idconstrtype","name","is_parametric") VALUES (15,'Arcbase',false);
