#![allow(unstable)]
#![allow(dead_code)]

use std::io::{stdio,timer};
use std::sync::{Arc, Mutex};
use std::thread::Thread;
use std::time::duration::Duration;

const N: usize = 16;
const DINE_MS: i64 = 500;

fn main() {
    //dining_philosophers();

    //sleeping_barber();
    //sleeping_barber_2();
    //sleeping_barber_3();
    //sleeping_barbers();
    
    wait_for_enter();
}


fn wait_for_enter() {
    print!("Press enter to continue");
    stdio::flush();
    let _ = stdio::stdin().read_line();
}

fn dining_philosophers() {
    let forks: Vec<Arc<Mutex<usize>>> =
        (0 .. N).map(Mutex::new).map(Arc::new).collect();

    for i in (0 .. N) {
        let j = (i + 1) % N;

        let fork1 = forks[std::cmp::min(i, j)].clone();
        let fork2 = forks[std::cmp::max(i, j)].clone();

        Thread::spawn(move|| {
            loop {
                let guard1 = fork1.lock().unwrap();
                println!("Philosopher {} picks up fork {}", i, *guard1);

                let guard2 = fork2.lock().unwrap();
                println!("Philosopher {} picks up fork {}", i, *guard2);

                println!("Philosopher {} begins dining", i);
                timer::sleep(Duration::milliseconds(DINE_MS));
                println!("Philosopher {} finishes dining", i);
            }
        });
    }
}

