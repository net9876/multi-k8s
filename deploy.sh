docker build -t net9876/multi-client:latest -t net9876/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t net9876/multi-server:latest -t net9876/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t net9876/multi-worker:latest -t net9876/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push net9876/multi-client:latest
docker push net9876/multi-server:latest
docker push net9876/multi-worker:latest
docker push net9876/multi-client:$SHA
docker push net9876/multi-server:$SHA
docker push net9876/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=net9876/multi-server:$SHA
kubectl set image deployments/client-deployment client=net9876/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=net9876/multi-worker:$SHA
