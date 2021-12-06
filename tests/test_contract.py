# """contract.cairo test file."""
# import os

# import pytest
# from starkware.starknet.testing.starknet import Starknet

# # The path to the contract source code.
# CONTRACT_FILE = os.path.join("contracts", "contract.cairo")


# # The testing library uses python's asyncio. So the following
# # decorator and the ``async`` keyword are needed.
# @pytest.mark.asyncio
# async def test_increase_balance():
#     """Test increase_balance method."""
#     # Create a new Starknet class that simulates the StarkNet
#     # system.
#     starknet = await Starknet.empty()

#     # Deploy the contract.
#     contract = await starknet.deploy(
#         source=CONTRACT_FILE,
#     )

#     # Invoke increase_balance() twice.
#     await contract.increase_balance(amount=10).invoke()
#     await contract.increase_balance(amount=20).invoke()

#     # Check the result of get_balance().
#     execution_info = await contract.get_balance().call()
#     assert execution_info.result == (30,)

import pytest
import asyncio
from starkware.starknet.testing.starknet import Starknet


# Enables modules.
@pytest.fixture(scope='module')
def event_loop():
    return asyncio.new_event_loop()

# Reusable to save testing time.


@pytest.fixture(scope='module')
async def contract_factory():
    starknet = await Starknet.empty()
    contract = await starknet.deploy("contracts/hello_world.cairo")
    return starknet, contract


@pytest.mark.asyncio
async def test_contract(contract_factory):
    starknet, contract = contract_factory

    # Read from contract
    response = await contract.greeting().call()
    assert response.result == (
        10000805121215,
        10002315181204)
