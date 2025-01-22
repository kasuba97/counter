/// Module: counter
module counter::counter;

public struct Counter has key,store {
    id:UID,
    owner:address,
    value:u64
}

#[error]
const EValueAlreadyAtZero:u64 = 0;

/// creates new counter object
public fun new(ctx:&mut TxContext):Counter{
    let counter  = Counter {
        id:object::new(ctx),
        owner:ctx.sender(),
        value:0,
    };

    counter
}

/// increments count in users account
public fun increment(counter:&mut Counter){
    counter.value = counter.value+1;
}

/// decrements count in users account
public fun decrement(counter:&mut Counter){
    assert!(counter.value == 0,EValueAlreadyAtZero);
    counter.value = counter.value-1;
}

/// deletes counter object 
public fun delete(counter:Counter){
    let Counter{id,..} = counter;

    id.delete()
    
}