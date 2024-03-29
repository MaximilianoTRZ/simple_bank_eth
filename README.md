# Simple Bank Project

# How to run this project and deploy to Sepolia

## install dependencies

`npm i`

## run tests

`npx hardhat test`

## deploy to Sepolia

`npx hardhat run scripts/deploy.js --network sepolia`

## Verify contract

`npx hardhat verify --network sepolia <contract address>`

---

# Ejercicio de Simple Bank

Implementación del contrato SimpleBank.sol. ¡El banco es capaz de inscribir nuevos usuarios y permite hacer depósitos y retiros!

El caso de uso del contrato Simple Bank es el siguiente:

- El contrato mantendrá información sobre usuarios registrados y sus saldos.
- Los usuarios podrán registrarse en el Simple Bank.
- Los usuarios, una vez registrados, pueden hacer depósitos en su cuenta.
- Los usuarios pueden verificar su saldo de cuenta en cualquier momento.
- Los usuarios pueden retirar parte o la totalidad del saldo en su cuenta, siempre y cuando haya un saldo disponible para ello.

## Requisitos

1. Crea un nuevo proyecto de _Hardhat_, agrega el contrato proporcionado.
2. Implementa todas las funciones, eventos y cualquier cosa mencionada en los comentarios del código en el contrato.

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
