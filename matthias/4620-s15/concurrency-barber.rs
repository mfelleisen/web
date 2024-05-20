#![allow(unstable)]
#![allow(dead_code)]

use std::io::{stdio,timer};
use std::sync::{Arc, Mutex, Semaphore};
use std::thread::Thread;
use std::time::duration::Duration;

const N: usize = 16;
const DINE_MS: i64 = 500;

fn main() {
    sleeping_barber();
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

fn sleeping_barber() {
    let free_seats      = Arc::new(Mutex::new(SEATS));
    let customers_ready = Arc::new(Semaphore::new(0));
    let barber_ready    = Arc::new(Semaphore::new(0));

    // Barber:
    {
        let free_seats = free_seats.clone();
        let customers_ready = customers_ready.clone();
        let barber_ready = barber_ready.clone();

        Thread::spawn(move|| {
            loop {
                customers_ready.acquire();
                *free_seats.lock().unwrap() += 1;

                println!("Barber begins cutting");
                barber_ready.release();

                timer::sleep(Duration::milliseconds(HAIRCUT_MS));

                println!("Barber finishes cutting");
            }
        });
    }

    // Customers:
    Thread::spawn(move|| {
        for i in (0us ..) {
            timer::sleep(Duration::milliseconds(ARRIVAL_MS));

            let free_seats = free_seats.clone();
            let customers_ready = customers_ready.clone();
            let barber_ready = barber_ready.clone();

            Thread::spawn(move|| {
                { // try without this scope ;)
                    let mut free_seats = free_seats.lock().unwrap();

                    if *free_seats == 0 {
                        println!("Customer {} gives up", i);
                        return;
                    } else {
                        println!("Customer {} sits down", i);
                        *free_seats -= 1;
                        customers_ready.release();
                    }
                }

                barber_ready.acquire();
                println!("Customer {} begins getting cut", i);
            });
        }
    });
}
