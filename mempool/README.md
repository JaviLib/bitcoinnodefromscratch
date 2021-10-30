# adding mempool.space

## directory structure

follow directory instructions from the mempool github and copy the mariadb-structure.sql file into the correct place




In an empty dir create 2 sub-dirs

```bash
mkdir -p data mysql/data mysql/db-scripts
```

In the `mysql/db-scripts` sub-dir add the `mariadb-structure.sql` file from the mempool repo

Your dir should now look like that:

```bash
$ls -R
.:
data mysql

./data:

./mysql:
data  db-scripts

./mysql/data:

./mysql/db-scripts:
mariadb-structure.sql
```


now add the services to your docker-compose

## database
```
mempool-db:
    image: mariadb:10.5.8
    user: "1000:1000"
    restart: on-failure
    stop_grace_period: 1m
    volumes:
      - ./mempool/mysql/data:/var/lib/mysql
      - ./mempool/mysql/db-scripts:/docker-entrypoint-initdb.d
    environment:
      MYSQL_DATABASE: "mempool"
      MYSQL_USER: "mempool"
      MYSQL_PASSWORD: "changethistosomethingsecure"
      MYSQL_ROOT_PASSWORD: "admin"
    networks:
      db:
```
mounting the volumes you created in the last step and adding a connection to the db network.
You will need to add this network if you did not already for the wordpress step

```
db:
    internal: true
```

## api
```
mempool-api:
    image: mempool/backend:latest
    user: "1000:1000"
    restart: on-failure
    stop_grace_period: 1m
    depends_on:
      - mempool-db
      - bitcoin
      - electrs
    command: "./wait-for-it.sh mempool-db:3306 --timeout=720 --strict -- ./start.sh"
    volumes:
      - ./mempool/data:/backend/cache
    environment:
      RPC_HOST: "10.19.0.10"
      RPC_PORT: "8332"
      RPC_USER: "testuser"
      RPC_PASS: "testpass"
      ELECTRUM_HOST: "electrs"
      ELECTRUM_PORT: "50001"
      ELECTRUM_TLS: "false"
      MYSQL_HOST: "mempool-db"
      MYSQL_PORT: "3306"
      MYSQL_DATABASE: "mempool"
      MYSQL_USER: "mempool"
      MYSQL_PASS: "changethistosomethingsecure"
      BACKEND_MAINNET_HTTP_PORT: "8999"
      CACHE_DIR: "/backend/cache"
      MEMPOOL_CLEAR_PROTECTION_MINUTES: "20"
    networks:
      db:
      bitcoinint:
```

the api container depends on bitcoin, electrs and our mempool-db,
- RPC_HOST is our bitcoind container
- ELECTRUM_HOST is our electrs container
- MYSQL_HOST is our mempool-db container
- CACHE_DIR is where we mount our /mempool/data

## frontend

```
mempool-web:
    image: mempool/frontend:latest
    user: "1000:1000"
    restart: on-failure
    stop_grace_period: 1m
    depends_on:
      - mempool-api
    command: "./wait-for mempool-db:3306 --timeout=720 -- nginx -g 'daemon off;'"
    ports:
      - 8080:8080
    expose:
      - 8080
    environment:
      FRONTEND_HTTP_PORT: "8080"
      BACKEND_MAINNET_HTTP_HOST: "mempool-api"
    networks:
      db:
      bitcoin:
      tor:
        ipv4_address: 10.6.0.44
```
the frontend depends on the api and exposes the mempool service on port 8080 at our chosen address

## expose via tor

add the ip and port to your torrc file

```
HiddenServiceDir /var/lib/tor/mempool/
HiddenServicePort 80 10.6.0.44:8080
```
