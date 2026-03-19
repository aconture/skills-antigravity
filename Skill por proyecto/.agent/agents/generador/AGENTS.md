---
name: AGCC_GEN
description: >
    Genera código legible y mantenible, usando el lenguaje determinado por el stack establecido en la arquitectura del Proyecto.
    Trigger: Cuando tengo que generar código debo activar el perfil AGCC_GEN y seguir estas reglas estrictamente.
license: Apache-2.0
metadata:
  author: AGCC
  version: "1.0"
  auto_invoke:
    - Cada vez que estén dadas las condiciones para comenzar a generar código (Definition of Ready = Diseño aprobado)
    - Cada vez que se vaya a crear o modificar una función.
    - Cada vez que se tenga que realizar una refactorización.
allowed-tools: Read, Edit, Write, Glob, Grep, Bash
---

## Principios
- Aplicar principios de legibilidad y buenas prácticas de Clean Code. 

## Reglas

### Reglas de Redacción
1. **Nombres Descriptivos:** No utilices abreviaturas (ej. usa `userAuthenticationStatus` en lugar de `uAuth`).

2. **Funciones Pequeñas:** Cada función debe realizar una única tarea y no exceder las 20 líneas de código.

3. **Comentarios de Valor:** No expliques *qué* hace el código si es obvio; explica el *por qué* en fragmentos complejos.

4. **Estructura Clara:** - Utiliza guard clauses para evitar el anidamiento excesivo de `if/else`.
   - Mantén un orden lógico: constantes arriba, seguidas de funciones principales y funciones auxiliares al final.

5. **Codigo entendible** - debe prevalecer el código entendible por un junior, por sobre el código complejo, aún si se tiene que sacrificar performance

6. **Idioma de los comentarios:** Comenta siempre en español.

7. **Idioma de las variables, constantes y funciones:** Siempre en inglés, usando buenas prácticas para nombrar estos artefactos.

### Ejemplo de Salida Esperada
- **Mal:** `const d = new Date(); // fecha actual`
- **Bien:** `const currentServerTime = new Date();`

## Reglas de Portabilidad
1. A menos que te indique lo contrario, haz que el codigo se pueda portar a cualquier directorio, es decir que no tenga que configurar ningun path para que puedan correr cualquiera de los scripts que realizas
2. en el codigo incluye las lineas necesarias para importar librerias y dependencias, de manera que si quiero ejecutar el codigo en otro equipo, pc o servidor; al ejecutar por primera vez se disparen las instalaciones de librerias y dependencias necesarias.
3. Prioriza siempre el uso de librerias que puedan ser portadas a windows o linux indistintamente.


## Reglas de Log
1. Genera un log en un archivo "log.txt" durante la ejecución de los script, para reflejar partes relevantes del código. 
2. Cada ejecución del script separala con dos líneas completas del caracter "="