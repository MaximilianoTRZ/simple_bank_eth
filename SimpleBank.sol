// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

contract SimpleBank {
    // 
    // Variables de estado
    // 

    /* Rellenar con la palabra clave de visibilidad. 
    Pista: Queremos proteger el saldo de nuestros usuarios de otros contratos */
    mapping(address => uint) private balances;

    /* Rellenar con la palabra clave de visibilidad. 
    Queremos crear una función getter y permitir 
    que los contratos vean si un usuario está inscrito.  */
    mapping(address => bool) public enrolled;

    /* Asegurémonos de que todos sepan quién es el dueño del banco. 
    Usa la palabra clave de visibilidad adecuada para esto */
    address public owner;

    // 
    // Eventos
    // 

    /* Agrega un argumento para este evento, una dirección de cuenta */
    event LogEnrolled(address newEnrolled);

    /* Agrega 2 argumentos para este evento, una dirección de cuenta y una cantidad */
    event LogDepositMade(address depositor, uint amount);

    /* Crea un evento llamado LogWithdrawal */
    /* Agrega 3 argumentos para este evento, una dirección de cuenta, 
    una cantidad a retirar y un nuevo saldo */
    // event
    event LogWithdrawal(address user, uint withdrawAmount, uint newAmount);

    //Used to log receive and fallback, and its remaining gas
    event Log(string func, uint gas);

    //
    // Modifiers
    //
    modifier erolledUser {
        require(enrolled[msg.sender], "User not enrolled");
        _; 
    }

    modifier amountGreaterThanZero (uint256 _amount) {
        require(_amount > 0, "The amount must be greater than 0");
        _;
    }

    // 
    // Funciones
    // 

    /* Usa la variable global apropiada para obtener el remitente de la transacción */
    constructor() {
        /* El owner es el creador de este contrato */
        owner = msg.sender;
    }

    // Función para recibir Ether (completar)
    receive() external payable {
        // emit Log("receive", gasleft());
    }

    fallback() external payable {
        // emit Log("fallback", gasleft());
    }

    /// @notice Consultar saldo
    /// @return El saldo del usuario
    function getBalance() external view returns (uint) {
        /* Obtiene el saldo del remitente de esta transacción */
        return balances[msg.sender];
    }

    /// @notice Inscribir a un cliente en el banco
    /// @return El estado de inscripción del usuario
    // Emite el evento apropiado
    function enroll() public returns (bool) {
        require(!enrolled[msg.sender], "User already enrolled");
        // ...
        enrolled[msg.sender]= true;
        emit LogEnrolled(msg.sender);
        return enrolled[msg.sender];
    }

    /// @notice Depositar ether en el banco
    /// @return El saldo del usuario después de que se haya hecho el depósito
    // Agrega la palabra clave adecuada para que esta función pueda recibir ether
    // Los usuarios deben estar inscritos antes de que puedan hacer depósitos
    // Usa las variables globales apropiadas para obtener el remitente de la transacción y el valor
    // Agrega la cantidad al saldo del usuario
    // Emite el evento apropiado
    // devuelve el saldo del usuario
    function deposit() public payable erolledUser amountGreaterThanZero(msg.value) returns (uint) {
        // require(enrolled[msg.sender], "User not enrolled");
        // ...
        // require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
        emit LogDepositMade(msg.sender, msg.value);
        return balances[msg.sender];
    }

    /// @notice Retirar ether del banco
    /// @dev Esta función no devuelve ningún excedente de ether enviado a ella
    /// @param withdrawAmount cantidad que quieres retirar
    /// @return El saldo restante para el usuario
    // Si el saldo del remitente es al menos la cantidad que quiere retirar
    // intenta enviar esa cantidad de ether al usuario que intenta retirar. 
    // Emite el evento apropiado
    function withdraw(uint withdrawAmount) public erolledUser amountGreaterThanZero(withdrawAmount) returns (uint) {
        // require(enrolled[msg.sender] , "User not enrolled");
        // ...
        require(balances[msg.sender] >= withdrawAmount, "Insufficient user funds");
        balances[msg.sender] -= withdrawAmount;
        (bool success, ) = msg.sender.call{value: withdrawAmount}("");
        require(success, "Failed to withdraw Ether");
        emit LogWithdrawal(msg.sender, withdrawAmount, balances[msg.sender]);
        return balances[msg.sender];
    }
}
