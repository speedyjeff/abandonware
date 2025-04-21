# Psuedo Machine
This project started off with the aspiration of writing a booter - at the time running X86 on a floppy disk.  After several attempts, long boot cycles, and terrible debugging experience, this project pivoted to writing the kerel and OS sub systems with the goal of going back to booting on bar metal.  

The goal for the psuedo machine was to use modern C tools and be able to run successfully with a custom memory management, file system, IO, etc. all with minimal need from the underlying system.

The following documents contain how the system is built:
 - [architecture](docs/architecture.md)
 - [developers guide](docs/guide.md)
 - [tools](docs/tools.md)

The more modern version of the problem I started with, would be to port this to Arm and boot on a bare metal raspberry pi. :)
