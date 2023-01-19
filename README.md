# UpaxTest

Este pequeño proyecto fue creado como prueba técnica para el proceo de selección para el puesto de iOS Developer.
El proyecto tiene las siguientes características técnicas:
* Soporte apartir de iOS 11
* Versión de Pods 1.9.3
* Versión de Swift 4.2

## Observaciones
Algunas librerías de los pods son antiguas puesto que se requerían para algunas funcionalidades del proyecto, el cual está desarrollado con una versión anterior de swift. En algunos casos se tendrá que actualizar 
el código de alguna librería para que funcione con el proyecto.

Si algun problema pueden escribirme al correo: alda90dev@gmail.com

## Preguntas
### _Explique el ciclo de vida de un view controller_ 

Se compone por varios estados por los cuales el view controllar pasa, desde que se crea, se pausa o se regresa desde otra vista, hasta que desaparece. En 
estos estados podemos agregar funcionalidades según lo necesitemos
Algunos de estos estados son:
1. loadView - Estado donde se carga la vista
2. viewDidLoad - Estado donde la vista ya esta cargada
3. viewWillAppear - Estado antes de que aparezca la vista
4. viewDidAppear - Estado después de que apareció la vista
5. viewWillDisappear - Estado antes de que desaparezca la vista
6. viewDidDisappear - Estado después de que desapareció la vista


### _Explique el ciclo de vida de una aplicación_

Se compone de varios estados por los cuales la aplicación pasa, en los cuales puede recibir o no interacción y se le pueden añadir funcionalidades 
dependiendo el caso de uso. Los estados son los siguiente:
1. Not Running - estado en el que la aplicaci{on no está corriendo ni se ha iniciado
2. Inactive - esta el foreground pero no puede recibir eventos, algunos casos pueden ser cuando la app esta en primer y llegan mensajes o llamadas.
3. Active - Estado principal de la app, en el que puede recibir eventos
4. Background - Esta en el background pero puede ejecutar codigo mientras no esta en la pantalla mostrandose al usuario.
5. Suspended - La aplicación ya pasó mucho tiempo en el background y el sistema suspendió sus servicios por lo que está en memoria pero no puede recibir eventos.


### _En que casos se usa un weak un strong y unowned_
Cuando se declara una instancia en un objeto, automaticamente se crea como Strong, indicando que la instancia no se eliminará de memoria hasta que se
asigne nil.
Cuando se hacen referencia dos objetos al instanciarse mutuamente se crea un retain cycle, puesto que aunque se elimine uno, todavia quedara en la memoria
por la referencia con el otro objeto. Haciendo que se todavia se utilice memoria en un objeto que no se necesite.
Para evitar esto se pueden utilizar weak y unowned al momento de declarar una instancia. Con ambos al eliminar uno de los objetos, se borra de memoria
completamente apesar de que siga referenciado en el otro objeto (acá también ya no estará en memoria).
La diferencia es que con weak la instancia tiene que ser un opcional y con el unowned no. Por lo que cuando queramos quitar de memoria una instancia
unowned, debemos estar seguros de que tenga un valor.

### _¿Qué es el ARC?_
Es el Automatic Reference Counting, es un manejador de memoria en swift, el cual contabiliza el número de referencias que han sido creadas a partir de
una instancia, por ejemplo cuando fue asignada a una variable o cuando se pasó como referencia en un método. Cada vez que se va incrementado el contador
significa que más memoria ah sido ocupada, y cada vez que va decrementando la memoria esta siendo despejada, hasta llegar a 0, que es cuando se
elimina todo rastro de las instancias creadas.

### _Analisis de las pantallas_
Se aparecerá la pantalla con el color que se asigna dentro el metodo de viewDidLoad (el estado donde ya cargó la vista), porque en la funcion de inicio se la app, solo se está instanciando
el viewController, y enseguida cuando se le asigna el valor aun no está cargada la vista.
