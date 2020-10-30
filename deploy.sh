docker build -t nagygao/multi-client:latest -t nagygao/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nagygao/multi-server:latest -t nagygao/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nagygao/multi-worker:latest -t nagygao/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nagygao/multi-client:latest
docker push nagygao/multi-server:latest
docker push nagygao/multi-worker:latest

docker push nagygao/multi-client:$SHA
docker push nagygao/multi-server:$SHA
docker push nagygao/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployments server=nagygao/multi-server:$SHA
kubectl set image deployments/client-deployments client=nagygao/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=nagygao/worker-client:$SHA