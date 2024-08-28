# What?
Demo of User Mode Linux (UML), packaged with Nix.

UM Linux is Linux ported to itself. Akin to Zephyr RTOS's native_posix.

This demo defines two Nix packages: UML and a root_fs.
The UML is very new as of today, kernel 6.10.
The root_fs is very old, centos 6.


# Why?
UML allows running programs under older or newer kernels than your host system's.
UML is great for debugging.


# How?
Just run `nix-shell` to be dropped into a CentOS 6 login TTY.

Note that `pkill --exact linux` may be handy when you've had enough.


# References
https://www.kernel.org/doc/html/v5.9/virt/uml/user_mode_linux.html

