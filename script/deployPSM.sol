pragma solidity 0.8.20;

import {Script} from "../lib/forge-std/src/Script.sol";
import {psm} from "../src/PSM.sol";
import {Stablecoin} from "../src/Stablecoin.sol";

contract deployPSM is Script {

    function run() public returns(psm psmContract){
        vm.startBroadcast();
        Stablecoin stable = new Stablecoin();
        stable.initialize("stable coin", "stable");
        Stablecoin underlying = new Stablecoin();
        underlying.initialize("underlying coin","ucoin");
        psmContract = new psm();
        psmContract.initialize(address(stable),address(underlying));
        vm.stopBroadcast();

    }
}