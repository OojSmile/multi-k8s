docker build -t oojsmile/multi-client:latest -t oojsmile/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t oojsmile/multi-server:latest -t oojsmile/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t oojsmile/multi-worker:latest -t oojsmile/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push oojsmile/multi-client:latest
docker push oojsmile/multi-server:latest
docker push oojsmile/multi-worker:latest 

docker push oojsmile/multi-client:$SHA
docker push oojsmile/multi-server:$SHA
docker push oojsmile/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=oojsmile/multi-client:$SHA
kubectl set image deployments/server-deployment server=oojsmile/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=oojsmile/multi-worker:$SHA