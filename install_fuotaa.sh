# installs ns-3 with our version of the lora module under ${PWD}/deps
curDir=${PWD}

set +x
# Download ns-3
mkdir -p deps
cd deps

# Download lorawan module
git clone https://github.com/klementc/fuotaa.git
cd fuotaa
git checkout fb6de3d4cb2c02b6a95f2b1b93e4d42faff63d7d
cd ${curDir}