# Reverse-engineer Docker image to obtain Dockerfile
# This function does not generate Dockerfile from image, but shows all the commands
# used to build Docker image without FROM clause

function dc_trace_cmd() {
  local parent=`docker inspect -f '{{ .Parent }}' $1` 2>/dev/null
  declare -i level=$2
  echo ${level}: `docker inspect -f '{{ .ContainerConfig.Cmd }}' $1 2>/dev/null`
  level=level+1
  if [ "${parent}" != "" ]; then
    echo ${level}: $parent 
    dc_trace_cmd $parent $level
  fi
}


# Dump database schema and data to file
pg_dump -h localhost -p <port> -U <user> -d <database> > database.sql

# Create database from schema
psql -h localhost -p <port> -U <user> -d <database> < database.sql
