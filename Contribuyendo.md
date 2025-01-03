Contribuyendo
¡Hola! Nos alegra mucho que quieras contribuir a este proyecto. Tu ayuda es fundamental para que siga funcionando.

Las contribuciones a este proyecto se publican bajo la licencia MIT .

Tenga en cuenta que este proyecto se publica con un Código de conducta para colaboradores . Al participar en este proyecto, usted acepta cumplir con sus términos.

Enviar una solicitud de extracción
Bifurcar y clonar el repositorio.
Crear una nueva rama: git checkout -b my-branch-name.
Realice sus cambios, asegurándose de que incluyan los pasos para instalar, validar la posinstalación y actualizar el informe del software (consulte Cómo agregar una nueva herramienta para obtener más detalles).
Pruebe sus cambios creando una imagen e implementando una VM .
Empújelo a su bifurcación y envíe una solicitud de extracción .
Aquí hay algunas cosas que puede hacer para aumentar la probabilidad de que se acepte su solicitud de extracción:

Siga la guía de estilo de PowerShell al escribir scripts de Windows. Actualmente no existe un estilo establecido para los scripts de Shell que ejecutan instalaciones de Linux 🔜.
Incluya detalles completos de por qué esto es necesario en la descripción de relaciones públicas.
Mantenga el cambio lo más centrado posible. Si hay varios cambios que desea realizar que no dependen entre sí, considere enviarlos como solicitudes de incorporación de cambios independientes.
Escribe buenos mensajes de confirmación .
Para nuevas herramientas:
Asegúrese de que la herramienta cumpla con las Pautas de software .
Cree un problema y obtenga nuestra aprobación para agregar esta herramienta a la imagen antes de crear la solicitud de extracción.
Cómo agregar una nueva herramienta
Reglas generales
Para cada nueva herramienta, agregue scripts de validación y actualice el script del informe del software para garantizar que esté incluido en la documentación.
Si la herramienta está disponible en varias plataformas (MacOS, Windows, Linux), asegúrese de incluirla en tantas como sea posible.
Si instala varias versiones de la herramienta, considere colocar la lista de versiones en el toolset.jsonarchivo correspondiente. Esto ayudará a otros clientes a configurar sus compilaciones de manera flexible. Vea toolset-windows-2019.json como ejemplo.
Utilice nombres consistentes en todos los archivos.
Los scripts de validación deben ser simples y no deben cambiar el contenido de la imagen.
Ventanas
Agregue un script que instalará la herramienta y colóquelo en la scripts/buildcarpeta. Hay varias funciones auxiliares que podrían simplificar su código: Install-ChocoPackage, Install-Binary, Install-VSIXFromFile, Install-VSIXFromUrl, Invoke-DownloadWithRetry, Test-IsWin19, Test-IsWin22(encuentre la lista completa de funciones auxiliares en ImageHelpers.psm1 ).
Agregue un script que validará la instalación de la herramienta y colóquelo en la scripts/testscarpeta. Usamos Pester v5 para scripts de validación. Si las pruebas para la herramienta son lo suficientemente complejas, cree un archivo *.Tests.ps1. De lo contrario, utilícelo Tools.Tests.ps1para pruebas simples. Agregue Invoke-PesterTests -TestFile <testFileName> [-TestName <describeName>]al final del script de instalación para asegurarse de que se ejecutarán sus pruebas.
Agregue cambios al generador de informes de software images/windows/scripts/docs-gen/Generate-SoftwareReport.ps1. El generador de informes de software se utiliza para generar el archivo README de una imagen, por ejemplo, Windows2019-Readme.md y utiliza MarkdownPS .
Ubuntu
Agregue un script que instalará y validará la herramienta y colóquelo en la scripts/buildcarpeta. Use scripts existentes como github-cli.sh como punto de partida.
Utilice ayudantes para simplificar el proceso de instalación.
La parte de validación debería exit 1si hay algún problema con la instalación.
Agregar cambios al generador de informes de software images/ubuntu/scripts/docs-gen/Generate-SoftwareReport.ps1. El generador de informes de software se utiliza para generar un archivo README de una imagen, por ejemplo, Ubuntu2004-Readme.md y utiliza MarkdownPS .
macOS
El código fuente de macOS se encuentra en este repositorio y está disponible para todos. Sin embargo, la CI de generación de imágenes de macOS aún no admite contribuciones externas, por lo que no podemos aceptar solicitudes de incorporación de cambios por ahora. Estamos en el proceso de preparar la CI de macOS para que acepte contribuciones. Hasta entonces, agradecemos su paciencia y le pedimos que continúe enviando solicitudes de herramientas mediante la presentación de problemas.

Recursos
Cómo contribuir al código abierto
Uso de solicitudes de extracción
Ayuda de GitHub
