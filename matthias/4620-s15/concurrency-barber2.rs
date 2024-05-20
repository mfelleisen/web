#![allow(unstable)]
#![allow(dead_code)]

use std::collections::dlist::DList;
use std::io::{stdio,timer};
use std::sync::{Arc, Mutex, Semaphore};
use std::thread::Thread;
use std::time::duration::Duration;

const N: usize = 16;
const DINE_MS: i64 = 500;

fn main() {
    sleeping_barber_2();
    wait_for_enter();
}


fn wait_for_enter() {
    print!("Press enter to continue");
    stdio::flush();
    let _ = stdio::stdin().read_line();
}

const SEATS: usize = 3;
const HAIRCUT_MS: i64 = 500;
const ARRIVAL_MS: i64 = 100;

fn sleeping_barber_2() {
    let seats: Arc<Mutex<DList<(usize, Arc<Semaphore>)>>> =
        Arc::new(Mutex::new(DList::new()));

    let customers_ready = Arc::new(Semaphore::new(0));

    // Barber:
    {
        let seats = seats.clone();
        let customers_ready = customers_ready.clone();

        Thread::spawn(move|| {
            loop {
                customers_ready.acquire();
                let (i, ready) = seats.lock().unwrap().pop_front().unwrap();

                println!("Barber begins cutting customer {}", i);
                ready.release();

                timer::sleep(Duration::milliseconds(HAIRCUT_MS));

                println!("Barber finishes cutting customer {}", i);
            }
        });
    }

    // Customers:
    Thread::spawn(move|| {
        for i in (0 ..) {
            timer::sleep(Duration::milliseconds(ARRIVAL_MS));

            let seats = seats.clone();
            let customers_ready = customers_ready.clone();

            Thread::spawn(move|| {
                let barber_ready: Arc<Semaphore>;

                {
                    let mut seats = seats.lock().unwrap();

                    if seats.len() == SEATS {
                        println!("Customer {} gives up", i);
                        return;
                    } else {
                        println!("Customer {} sits down", i);
                        barber_ready = Arc::new(Semaphore::new(0));
                        seats.push_back((i, barber_ready.clone()));
                        customers_ready.release();
                    }
                }

                barber_ready.acquire();
                println!("Customer {} begins getting cut", i);
            });
        }
    });
}
