# Mermelada Jam :honey_pot:

Repo para la [Mermelada Jam](https://itch.io/jam/mermelada-jam) de Endorth e Spain Game Devs.

En la carpeta [MermeladaJam1](/MermeladaJam1/) está el proyecto Godot con toda la info del juego.

- [Cómo trabajar con Github Web](#cómo-trabajar-con-github-web-earth_africa)
- [Cómo trabajar con Github Desktop](#cómo-trabajar-con-github-desktop-computer)
- [Cómo trabajar con git cli](#cómo-trabajar-con-git-cli-page_with_curl)

## Cómo trabajar con Github Web :earth_africa:

Usad GitHub como si fuera un disco duro, podeis incluir dentro de la carpeta de [MermeladaJam1](/MermeladaJam1/) lo que querais que se incluya en el juego. Para subir un archivo basta con abrir la carpeta y darle a subir ficheros:

![Añadir ficheros](images/captura1.png)

Podemos subir archivos desde la nueva interfaz, arrastrando o demás. Una vez hecho con todos los archivos, aceptamos los cambios poniendo un comentario bonito y apachurramos el botón verde:

![Añadir ficheros](images/captura2.png)

## Cómo trabajar con Github Desktop :computer:

Primeramente clonaremos el repo dandole a Add > Clone repository...:

![Clonar repo](images/captura3.png)

Podemos conectarnos a nuestra cuenta de GitHub o descargarlo desde la URL:

![Clona un repositiorio](images/captura4.png)

Lo mejor es conectarse. Luego seleccionamos una ruta local donde se descargará el repo y pulsamos "Clone".

Una vez clonado, veremos que tenemos el repo en local en la rama main:

![Repo clonado](images/captura5.png)

A partir de aquí, si ponemos archivos o carpetas en la ruta donde se ha bajado (en mi caso /home/nekerafa/repos/mermelada-jam), al abrir GitHub Desktop nos indicará los cambios a hacer:

![Cambios sin aplicar](images/captura6.png)

Podemos añadir los cambios poniendo un commit y pulsando el botón de commit to main. *Cuidado*: los cambios siguen estando en nuesto PC, hace falta subirlos pulsando el botón Push origin:

![Cambios sin subir](images/captura7.png)

Si hubiera cambios en el servidor de GitHub, puede que os salga el mensaje primero de Pull origin. Si lo pulsamos nos trae los cambios del servidor:

![Cambios sin descargar](images/captura8.png)

Y si no nos sale nada, pues pulsamos Fetch origin para asegurarnos.

### Trabajar con ramas

Podemos trabajar con nuevas ramas (que son como una copia de lo que hay en la rama principal), yendo a la sección de ramas:

![Listado de ramas](images/captura9.png)

En cada rama podemos hacer commits y subir sin tener que pisar lo que hay en main. Una vez creada la rama, podemos crear un pull request en GitHub Desktop o en GitHub Web. Lo importante es que en compare este la rama desde la que partimos, y en base la rama main:

![Crear pull request](images/captura10.png)

Lo importante es que todas las pull request quedan visibles en la web, por lo que ahí podemos revisar el código y demás:

![Pull request creada y cerrada](images/captura11.png)

## Cómo trabajar con git cli :page_with_curl:

Con git cli no se trabaja, se pelea xd.

Los comandos útiles son:

### Obtener repo

```sh
$ git clone https://github.com/AGPC94/mermelada-jam.git # o git@github.com:AGPC94/mermelada-jam.git si tenemos una clave ssh
```

### Subir y bajar cambios

```sh
$ git pull # Obtiene los cambios del servidor de GitHub
$ git add . # Pasa todos los cambios a staging, es decir, los marca para crear un comentario
$ git commit -m "Comment message" # Crea un comentario con los cambios en staging
$ git push # Envia los cambio al servidor
```

### Trabajar con ramas

```sh
$ git checkout <branch> # cambia a una rama

# ej: pasarse a la rama main
git checkout main
```

```sh
$ git checkout -b <branch> # crea una nueva rama

# ej: crear una rama para una nueva funcionalidad
git checkout -b feature/iconos_municion
```

```sh
$ git merge <branch> # une los cambios de una rama a la rama actual

# ej: obtener los cambios de la rama main
git merge main
```

# License

> Copyright mermelada-jam Contributors - 2023