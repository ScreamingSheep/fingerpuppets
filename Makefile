# The build target.
TARGET=box2d

# The simulated device.
DEVICE=172.16.238.129

# The devlopment password for the device.
PASSWORD=vgss

# Build files.
SWF=fingerpuppets.swf
BAR=fingerpuppets.bar
XML=fingerpuppets.xml
DESC=blackberry-tablet.xml
ASSETS=assets

# The main source entry point. Every slice should have a file like this.
AS=fingerpuppets.as

# Installs the application on the blackberry simulator.
all: debug
release: target install
debug: debug-target debug-install
debugger: 

# Compiles the swf file.
target:
	cd $(TARGET); amxmlc --output ../app/$(SWF) $(AS)

debug-target:
	cd $(TARGET); amxmlc --debug --output ../app/$(SWF) $(AS)

# Installs the package.
install:
	cd app; blackberry-airpackager -package $(BAR) -installApp -launchApp $(XML) $(SWF) $(DESC) $(ASSETS) -device $(DEVICE) -password $(PASSWORD) 

debug-install:
	cd app; blackberry-airpackager -package $(BAR) -target bar-debug -installApp -launchApp $(XML) $(SWF) $(DESC) $(ASSETS) -device $(DEVICE) -password $(PASSWORD) -devMode

# Lists applications currently installed.
list:
	blackberry-deploy -listInstalledApps -device $(DEVICE) -password $(PASSWORD) 

clean:
	# Clean up the binaries.
	rm app/$(BAR)
	rm app/$(SWF)

