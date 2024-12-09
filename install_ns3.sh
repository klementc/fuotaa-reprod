# installs ns-3 with our version of the lora module under ${PWD}/deps
curDir=${PWD}

set +x
# Download ns-3
mkdir -p deps
cd deps
wget https://www.nsnam.org/releases/ns-allinone-3.41.tar.bz2
tar -xvjf ns-allinone-3.41.tar.bz2
cd ns-allinone-3.41/ns-3.41/

# Download lorawan module
git clone https://github.com/klementc/lorawan.git src/lorawan
cd src/lorawan
git checkout classA-open-windows
cd ../..

# Build
./ns3 configure --enable-tests --enable-examples
./ns3 build