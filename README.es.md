# Laboratorio de OWASP Juice Shop con Docker Compose: aprende seguridad de aplicaciones web atacando una tienda en línea insegura

[English](README.md) | [Français](README.fr.md) | [日本語](README.ja.md) | [Español](README.es.md)

[![check](https://github.com/mitsurutech/lab-juice-shop/actions/workflows/check.yml/badge.svg)](https://github.com/mitsurutech/lab-juice-shop/actions/workflows/check.yml)

Un **laboratorio de seguridad de aplicaciones web** listo para usar en clase, de la [plataforma de aprendizaje MitsuruTech](https://mitsurutech.co.uk/es/learning), donde escuelas y centros dan a cada alumno sus propias bases de datos, contenedores y terminal en el navegador. Cada alumno recibe su propia copia de **OWASP Juice Shop**, una tienda en línea insegura a propósito, con alrededor de cien desafíos sobre el [OWASP Top 10](https://owasp.org/www-project-top-ten/): inyección, autenticación rota, control de acceso roto, cross-site scripting, errores de configuración de seguridad y más. Encuentran las vulnerabilidades, **explican por qué funciona cada una y cómo debería haberse escrito el código**, y entregan pruebas, sin instalar nada y sin riesgo para el ordenador de nadie.

Es un único archivo `docker-compose`, `compose.yaml`, y funciona igual en tu propio ordenador que en la plataforma, donde cada alumno tiene una copia privada sin salida a Internet.

## La única regla

**Ataca tu propia copia y nada más.** Todo lo de este laboratorio se ejecuta dentro de tu copia privada, que no tiene ruta a Internet ni a ningún otro alumno, así que lo único que puedes alcanzar es la aplicación que el laboratorio ha iniciado para ti. No apuntes nunca una herramienta a un sitio web, una red o una máquina que no sean tuyos, ni en un laboratorio ni en ningún otro sitio: en el Reino Unido es un delito según la [Computer Misuse Act 1990](https://www.legislation.gov.uk/ukpga/1990/18/contents), y la mayoría de los países tienen una ley parecida. Aprender cómo funcionan las vulnerabilidades es la manera de crear software que no las tenga, y una buena primera conversación en clase es por qué existe esta regla y qué es la divulgación responsable.

## Qué incluye

| Servicio | Imagen | Memoria | Qué es |
| --- | --- | --- | --- |
| `juice-shop` | [`bkimminich/juice-shop:v20.3.0`](https://hub.docker.com/r/bkimminich/juice-shop) | 512 MB | la tienda, en el puerto 3000, que se ejecuta con una cuenta sin privilegios (usuario 65532) y sin ninguna capacidad |

Arranca en unos segundos y usa más o menos 100 MB con poco uso; una clase que la use mucho usará más.

Las imágenes son programas de terceros, ejecutados sin modificar a partir de las imágenes públicas de los propios proyectos y fijadas a una versión (nunca `latest`), de modo que el laboratorio no cambia a mitad de curso entre una lección y la siguiente. Aquí no se construye nada y nada de este repositorio se distribuye en ellas.

## Usarlo en la plataforma

La [plataforma de aprendizaje MitsuruTech](https://mitsurutech.co.uk/es/learning) da a cada alumno su propia copia de un laboratorio, en el navegador, con un terminal al lado.

**Para probarlo:** abre la [página de contenedores](https://mitsurutech.co.uk/es/container), busca este laboratorio en **Laboratorios de ejemplo** y pulsa Iniciar. No hace falta una cuenta para probar uno.

**Para ponerlo como trabajo a una clase:**

1. En tu módulo, crea una tarea de tipo **Laboratorio** y elige **En un repositorio de GitHub**.
2. Indica `https://github.com/mitsurutech/lab-juice-shop` con la rama `main`. El archivo compose es el predeterminado, `compose.yaml`. Haz antes un fork del repositorio si quieres cambiar el archivo.
3. Publica. La copia de cada alumno parte del commit que publicaste, así que un cambio posterior aquí no altera un laboratorio ya asignado.
4. Indica en la tarea qué hay que entregar (consulta [Para profesores](#para-profesores)) y asígnala como cualquier otra tarea.

La [guía de los laboratorios de seguridad](https://mitsurutech.co.uk/es/help/security-labs) del manual y su [guía de los laboratorios de contenedores](https://mitsurutech.co.uk/es/help/labs) explican el resto: qué puede decir un archivo compose, cuánta memoria recibe una copia y cómo abre, vigila y califica un profesor la copia de un alumno.

¿Todavía no tienes una cuenta de centro? [El primer año es gratis](https://mitsurutech.co.uk/es/pricing) para hasta 50 alumnos, y [registrarse](https://mitsurutech.co.uk/es/signup) solo requiere una dirección de correo electrónico.

## Ejecutarlo en tu propio ordenador

Necesitas Docker con el complemento Compose. El primer inicio descarga las imágenes.

```bash
docker compose -f compose.yaml -f local.yaml up
```

Abre <http://localhost:3000> para la tienda.

`local.yaml` publica los puertos solo en `127.0.0.1`, de modo que el laboratorio se alcanza desde tu ordenador y desde ningún otro sitio. Páralo con `Ctrl-C` y elimínalo con `docker compose -f compose.yaml -f local.yaml down -v`. Ejecútalo en una máquina desde la que no te importe atacar: la aplicación es insegura a propósito.

## Cómo trabajarlo

1. **Abre la tienda** (en la plataforma, pulsa **Abrir** en la página del laboratorio) y échale un vistazo como lo haría un cliente: regístrate, añade cosas a la cesta, lee las reseñas.
2. **Encuentra el Score Board.** Enumera todos los desafíos por dificultad y pone cada uno en verde cuando se resuelve, y no está enlazado desde ningún sitio: encontrarlo es el primer desafío.
3. **Sube por dificultad.** Los desafíos cubren el OWASP Top 10: inyección, autenticación rota, control de acceso roto, cross-site scripting, errores de configuración de seguridad y más. Mira lo que envía y recibe el navegador, lee lo que hace el propio código de la página y pregunta de cada entrada qué da por supuesto el programa. Las pistas del Score Board van más allá, y un alumno que ha probado antes aprende más con ellas.
4. **Guarda tu progreso.** La tienda olvida su estado cuando el laboratorio se detiene, así que un alumno que seguirá mañana copia el **código para continuar** (continue code) que ofrece el Score Board.

## Para profesores

Nada de este laboratorio se califica automáticamente. El alumno entrega pruebas y tú las calificas, como cualquier otro laboratorio.

**Pide las pruebas en dos mitades.** Primero, la prueba del trabajo: una captura de pantalla de los desafíos resueltos en el Score Board, con la dirección propia del laboratorio visible en el navegador para que quede claro que es su copia. Segundo, la comprensión: para cada una, una explicación escrita con sus propias palabras de qué es la vulnerabilidad, la entrada exacta que usó y por qué funcionó, qué podría hacer un atacante con ella y cómo debería haberse escrito el código. La segunda mitad te dice si se entendió o se copió de una guía paso a paso. Para un trabajo más sólido, pide la corrección además del ataque.

**Dónde encaja en un curso.** Juice Shop sirve para el OWASP Top 10 en una aplicación realista: amenazas y vulnerabilidades, inyección, debilidades de autenticación y de sesión, control de acceso, fallos criptográficos y errores de configuración de seguridad, y la evaluación de vulnerabilidades como método. También apoya la parte legal y ética de una unidad: autorización y alcance, la Computer Misuse Act 1990 y la divulgación responsable. Consulta la unidad de tu propio organismo certificador para ver la redacción exacta: aquí no se cita ninguna.

**Quién ve qué.** Estos laboratorios se usan a menudo con alumnos de 16 y 17 años. Una copia es privada para el alumno que la inició. Un miembro del personal que da clase en el módulo puede abrirla para ver lo que ha hecho el alumno, y abrir el trabajo de un alumno queda anotado en el registro de accesos, que el alumno puede leer.

## Lo que no funciona en un laboratorio

Un pequeño número de desafíos necesitan Internet o un servicio de IA y no se pueden resolver en un laboratorio, que no tiene salida. El estado de la tienda se guarda en memoria, así que desaparece cuando el laboratorio se detiene: usa el código para continuar. Recibe 512 MB.

## Solución de problemas

- **La tienda no se abre justo después de Iniciar.** Espera unos segundos y pulsa Abrir otra vez: el laboratorio solo se declara listo cuando la tienda responde.
- **En tu ordenador, el puerto 3000 ya está en uso.** Cambia el número de la izquierda en `local.yaml`, por ejemplo `127.0.0.1:3001:3000`, y abre ese puerto en su lugar.
- **Un desafío necesita Internet.** No se puede resolver aquí, a propósito.

## Comprobar el laboratorio

`test/check.sh` inicia el laboratorio como el ejecutor de la plataforma inicia cada servicio (todas las capacidades retiradas, `no-new-privileges`, un límite de procesos, límites de memoria y sin salida a Internet) y luego comprueba desde dentro de su red lo que promete esta página. Necesita Docker y se ejecuta en cada push, que es la insignia de arriba.

```bash
test/check.sh
```

## Versiones y licencias de terceros

[OWASP Juice Shop](https://github.com/juice-shop/juice-shop) tiene licencia MIT. La imagen es `bkimminich/juice-shop:v20.3.0`.

## Licencia

Esta obra está bajo licencia [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/). Puedes compartirla y adaptarla para aprender y enseñar, si citas a Mitsuru Technologies Ltd, no la usas comercialmente y compartes lo que hagas con ella bajo la misma licencia. El texto completo está en el archivo `LICENSE`. Cubre el archivo compose, las pruebas y esta documentación. La aplicación que contiene conserva la licencia de su propio proyecto, enlazada arriba.

## Acerca de

Creado por [Mitsuru Technologies](https://mitsurutech.co.uk) para la [plataforma de aprendizaje MitsuruTech](https://mitsurutech.co.uk/es/learning): Python, Java, Go, Node, SQL y Linux en el navegador para escuelas y centros, con laboratorios de contenedores, aplicaciones web desplegadas desde GitHub y cuestionarios que se califican solos. Prueba código sin cuenta en el [entorno de pruebas](https://mitsurutech.co.uk/es/playground).

Más laboratorios del mismo sitio: [lab-juice-shop](https://github.com/mitsurutech/lab-juice-shop), [lab-dvwa](https://github.com/mitsurutech/lab-dvwa), [lab-webgoat](https://github.com/mitsurutech/lab-webgoat), [lab-mysql-phpmyadmin](https://github.com/mitsurutech/lab-mysql-phpmyadmin), [lab-git-gitea](https://github.com/mitsurutech/lab-git-gitea) y [lab-sample](https://github.com/mitsurutech/lab-sample).
