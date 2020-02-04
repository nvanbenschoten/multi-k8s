docker build -t nvanbenschoten/multi-client:latest -t nvanbenschoten/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t nvanbenschoten/multi-server:latest -t nvanbenschoten/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t nvanbenschoten/multi-worker:latest -t nvanbenschoten/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push nvanbenschoten/multi-client:latest
docker push nvanbenschoten/multi-server:latest
docker push nvanbenschoten/multi-worker:latest
docker push nvanbenschoten/multi-client:$GIT_SHA
docker push nvanbenschoten/multi-server:$GIT_SHA
docker push nvanbenschoten/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nvanbenschoten/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=nvanbenschoten/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=nvanbenschoten/multi-worker:$GIT_SHA
