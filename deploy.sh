docker build -t christianlehre/multi-client:latest -t christianlehre/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t christianlehre/multi-server:latest -t christianlehre/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t christianlehre/multi-worker:latest -t christianlehre/multi-worker:$SHA -f ./worker/Dockerfile ./worker 

docker push christianlehre/multi-client:latest 
docker push christianlehre/multi-server:latest 
docker push christianlehre/multi-worker:latest 

docker push christianlehre/multi-client:$SHA
docker push christianlehre/multi-server:$SHA
docker push christianlehre/multi-worker:$SHA 

kubectl apply -f k8s 

kubectl set image deployments/server-deployment server=christianlehre/multi-server:$SHA 
kubectl set image deployments/client-deployment client=christianlehre/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=christianlehre/multi-worker:$SHA





