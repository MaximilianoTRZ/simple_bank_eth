// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.4;

contract SimpleBank {

    //
    //State variables
    //
    address public owner;

    struct User{
        address userId;
        bool enrolled;
        uint balance;
    }

    mapping(address => User) private users;

    //
    // Events
    //    
    event LogEnrolled(address newEnrolled);
    event LogDepositMade(address depositor, uint amount);
    event LogWithdrawal(address user, uint withdrawAmount, uint newAmount);

    //
    // Modifiers
    //
    modifier enrolledUser {
        require(users[msg.sender].enrolled, "User not enrolled");
        _; 
    }

    modifier greaterThanZeroAmount (uint256 amount) {
        require(amount > 0, "The amount must be greater than 0");
        _;
    }

    //
    // Functions
    //
    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}
    fallback() external payable {}

    /// @notice Check balance
    /// @return User balance
    function getBalance() external view returns (uint) {
        return users[msg.sender].balance;
    }

    /// @notice Enroll a customer at the bank
    /// @return The User enrollment status
    function enroll() public returns (bool) {
        require(!users[msg.sender].enrolled, "User already enrolled");

        users[msg.sender] = User({
            userId: msg.sender,
            enrolled: true,
            balance: 0
        });
        emit LogEnrolled(msg.sender);
        return users[msg.sender].enrolled;
    }

    /// @notice Checks if a User is enrolled
    /// @param user the User address to check enrollment
    /// @return The User enrollment status
    function enrolled(address user) public view returns (bool) { 
        return users[user].enrolled;
    }

    /// @notice Deposit Ether in the bank
    /// @return The user's balance after the deposit has been made
    function deposit() public payable enrolledUser greaterThanZeroAmount(msg.value) returns (uint) {
        users[msg.sender].balance += msg.value;
        emit LogDepositMade(msg.sender, msg.value);
        return users[msg.sender].balance;
    }

    /// @notice Withdraw Ether from the bank
    /// @dev This function does not return any surplus Ether sent to it
    /// @param withdrawAmount Amount you want to withdraw
    /// @return User remaining balance
    function withdraw(uint withdrawAmount) public enrolledUser greaterThanZeroAmount(withdrawAmount) returns (uint) {
        require(users[msg.sender].balance >= withdrawAmount, "Insufficient user funds");
        users[msg.sender].balance -= withdrawAmount;
        (bool success, ) = msg.sender.call{value: withdrawAmount}("");
        require(success, "Failed to withdraw Ether");
        emit LogWithdrawal(msg.sender, withdrawAmount, users[msg.sender].balance);
        return users[msg.sender].balance;
    }
}
