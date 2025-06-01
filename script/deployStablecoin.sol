pragma solidity 0.8.20;

import {Script} from "../lib/forge-std/src/Script.sol";
import {Stablecoin} from "../src/Stablecoin.sol";


contract deployStable is Script {

    function run() public returns(Stablecoin stable) {
        vm.startBroadcast();
        string memory name = "stable coin";
        string memory symbol = "stable";
        stable = new Stablecoin();
        stable.initialize(name,symbol);
        vm.stopBroadcast();
        return stable;
    }
}