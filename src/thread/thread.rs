use crate::types::Address;

pub enum ThreadState {
    Ready,
    Running
}

pub struct Tcb {
    pub state: ThreadState,
    /// stack start (to be able to delocate later on)
    pub stack_base: Address,
    /// pointer backup for a suspended thread
    pub stack_ptr_bak: Option<Address>,
    /// stack size
    pub stack_size: usize,
}

impl Tcb {
    pub fn new(stack_ptr: Address, size: usize) -> Self {
        Tcb {
            state: ThreadState::Ready,
            stack_base: stack_ptr,
            stack_ptr_bak: None,
            stack_size: size
        }
    }
}
