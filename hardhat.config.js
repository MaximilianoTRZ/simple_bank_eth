require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
// Ve a https://infura.io, regístrate, crea una nueva clave API
// en su panel, y reemplázala por "KEY"
const INFURA_API_KEY = process.env.INFURA_API_KEY;

// Reemplaza esta clave privada por la clave privada de tu cuenta Sepolia
// Para exportar tu clave privada desde Metamask, abre Metamask y
// ve a Detalles de la Cuenta > Exportar Clave Privada
// Advertencia: NUNCA coloques Ether real en cuentas de prueba
const SEPOLIA_PRIVATE_KEY = process.env.SEPOLIA_PRIVATE_KEY;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.4",

  networks: {
    sepolia: {
      url: `https://sepolia.infura.io/v3/${INFURA_API_KEY}`,
      accounts: [SEPOLIA_PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
};
