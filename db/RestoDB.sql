CREATE DATABASE  IF NOT EXISTS `resto` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `resto`;
-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: resto
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) NOT NULL,
  `descripcion` varchar(1000) NOT NULL,
  `imagen` varchar(100) NOT NULL,
  `favorito` tinyint DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `url` varchar(300) DEFAULT NULL,
  `map` varchar(1000) DEFAULT NULL,
  `fecha_alta` datetime NOT NULL,
  `fecha_modi` datetime NOT NULL,
  `fecha_baja` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `idmenu` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `link` varchar(100) DEFAULT NULL,
  `imagen` varchar(100) DEFAULT NULL,
  `idpadre` int DEFAULT NULL,
  `tipo` varchar(4) NOT NULL,
  `fecha_alta` datetime NOT NULL,
  `fecha_modi` datetime NOT NULL,
  `fecha_baja` datetime DEFAULT NULL,
  PRIMARY KEY (`idmenu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'Clientes',NULL,NULL,NULL,'R','2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(2,'Cartera','clientes','fas fa-user-friends',1,'RUD','2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(3,'Nuevo','nuevo','fas fa-user-plus',1,'C','2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(4,'Reportes',NULL,NULL,NULL,'R','2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(5,'Altas del mes','altaspormes','fas fa-calendar-alt',4,'R','2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(6,'Movimientos','movimientos','fas fa-history',4,'R','2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(7,'Destacados','destacados','fas fa-star',4,'R','2021-07-16 00:00:00','2021-07-16 00:00:00',NULL);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modulo`
--

DROP TABLE IF EXISTS `modulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modulo` (
  `idmodulo` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `fecha_alta` datetime NOT NULL,
  `fecha_modi` datetime NOT NULL,
  `fecha_baja` datetime DEFAULT NULL,
  PRIMARY KEY (`idmodulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modulo`
--

LOCK TABLES `modulo` WRITE;
/*!40000 ALTER TABLE `modulo` DISABLE KEYS */;
INSERT INTO `modulo` VALUES (1,'clientes','2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(2,'reportes','2021-07-16 00:00:00','2021-07-16 00:00:00',NULL);
/*!40000 ALTER TABLE `modulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfil`
--

DROP TABLE IF EXISTS `perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfil` (
  `idperfil` int NOT NULL,
  `perfil_tipo` char(1) NOT NULL,
  `nombre` varchar(45) NOT NULL COMMENT 'Operación que tiene el Rol (Alta-Baja-Modificación-Consulta)',
  `idmodulo` int NOT NULL,
  `fecha_alta` datetime NOT NULL,
  `fecha_modi` datetime NOT NULL,
  `fecha_baja` datetime DEFAULT NULL,
  PRIMARY KEY (`idperfil`),
  KEY `fk_perfil_modulo1_idx` (`idmodulo`),
  CONSTRAINT `fk_perfil_modulo1` FOREIGN KEY (`idmodulo`) REFERENCES `modulo` (`idmodulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfil`
--

LOCK TABLES `perfil` WRITE;
/*!40000 ALTER TABLE `perfil` DISABLE KEYS */;
INSERT INTO `perfil` VALUES (1,'C','Create',1,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(2,'R','Read',1,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(3,'U','Update',1,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(4,'D','Delete',1,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(5,'R','Read',2,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL);
/*!40000 ALTER TABLE `perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rel_modulo_menu`
--

DROP TABLE IF EXISTS `rel_modulo_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rel_modulo_menu` (
  `idmodulo` int NOT NULL,
  `idmenu` int NOT NULL,
  `fecha_alta` datetime NOT NULL,
  `fecha_modi` datetime NOT NULL,
  `fecha_baja` datetime DEFAULT NULL,
  PRIMARY KEY (`idmodulo`,`idmenu`),
  KEY `fk_rel_modulo_menu_menu1_idx` (`idmenu`),
  KEY `fk_rel_modulo_menu_modulo1_idx` (`idmodulo`),
  CONSTRAINT `fk_rel_modulo_menu_menu1` FOREIGN KEY (`idmenu`) REFERENCES `menu` (`idmenu`),
  CONSTRAINT `fk_rel_modulo_menu_modulo1` FOREIGN KEY (`idmodulo`) REFERENCES `modulo` (`idmodulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rel_modulo_menu`
--

LOCK TABLES `rel_modulo_menu` WRITE;
/*!40000 ALTER TABLE `rel_modulo_menu` DISABLE KEYS */;
INSERT INTO `rel_modulo_menu` VALUES (1,1,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(1,2,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(1,3,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(2,4,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(2,5,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(2,6,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(2,7,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL);
/*!40000 ALTER TABLE `rel_modulo_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rel_rol_perfil`
--

DROP TABLE IF EXISTS `rel_rol_perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rel_rol_perfil` (
  `idrol` int NOT NULL,
  `idperfil` int NOT NULL,
  `fecha_alta` datetime NOT NULL,
  `fecha_modi` datetime NOT NULL,
  `fecha_baja` datetime DEFAULT NULL,
  PRIMARY KEY (`idrol`,`idperfil`),
  KEY `fk_rel_rol_perfil_perfil1_idx` (`idperfil`),
  KEY `fk_rel_rol_perfil_rol1_idx` (`idrol`),
  CONSTRAINT `fk_rel_rol_perfil_perfil1` FOREIGN KEY (`idperfil`) REFERENCES `perfil` (`idperfil`),
  CONSTRAINT `fk_rel_rol_perfil_rol1` FOREIGN KEY (`idrol`) REFERENCES `rol` (`idrol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rel_rol_perfil`
--

LOCK TABLES `rel_rol_perfil` WRITE;
/*!40000 ALTER TABLE `rel_rol_perfil` DISABLE KEYS */;
INSERT INTO `rel_rol_perfil` VALUES (1,1,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(1,2,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(1,3,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(1,4,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(1,5,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(2,2,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(2,3,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(2,5,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL);
/*!40000 ALTER TABLE `rel_rol_perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `idrol` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `fecha_alta` datetime NOT NULL,
  `fecha_modi` datetime NOT NULL,
  `fecha_baja` datetime DEFAULT NULL,
  PRIMARY KEY (`idrol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'admin','2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(2,'consulta','2021-07-16 00:00:00','2021-07-16 00:00:00',NULL);
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `idusuario` int NOT NULL,
  `usuario` varchar(45) NOT NULL,
  `pass` varchar(5000) NOT NULL,
  `idrol` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `fecha_alta` datetime NOT NULL,
  `fecha_modi` datetime NOT NULL,
  `fecha_baja` datetime DEFAULT NULL,
  PRIMARY KEY (`idusuario`),
  KEY `fk_usuario_rol1_idx` (`idrol`),
  CONSTRAINT `fk_usuario_rol1` FOREIGN KEY (`idrol`) REFERENCES `rol` (`idrol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'admin','admin',1,'Administrador','.',NULL,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL),(2,'consulta','consulta',2,'Consulta','.',NULL,'2021-07-16 00:00:00','2021-07-16 00:00:00',NULL);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'resto'
--

--
-- Dumping routines for database 'resto'
--
/*!50003 DROP PROCEDURE IF EXISTS `iud_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `iud_cliente`(	prm_id INT, 
															prm_nombre VARCHAR(250), 
															prm_descripcion VARCHAR(1000),                                                             
															prm_imagen VARCHAR(100), 
                                                            prm_destacado TINYINT,
															prm_direccion VARCHAR(200), 
															prm_telefono VARCHAR(20),
															prm_email VARCHAR(50),
															prm_url VARCHAR(300),
															prm_mapa VARCHAR(1000),
															prm_baja BIT)
BEGIN
	IF prm_baja = 1 THEN    
		UPDATE cliente
        SET fecha_baja = NOW()
        WHERE id = prm_id;
    ELSE
		UPDATE cliente
        SET	nombre 				= prm_nombre,
			descripcion 		= prm_descripcion,            
            imagen				= CASE WHEN prm_imagen IS NULL OR prm_imagen = '' THEN imagen ELSE prm_imagen END,
            favorito			= prm_destacado,
            direccion			= prm_direccion,
            telefono			= prm_telefono,
			email				= prm_email,
            url					= prm_url,
            map					= prm_mapa,
			fecha_modi 			= NOW(),
            fecha_baja			= NULL
		WHERE id = prm_id;
        
        IF (SELECT row_count()) = 0 THEN
			
            INSERT INTO cliente
            (
                nombre 				,
				descripcion 		,                
				imagen				,
                favorito			,
				direccion			,
				telefono			,
				email				,
				url					,
				map					,
                fecha_alta			,
				fecha_modi			,
				fecha_baja
            )
			SELECT  prm_nombre		,
					prm_descripcion	, 
					prm_imagen		, 
                    prm_destacado	,
					prm_direccion	, 
					prm_telefono	,
					prm_email		,
					prm_url			,
					prm_mapa		,
					NOW()			,
					NOW()			,
					NULL;					
		END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s_clientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s_clientes`(prm_idusuario INT, prm_id INT, prm_fav INT)
    READS SQL DATA
BEGIN
	SELECT 	C.id,
			C.nombre,
            C.descripcion,
            C.imagen,
            C.favorito,
            C.direccion, 
            C.telefono,
            C.email,
            C.url,
            C.map
	FROM  cliente C
	WHERE C.fecha_baja IS NULL
    AND   (prm_id = 0 OR C.id = prm_id)
    AND   (prm_fav = 0 OR C.favorito = prm_fav)
    AND	  EXISTS (SELECT 1
				  FROM  usuario U
						
						INNER JOIN
						rel_rol_perfil RRP
						ON RRP.idrol = U.idrol
						
						INNER JOIN
						perfil P
						ON P.idperfil = RRP.idperfil
						
						INNER JOIN
						modulo M
						ON M.idmodulo = P.idmodulo                    
						
				  WHERE (prm_idusuario = 0 OR idusuario = prm_idusuario)
				  AND   P.perfil_tipo = 'R'
				  AND   M.nombre= 'clientes');

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s_clientes_web` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s_clientes_web`()
    READS SQL DATA
BEGIN
	SELECT 	C.id,
			C.nombre,
            C.descripcion,
            C.imagen,
            C.favorito,
            C.direccion, 
            C.telefono,
            C.email,
            C.url,
            C.map
	FROM  cliente C
	WHERE C.fecha_baja IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s_menu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s_menu`(prm_idusuario INT)
    READS SQL DATA
BEGIN
	SELECT 	M.idmenu, 
			M.nombre, 
            M.link,
            M.imagen,
            M.idpadre,
            CONCAT (CASE WHEN ( SELECT 1 
              FROM  perfil P 
                    INNER JOIN 
                    rel_rol_perfil R 
                    ON R.idperfil = P.idperfil
              WHERE R.idrol = U.idrol AND P.idmodulo = RMM.idmodulo AND P.perfil_tipo = 'C') IS NULL THEN '' ELSE 'C' END
              ,
              'R',
            CASE WHEN ( SELECT 1 
              FROM  perfil P 
                    INNER JOIN 
                    rel_rol_perfil R 
                    ON R.idperfil = P.idperfil
              WHERE R.idrol = U.idrol AND P.idmodulo = RMM.idmodulo AND P.perfil_tipo = 'U') IS NULL THEN '' ELSE 'U' END
              ,
            CASE WHEN ( SELECT 1 
              FROM  perfil P 
                    INNER JOIN 
                    rel_rol_perfil R 
                    ON R.idperfil = P.idperfil
              WHERE R.idrol = U.idrol AND P.idmodulo = RMM.idmodulo AND P.perfil_tipo = 'D') IS NULL THEN '' ELSE 'D'END) AS accion,
              tipo
              
    FROM  usuario U

		  INNER JOIN
		  rel_rol_perfil RRP
		  ON  RRP.idrol = U.idrol
		  
		  INNER JOIN
		  perfil P
		  ON  P.idperfil = RRP.idperfil
		  
		  INNER JOIN
		  modulo MO
		  ON  MO.idmodulo = P.idmodulo
		  
		  INNER JOIN
		  rel_modulo_menu RMM
		  ON  RMM.idmodulo = P.idmodulo
		  
		  INNER JOIN
		  menu M
		  ON  M.idmenu = RMM.idmenu
         
    WHERE 	M.fecha_baja IS NULL
    AND		U.idusuario = prm_idusuario
    AND		P.perfil_tipo = 'R'
    ORDER BY M.idmenu, M.idpadre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s_usuario`(prm_usuario VARCHAR(45))
    READS SQL DATA
BEGIN
	SELECT 	U.idusuario,
			U.pass,
			U.nombre, 
            U.apellido,
            U.imagen            
            
    FROM	usuario U
			
            INNER JOIN
            rol R
            ON 	R.idrol = U.idrol
			
    WHERE lower(U.usuario) = lower(prm_usuario)    
    AND	  U.fecha_baja IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-20 15:20:48
