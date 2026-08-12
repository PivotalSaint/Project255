// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title SoulButtcoin
 * @dev ERC-20 with the maximum possible decimals (255).
 * WARNING: 10**255 is an extremely large number.
 * Most wallets, explorers, DEXes and UIs will not handle it correctly.
 * This is essentially unusable in practice and is provided only for illustration.
 */
contract SoulButtcoin is ERC20 {
    constructor() ERC20("SoulButtcoin", "SBTC") {
        // Mint a tiny human-readable amount.
        // Even 1 token = 10**255 base units.
        _mint(msg.sender, 255 * 10 ** decimals());
    }

    function decimals() public pure override returns (uint8) {
        return 255; // maximum value of uint8
    }
}
# 1. Create the mint with 255 decimals + metadata pointer + token metadata extensions
spl-token --program-id TokenzQdBNbLqP5VEhdkAS6EPFLC1PHnBqCXEpPxuEb \
  create-token \
  --decimals 255 \
  --enable-metadata \
  --enable-metadata-pointer

# Note the new mint address that is printed (call it <NEW_MINT_ADDRESS>)

# 2. Initialize the metadata
spl-token initialize-metadata <NEW_MINT_ADDRESS> \
  "SoulButtcoin" \
  "SBTC" \
  "https://raw.githubusercontent.com/PivotalSaint/Project255/main/metadata.json"   # optional URI

# 3. Create your token account
spl-token create-account <NEW_MINT_ADDRESS>

# 4. Mint the maximum practical amount that still fits in a u64
#    (u64 max ≈ 1.84e19). With 255 decimals this is still an astronomically small human amount.
spl-token mint <NEW_MINT_ADDRESS> 18446744073709551615