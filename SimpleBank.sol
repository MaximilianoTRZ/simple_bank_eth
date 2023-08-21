// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

contract SimpleBank {
    // 
    // Variables de estado
    // 

    /* Rellenar con la palabra clave de visibilidad. 
    Pista: Queremos proteger el saldo de nuestros usuarios de otros contratos */
    mapping(address => uint) balances;

    /* Rellenar con la palabra clave de visibilidad. 
    Queremos crear una función getter y permitir 
    que los contratos vean si un usuario está inscrito.  */
    mapping(address => bool) enrolled;

    /* Asegurémonos de que todos sepan quién es el dueño del banco. 
    Usa la palabra clave de visibilidad adecuada para esto */
    address owner;

    // 
    // Eventos
    // 

    /* Agrega un argumento para este evento, una dirección de cuenta */
    event LogEnrolled();

    /* Agrega 2 argumentos para este evento, una dirección de cuenta y una cantidad */
    event LogDepositMade();

    /* Crea un evento llamado LogWithdrawal */
    /* Agrega 3 argumentos para este evento, una dirección de cuenta, 
    una cantidad a retirar y un nuevo saldo */
    // event 

    // 
    // Funciones
    // 

    /* Usa la variable global apropiada para obtener el remitente de la transacción */
    constructor() {
        /* El owner es el creador de este contrato */
        // ...
    }

    // Función para recibir Ether (completar)
    receive() {}

    /// @notice Consultar saldo
    /// @return El saldo del usuario
    function getBalance()  {
        /* Obtiene el saldo del remitente de esta transacción */
        // return ... ;
    }

    /// @notice Inscribir a un cliente en el banco
    /// @return El estado de inscripción del usuario
    // Emite el evento apropiado
    function enroll() public returns (bool) {
        require(!enrolled[msg.sender], "User already enrolled");
        // ...
        // 
        // 
    }

    /// @notice Depositar ether en el banco
    /// @return El saldo del usuario después de que se haya hecho el depósito
    // Agrega la palabra clave adecuada para que esta función pueda recibir ether
    // Los usuarios deben estar inscritos antes de que puedan hacer depósitos
    // Usa las variables globales apropiadas para obtener el remitente de la transacción y el valor
    // Agrega la cantidad al saldo del usuario
    // Emite el evento apropiado
    // devuelve el saldo del usuario
    function deposit() public returns (uint) {
        require(, "User not enrolled");
        // ...
        // 
        // 
    }

    /// @notice Retirar ether del banco
    /// @dev Esta función no devuelve ningún excedente de ether enviado a ella
    /// @param cantidadARetirar cantidad que quieres retirar
    /// @return El saldo restante para el usuario
    // Si el saldo del remitente es al menos la cantidad que quiere retirar
    // intenta enviar esa cantidad de ether al usuario que intenta retirar. 
    // Emite el evento apropiado
    function withdraw(uint withdrawAmount) returns (uint) {
        // require(, "User not enrolled");
        // ...
        // 
        // 
        // 
    }
}
