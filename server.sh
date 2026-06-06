#!/usr/bin/env bash
set -euo pipefail

cd /

if [ ! -d CSE231_Adv_OS/.git ]; then
    git clone https://github.com/Haardhik3981/CSE231_Adv_OS.git
fi

cd CSE231_Adv_OS
git fetch origin RRIP
git checkout RRIP
git pull --ff-only origin RRIP

if [ ! -d /root/miniconda3 ]; then
    wget -nc -O /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash /tmp/miniconda.sh -b -p /root/miniconda3
fi

source /root/miniconda3/etc/profile.d/conda.sh
export PATH="/root/miniconda3/bin:/root/miniconda3/condabin:$PATH"
conda update -n base -c defaults conda -y
conda install -n base conda-libmamba-solver -y
conda config --set solver libmamba
cd vllm_cache_bench
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r
chmod +x setup_env.sh
./setup_env.sh
