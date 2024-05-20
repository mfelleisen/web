#![allow(unstable)]
#![allow(dead_code)]

use std::io::{stdio,timer};
use std::sync::{Arc, Mutex};
use std::sync::mpsc::{sync_channel};
use std::thread::Thread;
use std::time::duration::Duration;

const N: usize = 16;
const DINE_MS: i64 = 500;

fn main() {
    sleeping_barber_3();
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

fn sleeping_barber_3() {
    let (queue_back, queue_front) = sync_channel::<usize>(0);
    let free_seats  = Arc::new(Mutex::new(SEATS));

    // Barber:
    {
        let free_seats = free_seats.clone();

        Thread::spawn(move|| {
            for i in queue_front.iter() {
                *free_seats.lock().unwrap() += 1;

                println!("Barber begins cutting customer {}", i);
                timer::sleep(Duration::milliseconds(HAIRCUT_MS));
                println!("Barber finishes cutting customer {}", i);
            }
        });
    }

    // Customers:
    Thread::spawn(move|| {
        for i in (0 ..) {
            timer::sleep(Duration::milliseconds(ARRIVAL_MS));

            let free_seats = free_seats.clone();
            let queue_back = queue_back.clone();

            Thread::spawn(move|| {
                {
                    let mut free_seats = free_seats.lock().unwrap();

                    if *free_seats == 0 {
                        println!("Customer {} gives up", i);
                        return;
                    } else {
                        println!("Customer {} sits down", i);
                        *free_seats -= 1;
                    }
                }

                queue_back.send(i).unwrap();
                println!("Customer {} begins getting cut", i);
            });
        }
    });
}

