# repeater-remote-controller
A solution for remotely managing the repeaters. It's based on a Raspberry PI with Raspbian system


## Setup
In order to execute the setup script, you can either:
- (if you have a monitor, keyboard and mouse connected to your Raspberry) open a console window (Terminal) from the Raspbian menu
or
- (if you have NO monitor, keyboard and mouse connected to your Raspberry) use a ssh client (Putty) to connect remotely to your Raspberry
then just copy & paste this to the command prompt on the Raspbian and press return:

```
curl -k https://raw.githubusercontent.com/dmr-italia/repeater-remote-controller/master/setup.sh \
| sudo bash
```