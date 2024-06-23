// SPDX-License-Identifier: MIT

pragma solidity 0.8.25;

contract MyContractV1 {
    uint public x;

    function setX(uint _x) public {
        x = _x;
    }
}

// Proxy contract
contract MyProxy {
    address public implementation;

    constructor(address _implementation) {
        implementation = _implementation;
    }

    receive() external payable {
    }

    fallback() external payable {
        address impl = implementation;
        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize())
            let result := delegatecall(gas(), impl, ptr, calldatasize(), 0, 0)
            returndatacopy(ptr, 0, returndatasize())
            revert(ptr, returndatasize())
        }
    }

    function upgradeTo(address _newImplementation) public {
        implementation = _newImplementation;
    }

 
    function setX(uint _x) public {
        (bool success, ) = implementation.delegatecall(
            abi.encodeWithSignature("setX(uint256)", _x)
        );
        require(success, "Delegatecall failed");
    }

  
    function getX() public view returns (uint) {
        (bool success, bytes memory data) = implementation.staticcall(
            abi.encodeWithSignature("x()")
        );
        require(success, "StaticCall failed");
        return abi.decode(data, (uint));
    }
}
