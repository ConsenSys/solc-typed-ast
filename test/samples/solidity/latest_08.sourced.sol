// ------------------------------------------------------------
// /test/samples/solidity/latest_08.sol
// ------------------------------------------------------------
pragma solidity ^0.8.0;
pragma abicoder v2;

import "./latest_imports_08.sol" as LI;

enum EnumABC { A, B, C }

/// UnitLevelError error docstring
error UnitLevelError084(uint code);

contract UncheckedMathExample {
    function test() public pure returns (uint) {
        uint x = 0;
        unchecked {
            x--;
        }
        return x;
    }
}

contract EmitsIdentifierPath is LI.SomeContract {
    using LI.SomeLib for LI.SomeContract.SomeStruct;

    constructor() LI.SomeContract() {}

    function test() public {
        LI.SomeContract.SomeStruct memory s = LI.SomeContract.SomeStruct(10);
    }

    function some() override(LI.SomeContract) public returns (uint) {
        return 2;
    }
}

contract UsesNewAddressMembers {
    function test() public {
        bytes memory code = address(0).code;
        bytes32 codeHash = address(0).codehash;
    }
}

contract CatchPanic {
    function test() public {
        UsesNewAddressMembers c = new UsesNewAddressMembers();
        try c.test() {} catch Error(string memory reason) {
            revert(reason);
        } catch Panic(uint _code) {
            if (_code == 0x01) {
                revert("Assertion failed");
            } else if (_code == 0x11) {
                revert("Underflow/overflow");
            }
        } catch {
            revert("Internal error");
        }
    }
}

contract Features082 {
    enum EnumXYZ { X, Y, Z }

    event Ev(uint a);

    modifier modStructDocs() {
        /// PlaceholderStatement docstring
        _;
    }

    function stmtStructDocs() public modStructDocs() {
        /// VariableDeclarationStatement docstring
        uint a = (1);
        /// ExpressionStatement docstring
        1;
        /// Block docstring
        {}
        /// EmitStatement docstring
        emit Ev(1);
        /// WhileStatement docstring
        while (false) /// Body Block docstring
        {
            /// Continue docstring
            continue;
        }
        /// DoWhileStatement docstring
        do /// Body Block docstring
        {
            /// Break docstring
            break;
        } while(true);
        /// ForStatement docstring
        for (uint n = (1); n < 1; n++) /// Body Block docstring
        {}
        /// IfStatement docstring
        if (false) /// True body Block docstring
        {} else /// False body Block docstring
        {}
        CatchPanic cp = new CatchPanic();
        /// TryStatement docstring
        try cp.test() {} catch Error(string memory reason) {} catch Panic(uint _code) {} catch {}
        /// InlineAssembly docstring
        assembly {}
        /// UncheckedBlock docstring
        unchecked {}
        /// Return docstring
        return;
    }
}

library LibErrors084 {
    /// LibErrors084.Lib error docstring
    error Lib(bytes b);
}

contract Features084 {
    /// Features084.Own error docstring
    error Own();

    function testAssemblyHexLiterals() public {
        assembly {
            let a := "test"
            let x := hex"112233445566778899aabbccddeeff6677889900"
            let y := hex"1234abcd"
            sstore(0, x)
            sstore(1, y)
            pop("\"3")
        }
    }

    function testBytesConcatBuiltin(bytes memory a, bytes memory b) public pure returns (bytes memory c) {
        return bytes.concat(a, b);
    }

    function testVariableDeclarationStatementDocString() public {
        /// VariableDeclarationStatement docstring
        uint a = 10;
    }

    function revertWithLib() public {
        /// RevertStatement docstring
        revert LibErrors084.Lib(hex"001122");
    }

    function revertWithOwn() public {
        revert Own();
    }

    function revertWithUnitLevelError() public {
        revert UnitLevelError084(1);
    }
}
// ------------------------------------------------------------
// /test/samples/solidity/latest_imports_08.sol
// ------------------------------------------------------------
pragma solidity ^0.8.0;
pragma abicoder v2;

contract SomeContract {
    struct SomeStruct {
        uint n;
    }

    function some() virtual public returns (uint) {
        return 1;
    }
}

library SomeLib {}
