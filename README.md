## Testing the current code locally

The flow was kept similar to the current matrix-org/meshsim instructions.


```
# Step 1: Get all pieces together

mkdir /tmp/meshsim
cd /tmp/meshsim

git clone https://github.com/valer-cara/meshsim-node-p2pd
git clone https://github.com/valer-cara/meshsim
git clone https://github.com/valer-cara/go-libp2p-daemon

docker build -t p2pd-meshsim -f ./meshsim-node-p2pd/Dockerfile .

docker network create --driver bridge mesh
HOST_IP=$(docker network inspect mesh -f "{{(index .IPAM.Config 0).Gateway}}")

# Step 2: Run

cd meshsim
pip install -r requirements.txt
./meshsim.py --node-provider libp2p $HOST_IP
```

Now meshsim is running on http://localhost:3000

Gotchas:

Add your nodes, wait for them to connect. _Click Bootstrap_ before
being able to send messages to ensure all nodes are properly instructed to peer
according to the visible topology.

