#!/bin/bash
set -e

# The install.sh script is the installation entrypoint for any features in this repository. 
#
# The tooling will parse the features.json + user devcontainer, and write 
# any build-time arguments into a feature-set scoped "features.env"
# The author is free to source that file and use it however they would like.
set -a
. ./features.env
set +a

# Build args are exposed to this entire feature set following the pattern:  _BUILD_ARG_<FEATURE ID>_<OPTION NAME>
GREETING=${_BUILD_ARG_HELLOWORLD_GREETING:-undefined}

tee /usr/hello.sh > /dev/null \
<< EOF
#!/bin/bash
RED='\033[0;91m'
NC='\033[0m' # No Color
echo -e "\${RED}${GREETING}, \$(whoami)!"
echo -e "\${NC}"
EOF

chmod +x /usr/hello.sh
sudo cat '/usr/hello.sh' > /usr/local/bin/hello
sudo chmod +x /usr/local/bin/hello
