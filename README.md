Demo MonkeyBarrel
--

# Get the source code

```
git clone git@github.com:waterkip/Monkey-Barrel-Demo.git
```

# Installation

For those who do not have libjpeg8 on their own box, please use the following
docker image:

```
cd ~/code
git clone git@github.com:waterkip/connectiq-sdk-docker.git
cd connectiq-sdk-docker
./dev-bin/build

# Please consult the README.md in this project for more information

# TLDR
docker-compose run --rm connectiq
# You are now inside the docker container
# Run sdkmanager to get the SDK and devices you need
sdkmanager

```

# Building the monkey barrel

The following will assume you run things from within docker or you have a host
capable of running barrelbuild/barreltest. If you run it with the above
mentioned docker image, you can use `make barrel` instead of `barrelbuild` and
you can use `make test` instead of `barreltest`.

```
docker-compose run --rm connectiq
# You are now in the docker container and should be able to execute commands

# This works
barrelbuild -w -l 0 \
  -o bin/monkeybarreldemo.barrel \
  -f /home/ciq/src/monkey.jungle

```

You cannot barreltest it yet:

```
/home/ciq/.Garmin/ConnectIQ/Sdks/connectiq-sdk-lin-4.1.4-2022-06-07-f86da2dee//bin/barreltest -w -l 0 \
  -o bin/fenix6-monkeybarreldemo-3.2.6.test.barrel \
  -d fenix6 \
  -c 3.2.6 \
  -y /home/ciq/.Garmin/ConnectIQ/developer.der \
  -f /home/ciq/src/monkey.jungle
```

This is because you don't have a device in the manifest yet, please patch the
file with `patch -p1 < patches/fenix6.patch`. Or supply your own device. Make
sure the device manager has the fenix6 or your own device installed.

```
/home/ciq/.Garmin/ConnectIQ/Sdks/connectiq-sdk-lin-4.1.4-2022-06-07-f86da2dee//bin/barreltest -w -l 0 \
  -o bin/fenix6-monkeybarreldemo-3.2.6.test.barrel \
  -d fenix6 \
  -c 3.2.6 \
  -y /home/ciq/.Garmin/ConnectIQ/developer.der \
  -f /home/ciq/src/monkey.jungle
```

This now works. The barrel isn't a ZIP container at this time:

```
file bin/fenix6-monkeybarreldemo-3.2.6.test.barrel
bin/fenix6-monkeybarreldemo-3.2.6.test.barrel: data
```

This looks like a regular app so let's do what we do with testing regular apps:

1) Start the simulator and
2) Run monkeydo on it

```
simulator & # We need to throw it into the background
monkeydo ./bin/fenix6-monkeybarreldemo-3.2.6.test.barrel fenix6 -t
```

The simulator now shows a fenix6 (or your device), but doesn't do much. It just
hangs.

You can exit the by hitting <Ctrl-C>. In order to stop the simualator you can
use `pkill simulator`.

Now it is time to actual test the barrel and see what happens

```
patch -p0 < patches/add-tests.patch

# We cannot test the barrel
barreltest -w -l 0 \
  -o bin/fenix6-monkeybarreldemo-3.2.6.test.barrel \
  -d fenix6 \
  -c 3.2.6 \
  -y /home/ciq/.Garmin/ConnectIQ/developer.der \
  -f /home/ciq/src/monkey.jungle
ERROR: fenix6: /home/ciq/src/source/t/TestMonkeyBarrelDemo.mc:16: Undefined symbol "foo" detected.
ERROR: fenix6: /home/ciq/src/source/t/TestMonkeyBarrelDemo.mc:22: Undefined symbol "bar" detected.
WARNING: fenix6: No supported languages are defined. It's a good idea to indicate which languages you are supporting.

# but we can build it?
barrelbuild -w -l 0 \
  -o bin/monkeybarreldemo.barrel \
  -f /home/ciq/src/monkey.jungle
```
