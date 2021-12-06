%lang starknet
%builtins range_check

from starkware.cairo.common.alloc import alloc

@view
func read_array{range_check_ptr}(index : felt) -> (value : felt):
    # alloc space for array
    let (felt_array : felt*) = alloc()
    assert [felt_array] = 9
    assert [felt_array + 1] = 8
    assert [felt_array + 2] = 7
    assert [felt_array + 9] = 18

    # why don't we need paranthesis here?
    let val = felt_array[index]
    return (val)
end
