#![allow(unstable)]
#![allow(dead_code)]

use std::io::{stdio,timer};
use std::sync::{Arc, Mutex};
use std::sync::mpsc::{sync_channel, channel, Sender};
use std::thread::Thread;
use std::time::duration::Duration;

const N: usize = 16;
const DINE_MS: i64 = 500;

fn main() {
    sleeping_barbers();
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
const NBARBERS: usize = 3;

fn sleeping_barbers() {
    type Message = (usize, Sender<usize>);
    let (queue_back, queue_front) = sync_channel::<Message>(0);
    let queue_front = Arc::new(Mutex::new(queue_front));
    let free_seats  = Arc::new(Mutex::new(SEATS));

    // Barber:
    for j in (0 .. NBARBERS) {
        let free_seats = free_seats.clone();
        let queue_front = queue_front.clone();

        Thread::spawn(move|| {
            loop {
                let (customer, done) =
                    queue_front.lock().unwrap().recv().unwrap();
                *free_seats.lock().unwrap() += 1;

                println!("Barber {} begins customer {}", j, customer);
                timer::sleep(Duration::milliseconds(HAIRCUT_MS));
                done.send(j).unwrap();
                println!("Barber {} finishes customer {}", j, customer);
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

                let (done_send, done_recv) = channel();

                queue_back.send((i, done_send)).unwrap();
                println!("Customer {} begins getting cut", i);

                let j = done_recv.recv().unwrap();
                println!("Customer {} done getting cut by barber {}", i, j);
            });
        }
    });
}
