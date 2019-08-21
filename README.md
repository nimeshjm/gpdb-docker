# Greenplum gpdb in docker

This creates and runs a demo GPDB cluster in a single docker container.  The data directory is volume mounted on the host.
This is simply for testing purposes and is not for production use.

## Build

> docker build -t gpdb-demo-cluster .

## Pull
> docker pull nimeshjm/gpdb-demo

## Run

> docker run -d -p 127.0.0.1:15432:15432 --name gpdb-demo-cluster gpdb-demo-cluster
 
## Logs

> docker logs -f gpdb-demo-cluster

## Connect

> psql -h localhost -p 15432 -U gpadmin -d greenplum

### Client tools
> sudo apt-get install postgresql-client
