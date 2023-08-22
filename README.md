# Ejercicio de Simple Bank

En este ejercicio, vas a implementar el contrato SimpleBank.sol. ¡El banco debería ser capaz de inscribir nuevos usuarios y permitirles hacer depósitos y retiros! El contrato contiene la estructura y los comentarios para implementar el contrato. Sigue los comentarios indicados para implementarlo.

El caso de uso del contrato Simple Bank es el siguiente:

- El contrato mantendrá información sobre usuarios registrados y sus saldos.
- Los usuarios podrán registrarse en el Simple Bank.
- Los usuarios, una vez registrados, pueden hacer depósitos en su cuenta.
- Los usuarios pueden verificar su saldo de cuenta en cualquier momento.
- Los usuarios pueden retirar parte o la totalidad del saldo en su cuenta, siempre y cuando haya un saldo disponible para ello.

## Contract SimpleBank

![Contract SimpleBank](simpleBankUML.png)

## Requisitos

1. Crea un nuevo proyecto de _Hardhat_, agrega el contrato proporcionado.
2. Implementa todas las funciones, eventos y cualquier cosa mencionada en los comentarios del código en el contrato.

### Puntos adicionales

Además de las características requeridas, siéntete libre de agregar funciones adicionales para destacar tu código entre los demás.

### Cómo enviar mi respuesta

1. No recomendamos que subas tu solución a un repositorio público de Github, ya que otras personas podrían copiar tu solución.
2. Debes proporcionarnos un archivo ZIP con el proyecto de Hardhat (sin node_modules ni ninguna otra dependencia instalada).

### ¿Cuánto tiempo tengo para terminar?

Tómate tu tiempo dentro del plazo que te proporcionemos. Valoramos un código de alta calidad (nombres de variables, comentarios si es necesario, pruebas) en lugar de un código rápido.

### Bonus: 1 Modificador

1. Crea un `modifier()` que valide en las funciones `deposit()` y `withdraw()` que quien llame a la función sea un usuario inscrito.
2. Crea un `modifier()` que valide en las funciones `deposit()` y `withdraw()` que las cantidades pasadas como parámetro sean mayores que cero.

### Bonus: 2 Struct

Crea un `Struct{}` que contenga información del usuario (por ejemplo, userId, inscrito, saldo) y reemplaza los `mapping()` de _balances_ e _inscritos_:

```solidity
mapping(address => uint) private balances;
mapping(address => bool) public enrolled;
```

Por un nuevo `mapping()` de `(address => structUsuario)`.
Modifica las funciones correspondientes de acuerdo con este nuevo `mapping()`.

### Bonus: 3 Pruebas

Crea un archivo de pruebas para el contrato SimpleBank que te permita probar lo siguiente:

1. Inscribe al usuario y verifica si se marca correctamente como inscrito.
2. Realiza un depósito y verifica si el saldo es correcto.
3. Solo un usuario inscrito puede realizar un depósito.
4. Realiza un retiro de una cantidad correcta.
5. No poder retirar más de lo que se ha depositado.
